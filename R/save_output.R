save_output <- function(df,folder, file, title, contact, source){
  
  # create folder
  if (!dir.exists(folder)){dir.create(folder)}
  
  # save datasets
  save(df, file = paste0(folder,"\\/",file,".rda"))
  write.csv(df,paste0(folder,"\\/",file,".csv"))
  
  # generate metadata
  sink(paste0(folder,"\\/",file,".txt"))
  cat("Title: ",title)
  cat("\nContact: ", contact)
  cat("\nSource: ", source, "\n\n")
  skim_with(numeric = list(hist = NULL), integer = list(hist = NULL))
  skim(df)
  sink()
  
  # create README
  sink(paste0(folder,"\\/README.md"))
  cat("Title: ",title)
  cat("\nContact: ", contact)
  cat("\nSource: ", source, "\n\n")
  skim(df)%>% kable()
  sink()
  
}
