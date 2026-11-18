library(tidyverse)

top_hits <- billboard |>
  rowwise() |>
  mutate(
    peak_rank = min(c_across(starts_with("wk")), na.rm = TRUE),
    weeks_on_chart = sum(!is.na(c_across(starts_with("wk"))))
  ) |>
  ungroup() |>
  filter(peak_rank == 1) |>
  slice_max(weeks_on_chart, n = 8) |>
  mutate(song = paste(artist, track, sep = " - "))

top_songs <- top_hits |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    names_prefix = "wk",
    values_to = "rank",
    names_transform = as.integer
  ) |>
  filter(week <= 30, !is.na(rank))

  write_rds(top_songs, file = "clean_data.rds")
  