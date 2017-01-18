predictr<-function(isbn, id){
  library(RODBC)
  dbhandle <- odbcDriverConnect('driver={SQL Server};server=127.0.0.1;database=BookDB;trusted_connection=true')
  #get similar books
  simbk<-sqlQuery(dbhandle,
                  paste("select isbn2 from simij where isbn1=",
                        isbn,
                        " and isbn2 not in (select isbn from ratings where id=",
                        id,
                        ") and score>0.85",
                        sep="")
  )
  #for each similar book
  R<-NULL
  BK<-NULL
  for (i in 1:length(simbk[,1]))
  {
    #books similar
    sbksim<-NULL
    N<-NULL
    D<-NULL
    sbksim<-sqlQuery(dbhandle,
                     paste("select ISBN2 from simij where isbn1 =",
                           simbk[i,1],
                           " intersect select isbn from ratings where id=",
                           id,
                           sep = "")
    )
    for (j in 1:length(sbksim[,1]))
    {
      #get rating for the current user rated similar book
      ruj<-NULL
      ruj<-sqlQuery(dbhandle,
                    paste("select rating from ratings where isbn=",
                          sbksim[j,1],
                          " and id=",
                          id,sep = "")
      )
      #get similarity score between the two books
      simij<-NULL
      simij<-sqlQuery(dbhandle,
                      paste("select score from simij where ISBN1=",
                            simbk[i,1],
                            " and ISBN2=",
                            sbksim[j,1],
                            sep = "")
      )
      if(simij$score<0)
      {
        simij$score<-0.01
      }
      #multiply user rating and similarity score and append to Numerator
      N<-append(N,as.numeric(ruj$rating*simij$score))
      #append similarity to denominator
      D<-append(D,simij$score)
    }
    R<-append(R,as.numeric((sum(N))/(sum(D))))
    BK<-append(BK,simbk[i,1])
  }
  return(data.frame(isbn,BK,R))
  odbcCloseAll()
}