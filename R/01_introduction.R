# 01 - Introduction ----

## Motivation ----
# `yfR` facilitates the importing of stock prices from Yahoo finance, 
# organizing the data in the tidy format and speeding up the process 
# using a cache system and parallel computing.

# `yfR` is the second and backwards-compatible version of the `BatchGetSymbols` package.

# Yahoo Finance (YF) provides stock prices from around the globe.
# All you need is the ticker symbol, e.g. "GM" for General Motors and the first and last date.


## The Data ----
# The main function of the package is `yfR::yf_get()`
# and it returns a data frame with the financial data.

# All price data is measured at the unit of the financial exchange.

# Price data fro GM (NASDAQ/US) is measured in US Dollars,
# while price data for Petrobras, PETR3.SA (B3/BR)
# is measured in Brazilian Reais.


# The returned data frame contains the following columns:

# - ticker: the requested tickers (id of stocks)

# - ref_date: the reference day (or year/month/week, if freq_data is specified)

# - price_open: the opening price of the day/period

# - price_high: the highest price of the day/period

# - price_close: the close/last price of the day/period

# - volume: the volume of the day/period, in the unit of the exchange

# - price_adjusted: stock price adjusted for corporate events such as
#   stock splits, dividends, and others.
#   This is usually what you want/need to study stock prices
#   as it measures the real financial performance of
#   the stockholders

# - ret_adjusted_rpices: The arithmetic or log return
#   (see input type_return) for the adjusted stock prices

# - ret_adjusted_prices: the arithmetic or log return
#   (see input type_return) for the closing stock prices

# - cumret_adjusted_prices: the accumulated arithmetic or log
#   return for the period (starts at 100%).


## Finding tickers ----

# Find the tickers of a company's stock by searching 
# for it in Yahoo Finance's website.

# Note that a company may have many different stocks
# traded at different markets.

# Petrobras is traded at 
# - the New York Stock Exchange (NYQ)
# - the Sao Paulo/Brazil - B3 stock (SAO)
# - Buenos Aires/Argentina Exchange (BUE)

# all with different ticker symbols.

# For market indices, a list is available here:
# https://finance.yahoo.com/world-indices

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

# - Fetches daily/weekly/monthly/annual stock prices/returns
#   from Yahoo Finance and outputs a data frame (tibble) in 
#   the long format (stacked data)

# - A new feature called *collections* facilitates the download
#   of multiple tickers from a particular market/index.
#   For example, you can download data for all stocks in the
#   S&P500 index with `yf_collection_get("SP500")`

#  - A session-persistent smart cache system is available by default.
#   The data is saved locally and only missing portions are downloaded, if needed.

# - All dates are compared to a benchmark ticker such as "SP500" and, 
#   whenever an individual asset does not have a sufficient number of dates, 
#   the software drops it from the output.
#   This means you can choose to ignore tickers with a high proportion of missing dates.

# - A customized function called `yf_convert_to_wide()`
#   can transform the long tibble into the wide format, with tickers as columns.
#   This is helpful in portfolio optimization.
#   The output is a list() where each element is a 
#   different target variable (prices, returns, volumes).

# - Parallel computing with the `furrr` package is available,
#   speeding up the data importation process.


## Warnings ----

# Yahoo Finance data is far from perfectly reliable, especially for individual stocks.

# Using it for research code with stock indices is fine,
# but adjusted stock prices for individual assets
# is messy as stock events such as splits or dividends
# are not always properly registered.

# Ideally, you should never use Yahoo Finance data 
# for individual stocks in research papers or academic documents.

# For these purposes, try one of the following data sources:

# - EOD: https://eodhd.com/
# - SimFin: https://www.simfin.com/
# - Economatica: https://economatica.com/


## Installation ----

# Install the stable release from CRAN with
# install.packages("yfR")

# The development version from GitHub with
# devtools::install_github("ropensci/yfR")

# or from rOpenSci with
# install.packages("yfR", repos = "https://ropensci.r-universe.dev")


## A simple example of usage ----
library(yfR)

# set options for algorithm
my_ticker  <- "DJT" # META
first_date <- Sys.Date() - 30
last_date  <- Sys.Date()

# fetch data
df_yf <- yf_get(
  tickers    = my_ticker,
  first_date = first_date,
  last_date  = last_date
)

# output is a tibble() 
print(df_yf)


## Acknowledgements ----

# The yfR package is based on `quantmod` by Joshua Ulrich https://www.quantmod.com/
# and it uses the function `quantmod::getSymbols()` to fetch raw data from Yahoo Finance.

# END