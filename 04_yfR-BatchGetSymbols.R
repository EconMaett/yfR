# 04 - yfR and BatchGetSymbols ----

## Differences from BatchGetSymbols ----

# The package BatchGetSymbols was developed in 2016.

# Here are the main differences between the new yfR
# package and the old BatchGetSymbols package:

# - All inputs are now formatted as snake_case instead
#   of dot.case.
#   The argument of yfR::yf_get() is first_date, not
#   first.date as in BatchGetSymbols::BatchGetSymbols().

# - The new *collection" feature allows for the download
#   of a collection of tickers.
#   To download price data for all components of the 
#   S&P 500 index, simply call
#   yfR::yf_collection_get("SP500")

# - All functions have been renamed for a common API notation.
#   For example,
#   BatchGetSymbols::BatchGetSymbols() 
#   is now
#   yfR::yf_get()
#   Likewise, the function for fetching collections is 
#   yfR::yf_collection_get()

# - The output of 
#   yfR::yf_get()
#   is always a tibble() object with the price data
#   and not a list() object as in
#   BatchGetSymbols::BatchGetSymbols().

#   If one wants the tibble() with a summary of the
#   importing process, this is available as an
#   attribute of the output with
#   base::attributes()

# - New and prettier status messages through 
#   the cli package.

# END