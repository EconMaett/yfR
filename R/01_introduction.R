# 01 - Introduction ----
library(yfR)
library(tidyverse)
Sys.setlocale("LC_TIME", "English")
fig_path <- "figures/"

## Motivation ----
# `yfR::yf_get()` imports stock prices from Yahoo Finance (YF) in tidy format and speeding up the process 
# with a cache system and parallel computing.
# It is the second and backwards-compatible version of`BatchGetSymbols`.

## The Data ----
# All price data is measured at the unit of the financial exchange.
# Price data fro GM (NASDAQ/US) is measured in US Dollars,
# while price data for Petrobras, PETR3.SA (B3/BR) is measured in Brazilian Reais.

# The returned tibble contains the following columns:
# - `ticker`:                 Requested tickers (id of stocks)
# - `ref_date`:               Reference day (or year/month/week, if `freq_data` is specified)
# - `price_open`:             Opening price of the day/period
# - `price_high`:             Highest price of the day/period
# - `price_close`:            Close/last price of the day/period
# - `volume`:                 Volume of the day/period, in the unit of the exchange
# - `price_adjusted`:         Stock price adjusted for corporate events like stock splits, dividends, and others.
# - `ret_adjusted_rpices`:    Arithmetic or log return (see input `type_return`) for the adjusted stock prices
# - `ret_adjusted_prices`:    Arithmetic or log return (see input `type_return`) for the closing stock prices
# - `cumret_adjusted_prices`: Accumulated arithmetic or log return for the period (starts at 100%).

#`price_adjusted` measures the real financial performance of the stockholders

## Finding tickers ----
# Find the tickers of a company's stock by searching for it in Yahoo Finance's website.
# Note that a company may have many different stocks traded at different markets.
# Petrobras is traded at: 
# - the New York Stock Exchange (NYQ)
# - the Sao Paulo/Brazil - B3 stock (SAO)
# - Buenos Aires/Argentina Exchange (BUE)
# all with different ticker symbols.

# Market indices: https://finance.yahoo.com/world-indices
# Name                          - Symbol
# S&P 500                       - GSPC
# Dow Jones Inudstrial Average  - DJI
# NASDAQ Composite              - IXIC
# CBOE UK 100                   - BUK100P
# Russell 2000                  - RUT
# CBOE Volatility Index         - VIX
# FTSE 100                      - FTSE
# DAX Perfromance Index         - GDAXI
# CAC 40                        - FCHI
# Euro Stoxx50                  - STOXX50E
# Euronext 100 Index            - N100
# MOEX Russia Index             - IMOEX.ME
# Nikkei 225                    - N225
# Han Seng Index                - HSI

## Features of yfR ----
# - Fetches daily/weekly/monthly/annual stock prices/returns from Yahoo Finance and 
#   outputs a data frame (tibble) in the long format (stacked data)
# - Collections download multiple tickers from a particular market/index.
#   All stocks in the S&P500 index: `yf_collection_get("SP500")`
# - A cache system is available by default. Data is saved locally and only missing portions are downloaded.
# - Dates are compared to a benchmark ticker like "SP500" and if an individual asset does not have 
#   a sufficient number of dates, the software drops it from the output.
#   This means you can choose to ignore tickers with a high proportion of missing dates.
# - `yf_convert_to_wide()` transforms the long tibble into the wide format, with tickers as columns.
# - Parallel computing with the `furrr` package is available.

## Warnings ----
# Yahoo Finance data is far from perfectly reliable, especially for individual stocks.
# Using it for research code with stock indices is fine, but adjusted stock prices for individual assets
# is messy as stock events such as splits or dividends are not always properly registered.

# Ideally, you should never use Yahoo Finance data for individual stocks in research papers or academic documents.
# For these purposes, try one of the following data sources:
# - EOD: https://eodhd.com/
# - SimFin: https://www.simfin.com/
# - Economatica: https://economatica.com/


## A simple example of usage ----
# Set options for algorithm
my_ticker  <- "DJT" 
first_date <- Sys.Date() - 2*30
last_date  <- Sys.Date()

# Fetch data
df_yf <- yf_get(tickers = my_ticker, first_date, last_date)

# Output is a tibble() 
print(df_yf)

# Plot the data
df_yf |> 
  select(date = ref_date, price = price_close) |> 
  ggplot(mapping = aes(x = date, y = price)) +
  geom_step(lwd = 1.2) +
  theme_light() +
  labs(
    title = "$DJT",
    subtitle = "Adjusted closing price",
    caption = "Source: Yahoo Finance",
    x = NULL, y = NULL
  ) +
  scale_y_continuous(limits = c(0, 70), breaks = seq(0, 70, 10)) +
  scale_x_date(date_breaks = "1 month", date_labels = "%Y-%b")

ggsave(filename = "01_djt.png", path = fig_path, height = 6, width = 10, bg = "white")
graphics.off()

## Acknowledgements ----
# `yfR` uses the`quantmod::getSymbols()` by Joshua Ulrich https://www.quantmod.com/.
# END