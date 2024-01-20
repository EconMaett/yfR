# 05 - Function reference ----

## All functions ----

library(yfR)

### yf_cachefolder_get() ----

# Returns the default folder for caching
print(yf_cachefolder_get())

# It is a temporary folder stored locally on your machine.


### yf_collection_get() ----

# Downloads a collection of data from Yahoo Finance.
# Available collections are
print(yf_get_available_collections())
# SP500, IBOV, FTSE, DOW, testthat-collection

# do_parallel is FALSE by default.
# Make sure you call future::plan() first.
# See https://furrr.futureverse.org/
# for details

df_yf <- yf_collection_get(
  collection = "DOW",
  first_date = Sys.Date() - 30,
  last_date  = Sys.Date()
)

print(df_yf)


### convert_to_wide() ----

# Transforms a long (stacked) tibble into a wide list of tibbles

print(df_yf)

l_wide <- yf_convert_to_wide(df_yf)

names(l_wide)

print(l_wide$price_adjusted)


### yf_get() ----

# Download financial data from Yahoo Finance

# You can define a threshold for bad data.
# The default is
# thresh_bad_data = 0.75
# If the percentage of non-missing dates with
# respect to thte benchmark ticker is lower than
# thresh_bad_data, the function will ignore the
# assets.

# The default benchmark asset used to compare dates is
# bench_ticker = "^GSPC"
# You should use the main stock index of the market
# from where the data is coming from.

# The default for the return type is
# type_return = "arit"
# for arithmetic returns.
# Use 
# type_return = "log" 
# for log returns.

# The default for how to aggregate the data using the
# first observations of the aggregating period or the last
# is how_to_aggregate = "last"
# The last available day of the year will be used for
# all aggregated values such as price_adjusted.


# The default for do_complete_data is FALSE.
# If TRUE, all missing ticker-date pairs will
# be replaced by NAs or the lcosest price.

# The cache_folder option is set to
# yfR::yf_cachefolder_get() by default.

# set do_parallel to TRUE but run
# future::plan() first.
# See https://furrr.futureverse.org/
# for details.

# be_quiet is set to FALSE by default.


# Be aware that when using a cache system in a 
# local folder, and not the default
# tempdir()
# the aggregate prices series might not match if 
# a stock split or dividends happen between cache files.

tickers    <- c("TSLA", "MMM")
first_date <- Sys.Date() - 30
last_date  <- Sys.Date()

df_yf <- yf_get(
  tickers    = tickers,
  first_date = first_date,
  last_date  = last_date
)

print(df_yf)


### yf_get_available_collections() ----

# Returns available collections

print(yf_get_available_collections(print_description = FALSE))
# SP500, IBOV, FTSE, DOW, testthat-collection

print(yf_get_available_collections(print_description = TRUE))

# SP500: The SP500 index (US MARKET) - Ticker = ^GSPC
# IBOV: The Ibovespa index (BR MARKET) - Ticker = ^BVSP
# FTSE: The FTSE index (UK MARKET) - Ticker = ^FTSE
# DOW: The DOW index (US MARKET) - Ticker = ^DJI
# testthat-collection: A (small) testing idnex for testthat
# -- dev stuff, don't use it!


### yf_get_dividends() ----

# Get Yahoo Finance Dividends from a single stock

# This function uses Yahoo Finance's JSON API
# to retrieve dividends.

yf_get_dividends(
  ticker = "PETR4.SA"
)

# Be aware that YF does not provide a consistend dividend
# database.
# Use this function with caution

# The default for first_date is Sys.Date() - 365
# and for last_date it is Sys.Date


### yf_index_composition() ----

# Get current composition of stock indices

df_sp500 <- yf_index_composition("SP500")
print(df_sp500)


### yf_index_list() ----

# Get available indices in package

# This function returns all available market indices
# that are registered in the package

indices <- yf_index_list()
print(indices)
# SP500, IBOV, FTSE, DOW, testthat-collection


### yf_live_prices() ----

# Yahoo Finance Live Prices

# This function uses Yahoo Finance's JSON API to
# retrieve live stock prices.

yfR::yf_live_prices("PETR4.SA")
# This is the current stock prices
# at the time the function was called.

# END