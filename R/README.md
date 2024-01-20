# yfR

Retrieve stock market data from the [Yahoo Finance](https://finance.yahoo.com/) [JSON API](https://developer.yahoo.com/api/).

The [yfR](https://docs.ropensci.org/yfR/index.html) package is the update of the [BatchGetSymbols](https://cran.r-project.org/web/packages/BatchGetSymbols/index.html) package (also on [GitHub](https://github.com/msperlin/BatchGetSymbols)).

## quantomod

Both packages rely on the [getSymbols](https://rdrr.io/cran/quantmod/man/getSymbols.html) function of [Joshua Ulrich](https://github.com/joshuaulrich)'s [quantmod](https://www.quantmod.com/) package.


## Improvements

As documented in the article [Differences from BatchGetSymbols](https://docs.ropensci.org/yfR/articles/diff-batchgetsymbols.html), the [yfR](https://docs.ropensci.org/yfR/index.html) package has several advantages, such as:

- consistent use of "snake_case" instead of "dot.case"

- function names follow common API notation (such as GET)

- The output of [yfR::yf_get()](https://docs.ropensci.org/yfR/reference/yf_get.html) is always a [tibble](https://tibble.tidyverse.org/) object instead of a [list](https://rdrr.io/r/base/list.html) object

- New and prettier status messages using the [cli](https://cli.r-lib.org/) package

## Warning

Never use Yahoo Finance data of individual stocks in production, in research papers or in academic documents such as theses or dissertations.

Yahoo Finance does not provide a consistent dividend database.

Hence adjusted stock prices for **individual assets** may not properly reflect the effects of corporate events such as stock splits or dividend payments.

Using the package for research on leading stock market indices should be fine, however.

A list of tickers is available at [https://finance.yahoo.com/world-indices](https://finance.yahoo.com/world-indices).

If adjusted price data of individual stocks is important for your research, **use other data sources** such as:

- [EOD](https://eodhd.com/)
- [SimFin](https://www.simfin.com/en/)
- [Economatica](https://economatica.com/)

## Citation

Perlin M (2023). yfR: Downloads and Organizes Financial Data from Yahoo Finance. R package version 1.1.0, https://github.com/ropensci/yfR. 