# 03 - Using collections ----
library(yfR)
library(tidyverse)
## Fetching collections of prices ----

# Collections are just a bundle of tickers pre-organized in the package.

# For example, the collection "SP500" represents the
# current composition of the S&P 500 index.

# The available collections are:
available_collections <- yfR::yf_get_available_collections(print_description = TRUE)

print(available_collections)
# "SP500"
# "IBOV"
# "FTSE"
# "DOW"
# "testthat-collection"

# You can download the composition of the collection
# with yf_collection_get()

# be patient, this takes a while
df_yf <- yf_collection_get("SP500")

head(df_yf)

# END