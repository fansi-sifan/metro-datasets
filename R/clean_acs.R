clean_acs <- function(geography, variables, year=2017, span=5, key, short = FALSE, ...) {

  # pull data with get_acs function
  df <- get_acs(
    geography = geography,
    variables = variables,
    cache_table = TRUE,
    year = year,
    key = key,
    survey = paste0("acs", span), ...
  )

  # load descriptive labels for subject tables OR detailed tables
  suppressWarnings(
    if (str_detect(df$variable[1], "S")) {
      varkey <-
        load_variables(year, paste0("acs", span, "/subject"), cache = TRUE)
    } else {
      varkey <-
        load_variables(year, paste0("acs", span), cache = TRUE)
    }
  )


  # clean pulled data and rename columns to descriptive labels
  output <- varkey %>%
    filter(name %in% df$variable) %>%
    left_join(df, by = c("name" = "variable")) %>%
    select(-concept) %>%
    gather(key = "measure", value = "values", estimate, moe) %>%
    mutate(label = tolower(str_replace_all(label, "[[:punct:]]", " "))) %>%
    mutate(label = str_remove(label, "estimate")) %>%
    mutate(label = str_replace_all(label, " ", "_")) %>%
    unite(label, label, measure, sep = "_") %>%
    unite(label, name, label, sep = "_") %>%
    spread(key = label, value = values) %>%
    select_if(~ sum(!is.na(.)) > 0)
  
  set_label(output) <- names(output)

  if (short == TRUE) {
    names(output) <- stringr::str_replace(names(output), "__moe$", "_moe")
    names(output) <- stringr::str_replace(names(output), "__estimate$", "_estimate")

    names(output) <- gsub(".*__{1}", "\\1", names(output))

    names(output) <- make.unique(names(output), sep = "_")
  } else {
    names(output) <- gsub("___.*(_moe|_estimate)", "\\1", names(output)) # use original labels 
  }
  
  if (geography == "tract") {
    output <- output %>% rename(stcotr_code = GEOID,stcotr_name = NAME)}  else if (geo == "county"){
      output <- output%>% rename(stco_code = GEOID,stco_name = NAME)}else if (geo == "metropolitan statistical area/micropolitan statistical area"){
        output <- output %>% rename(cbsa_code = GEOID, cbsa_name = NAME)} else {
          output <- output
        }

  return(output)
}


