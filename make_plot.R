library(tidyverse)

top_songs <- read_rds("clean_data.rds")

billboard_plot <- ggplot(top_songs, aes(x = week, y = rank, color = song)) +
  geom_line(linewidth = 1.1) +
  geom_point(size = 1.5, alpha = 0.8) +
  scale_y_reverse(limits = c(100, 1), breaks = c(1, 10, 25, 50, 75, 100)) +
  scale_x_continuous(breaks = seq(0, 30, 5)) +
  labs(
    title = "The longest chart runs by #1 hits",
    subtitle = "Weekly Billboard Hot 100 position for the eight longest-charting songs that reached #1 in 2000",
    x = "Week on the chart",
    y = "Billboard rank",
    color = NULL
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 18),
    legend.position = "bottom",
    legend.text = element_text(size = 9),
    panel.grid.minor = element_blank()
  ) +
  guides(color = guide_legend(ncol = 2))

ggsave(
  filename = "billboard.png",
  plot = billboard_plot,
  width = 10,
  height = 7,
  dpi = 300
)
