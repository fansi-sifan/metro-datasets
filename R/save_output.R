save_datasets <- function(..., folder, file) {
  # create folder
  if (!dir.exists(folder)) {
    dir.create(folder)
  }

  # save datasets in .rda and .csv
  x <- list(...)
  names(x) <- file
  save(list = names(x), file = paste0(folder, "\\/", file, ".rda"), envir = list2env(x))

  write_csv(..., paste0(folder, "\\/", file, ".csv"))
}


save_meta <- function(df, labels, folder, file, title, contact, source, note = "", apd = F) {
  # skimr::skim_with(numeric = list(hist = NULL), integer = list(hist = NULL))

  for (type in c(".txt", ".md")) {
    sink(paste0(folder, "\\/README", type), append = apd)

    cat("\nTitle: ", title, "\ \n")

    if (apd == F) {
      cat("\nContact: ", contact, "\ \n")
      cat("\nSource: ", source, "\ \n")
      cat("\nNote: ", note, "\ \n")
      cat("\nLast updated: ", date(), "\n\n")
    } else {
      cat("\n\n")
    }


    print(labels %>% knitr::kable())
    cat("\n\n")

    skimr::skim(df) %>% knitr::kable()
    sink()
  }
}
  

create_labels <- function(df) {
  sjlabelled::get_label(df) %>%
    data.frame() %>%
    mutate(names = colnames(df)) %>%
    rename("label" = ".")
}
