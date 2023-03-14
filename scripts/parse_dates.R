
library(tidyverse)
library(lubridate)
library(arrow)

# read --------------------------------------------------------------------


comments_in <- read_parquet(
  str_c("files/markdown/","100-hour-board-comments-md",".parquet")
)

questions_in <- read_parquet(
  str_c("files/markdown/","100-hour-board-questions-md",".parquet")
)

# parse -------------------------------------------------------------------

comments_in <- 
  comments_in |> 
  mutate(
    submission_info = str_remove_all(comment_info, "Question #\\d+ posted on "),
    submission_info = str_replace_all(submission_info, "midnight", "12:00 a.m."),
    submission_info = str_replace_all(submission_info, "noon", "12:00 p.m."),
    submission_info = str_replace_all(submission_info, "a.m.", "am"),
    submission_info = str_replace_all(submission_info, "p.m.", "pm"),
    submission_info = str_replace_all(submission_info, "posted on ", ""),
    submission_info = str_replace(
      submission_info, 
      "^\\d{2}/\\d{2}/\\d{4} \\d{1,2} [ap]m$", 
      str_c(str_sub(submission_info, 1, -4), ":00 ", str_sub(submission_info, -2, -1))
    ),
    posted_date = parse_date_time(submission_info, "m/d/Y H:M p", tz = "America/Denver"), 
    posted_date_utc = as_datetime(posted_date, tz = "utc"),
    posted_date = format(posted_date, "%Y-%m-%d %H:%M:%S %Z"),
    posted_date_utc = format(posted_date_utc, "%Y-%m-%d %H:%M:%S %Z")
  ) |> 
  select(-submission_info, -comment_info, -posted_date_utc)

questions_in <- 
  questions_in |> 
  mutate(
    submission_info = str_remove_all(question_info, "Question #\\d+ posted on "),
    submission_info = str_replace_all(submission_info, "midnight", "12:00 a.m."),
    submission_info = str_replace_all(submission_info, "noon", "12:00 p.m."),
    submission_info = str_replace_all(submission_info, "a.m.", "am"),
    submission_info = str_replace_all(submission_info, "p.m.", "pm"),
    submission_info = str_replace_all(submission_info, "posted on ", ""),
    submission_info = str_replace(
      submission_info, 
      "^\\d{2}/\\d{2}/\\d{4} \\d{1,2} [ap]m$", 
      str_c(str_sub(submission_info, 1, -4), ":00 ", str_sub(submission_info, -2, -1))
    ),
    posted_date = parse_date_time(submission_info, "m/d/Y H:M p", tz = "America/Denver"), 
    posted_date_utc = as_datetime(posted_date, tz = "utc"),
    posted_date = format(posted_date, "%Y-%m-%d %H:%M:%S %Z"),
    posted_date_utc = format(posted_date_utc, "%Y-%m-%d %H:%M:%S %Z")
  ) |> 
  select(-submission_info, -question_info, -posted_date_utc)

# chart -------------------------------------------------------------------

# questions_in |>
#   group_by(year = year(posted_date), month = month(posted_date)) |>
#   count() |>
#   ungroup() |>
#   mutate(dt = as_datetime(str_c(year,"-",month,"-01"))) |>
#   ggplot() +
#   geom_line(
#     aes(x = dt, y = n)
#   ) +
#   ggtitle("100 Hour Board question submission frequency over time") +
#   theme_minimal() +
#   theme(
#     axis.title = element_blank()
#   )
  
# comments_in |>
#   group_by(year = year(posted_date), month = month(posted_date)) |>
#   count() |>
#   ungroup() |>
#   mutate(dt = as_datetime(str_c(year,"-",month,"-01"))) |>
#   ggplot() +
#   geom_line(
#     aes(x = dt, y = n)
#   ) +
#   ggtitle("100 Hour Board question submission frequency over time") +
#   theme_minimal() +
#   theme(
#     axis.title = element_blank()
#   )
