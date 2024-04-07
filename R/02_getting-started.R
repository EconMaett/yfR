# Getting started ----
library(yfR)
library(tidyverse)
Sys.setlocale("LC_TIME", "English")
fig_path <- "figures/"

## Examples ----
# Here you find a series of example calls to `yfR::yf_get()`
# The steps of the algorithm are:
#   1) Check cache files for existing data
#   2) If not in cache, fetch stock prices from Yahoo Finance and clean up the raw data
#   3) Write cache file if not available
#   4) Calculate all returns
#   5) Build diagnostics
#   6) Return the data to the user

## Fetching a single stock price ----
# Set options for algorithm
my_ticker  <- "TSLA"
first_date <- Sys.Date() - 30
last_date  <- Sys.Date()

# Fetch data
df_yf <- yf_get(tickers    = my_ticker, first_date, last_date)

# Output is a tibble() object
print(df_yf)

# A summary of the importing process is available in the output's attributes
base::attributes(df_yf)$df_control

## Fetching many stock prices ----
my_ticker  <- c("TSLA", "GM", "MMM")
first_date <- Sys.Date() - 100
last_date  <- Sys.Date()

df_yf_multiple <- yf_get(tickers = my_ticker, first_date, last_date)

p <- ggplot(data = df_yf_multiple, mapping = aes(x = ref_date, y = price_adjusted, color = ticker)) +
  geom_line(linewidth = 1.2) +
  labs(
    title = "Stock prices from Yahoo Finance",
    subtitle = "Adjusted for stock splits and dividends",
    caption = "Source: Yahoo Finance",
    x = NULL, y = NULL
  ) +
  theme_minimal() +
  theme(
    legend.title = element_blank(),
    legend.position = "top"
  )

print(p)

ggsave(filename = "02-multiple-stocks.png", path = fig_path, height = 6, width = 10, bg = "white")
graphics.off()

## Fetching daily/weekly/monthly/yearly price data ----
my_ticker  <- "GE"
first_date <- "2005-01-01"
last_date  <- Sys.Date()

df_daily <- yf_get(tickers = my_ticker, first_date, last_date, freq_data = "daily") |> 
  mutate(freq = "daily")

df_weekly <- yf_get(tickers = my_ticker, first_date, last_date, freq_data = "weekly") |> 
  mutate(freq = "weekly")

df_monthly <- yf_get(tickers = my_ticker, first_date, last_date, freq_data  = "monthly") |> 
  mutate(freq = "monthly")

df_yearly <- yf_get(
  tickers = my_ticker, first_date, last_date, freq_data = "yearly") |> 
  mutate(freq = "yearly")

# Bind it all together for plotting
df_allfreq <- bind_rows(list(df_daily, df_weekly, df_monthly, df_yearly)) |> 
  mutate(freq = factor(freq, levels = c("daily", "weekly", "monthly", "yearly")))

p <- ggplot(data = df_allfreq, mapping = aes(x = ref_date, y = price_adjusted)) +
  geom_line(linewidth = 1.2) +
  facet_grid(freq ~ ticker) +
  theme_minimal() +
  labs(x = "", y = "Adjusted prices")

print(p)

ggsave(filename = "02-multiple-frequencies.png", path = fig_path, height = 8, width = 10, bg = "white")
graphics.off()

## Changing format to wide ----
my_ticker  <- c("TSLA", "GM", "MMM")
first_date <- Sys.Date() - 100
last_date  <- Sys.Date()

df_yf_multiple <- yf_get(tickers = my_ticker, first_date, last_date)
print(df_yf_multiple)

# Convert to wide format
l_wide <- yf_convert_to_wide(df_yf_multiple)

names(l_wide)

prices_wide <- l_wide$price_adjusted

print(prices_wide)
# ref_date GM MMM TSLA

# END