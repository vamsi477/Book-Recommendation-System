computesim<-function()
{
  library(RODBC)
  dbhandle <- odbcDriverConnect('driver={SQL Server};server=127.0.0.1;database=BookDB;trusted_connection=true')
  #get isbn of all books in the db
  books<-sqlQuery(dbhandle,'select isbn from books order by isbn')
  BK1<-NULL
  BK2<-NULL
  SIM<-NULL
  #for first book
  for(i in 1:length(books[,1]))
  {
    #keeping count of books processed
    print(i)
    #for books to be compared to
    for(j in 1:length(books[,1]))
    {
      #check if book to be compared to is the same as the first book
      if(books[i,1]!=books[j,1])
      {
        #select all users who rated both books
        users<-sqlQuery(dbhandle,
                        paste("select id from ratings where isbn=",
                              books[i,1],
                              " intersect select id from ratings where isbn=",
                              books[j,1],sep="")
        )
        #check if any user has rated both books
        if(length(users[,1])>0)
        { 
          N<-NULL
          D1<-NULL
          D2<-NULL
          #for each user
          for(k in 1:length(users[,1]))
          {
            #select rating of first book
            rui<-NULL
            rui<-sqlQuery(dbhandle,
                          paste("select rating from ratings where isbn=",
                                books[i,1],
                                " and id=",
                                users[k,1],
                                sep = "")
            )
            #select rating of second book
            ruj<-NULL
            ruj<-sqlQuery(dbhandle,
                          paste("select rating from ratings where isbn=",
                                books[j,1],
                                " and id=",
                                users[k,1],
                                sep = "")
            )
            #select average rating given by user
            ravg<-NULL
            ravg<-sqlQuery(dbhandle,
                           paste("select avg(rating) as avgr from ratings where id=",
                                 users[k,1],
                                 sep = "")
            )
            if((rui$rating-ravg$avgr)<0 && (ruj$rating-ravg$avgr)<0)
            {
              N<-append(N,(-1)*(as.numeric(((rui$rating-ravg$avgr)*(ruj$rating-ravg$avgr)))))
            }
            else
            {
              N<-append(N,as.numeric(((rui$rating-ravg$avgr)*(ruj$rating-ravg$avgr))))
            }
            D1<-append(D1,((rui$rating-ravg$avgr)^2))
            D2<-append(D2,((ruj$rating-ravg$avgr)^2))
          }
          #check if similarity score is going to return 0 or nd
          if(sum(N)==0)
          {SIM<-append(SIM,0)}
          else
          {SIM<-append(SIM,(sum(N)/((sqrt(sum(D1)))*(sqrt(sum(D2))))))}
          BK1<-append(BK1,books[i,1])
          BK2<-append(BK2,books[j,1])
        }
      }
    }
  }
  res<-data.frame(BK1,BK2,SIM)
  sqlSave(dbhandle, res, tablename = "booksim2", rownames = FALSE)
  odbcCloseAll()
}