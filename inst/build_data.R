
grantham <- readr::read_tsv("https://gist.githubusercontent.com/danielecook/501f03650bca6a3db31ff3af2d413d2a/raw/5583a134b36b60762be6cd54002a0f4044338cd0/grantham.tsv") %>%
  dplyr::rename(from=FIRST) %>%
  tidyr:: gather(to,SCORE, -from) %>% dplyr::filter(score > 0)


matrix_list <- readr::read_tsv("https://gist.githubusercontent.com/danielecook/7c43e2aab4f8e7a4d2ddd68e9ba1c204/raw/fb6260078acae793c69349053371fa55470e736c/substitution_matrices.tsv", col_names = "matrix")

fetch_matrix <- function(name) {
  print(name)
  url <- paste0("ftp://ftp.ncbi.nih.gov/blast/matrices/", name)
  aa_names <- strsplit("ARNDCQEGHILKMFPSTWYVBZX*", split="")[[1]]
  data.table::fread(url, col.names = c("from", aa_names)) %>%
  tidyr:: gather(to, score, -from) %>%
  dplyr::distinct()
}

sapply(matrix_list$matrix[19:length(matrix_list$matrix)], function(name) {
  m <- fetch_matrix(name)
  assign(name, m)
  eval(substitute(use_data(name, overwrite = T), list(name = as.name(name))))
})


# Save Datasets
devtools::use_data(grantham, internal = F, overwrite = T)

eval(interp(devtools::use_data(m), m = name))
