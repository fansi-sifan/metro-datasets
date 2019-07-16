clean_acs <- function(geography, variables, year, span, key, ...) {
  
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
    if (str_detect(variables, "S")) {
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
    rename(stco_code = GEOID,
           stco_name = NAME) %>%
    select_if(~sum(!is.na(.)) > 0)
  
  
  return(output)
  
}
