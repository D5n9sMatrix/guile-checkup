#!/usr/bin/r

# Time (Series) Windows
# Description
# window is a generic function which extracts the subset of the object x observed between the times start and end. If a frequency is specified, the series is then re-sampled at the new frequency.

# Usage
# window(x, ...)
# ## S3 method for class 'ts'
# window(x, ...)
# ## Default S3 method:
# window(x, start = NULL, end = NULL,
#       frequency = NULL, deltat = NULL, extend = FALSE, ts.eps = getOption("ts.eps"), ...)

# window(x, ...) <- value
# ## S3 replacement method for class 'ts'
# window(x, start, end, frequency, deltat, ...) <- value
# Arguments
# x	
# a time-series (or other object if not replacing values).

# start	
# the start time of the period of interest.

# end	
# the end time of the period of interest.

# frequency, deltat	
# the new frequency can be specified by either (or both if they are consistent).

# extend	
# logical. If true, the start and end values are allowed to extend the series. If false, attempts to extend the series give a warning and are ignored.

# ts.eps	
# time series comparison tolerance. Frequencies are considered equal if their absolute difference is less than ts.eps.

# ...	
# further arguments passed to or from other methods.

# value	
# replacement values.

# Details
# The start and end times can be specified as for ts. If there is no observation at the new start or end, the immediately following (start) or preceding (end) observation time is used.

# The replacement function has a method for ts objects, and is allowed to extend the series (with a warning). There is no default method.

# Value
# The value depends on the method. window.default will return a vector or matrix with an appropriate tsp attribute.

# window.ts differs from window.default only in ensuring the result is a ts object.

# If extend = TRUE the series will be padded with NAs if needed.

# References
# Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole.

# See Also
# time, ts.

# Examples

c9 <- window(presidents, 1960, c(1969,4)) # values in the 1960's
c10 <- window(presidents, deltat = 1)  # All Qtr1s
c11 <- window(presidents, start = c(1945,3), deltat = 1)  # All Qtr3s
c12 <- window(presidents, 1944, c(1979,2), extend = TRUE)

pres <- window(presidents, 1945, c(1949,4)) # values in the 1940's
c13 <- window(pres, 1945.25, 1945.50) <- c(60, 70)
c14 <- window(pres, 1944, 1944.75) <- 0 # will generate a warning
c15 <- window(pres, c(1945,4), c(1949,4), frequency = 1) <- 85:89
c16 <- pres