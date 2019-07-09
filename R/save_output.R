save_output <- function(df,labels,folder, file, title, contact, source){
  
  # create folder
  if (!dir.exists(folder)){dir.create(folder)}
  
  # save datasets

  save(df, file = paste0(folder,"\\/",file,".rda"))
  write_csv(df,paste0(folder,"\\/",file,".csv"))
  
  # generate metadata
  sink(paste0(folder,"\\/",file,".txt"),append = F)
  cat("Title: ",title)
  cat("\nContact: ", contact)
  cat("\nSource: ", source)
  cat("\nLast updated: ", date(), "\n\n")

  print(labels%>%kable())
  cat("\n\n")

  skimr::skim_with(numeric = list(hist = NULL), integer = list(hist = NULL))
  skimr::skim(df)%>%kable()
  
  sink()
  
  # create README
  sink(paste0(folder,"\\/README.md"),append = F)
  
  cat("Title: ",title)
  cat("\nContact: ", contact)
  cat("\nSource: ", source)
  cat("\nLast updated: ", date(), "\n\n")
  
  print(labels%>%kable())
  cat("\n\n")
  
  skimr::skim(df)%>% kable()
  sink()
  
}
