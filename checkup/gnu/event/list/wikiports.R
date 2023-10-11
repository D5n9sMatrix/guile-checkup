#!/usr/bin/r
# Extract Parts of a POSIXt or Date Object
# Description
# Extract the weekday, month or quarter, or the Julian time (days since some origin). These are generic functions: the methods for the internal date-time classes are documented here.

# Usage
# weekdays(x, abbreviate)
# ## S3 method for class 'POSIXt'
# weekdays(x, abbreviate = FALSE)
# ## S3 method for class 'Date'
# weekdays(x, abbreviate = FALSE)

# months(x, abbreviate)
# ## S3 method for class 'POSIXt'
# months(x, abbreviate = FALSE)
# ## S3 method for class 'Date'
# months(x, abbreviate = FALSE)

# quarters(x, abbreviate)
# ## S3 method for class 'POSIXt'
# quarters(x, ...)
# ## S3 method for class 'Date'
# quarters(x, ...)

# julian(x, ...)
# ## S3 method for class 'POSIXt'
# julian(x, origin = as.POSIXct("1970-01-01", tz = "GMT"), ...)
# ## S3 method for class 'Date'
# julian(x, origin = as.Date("1970-01-01"), ...)
# Arguments
# x	
# an object inheriting from class "POSIXt" or "Date".

# abbreviate	
# logical vector (possibly recycled). Should the names be abbreviated?

# origin	
# an length-one object inheriting from class "POSIXt" or "Date".

# ...	
# arguments for other methods.

# Value
# weekdays and months return a character vector of names in the locale in use.

# quarters returns a character vector of "Q1" to "Q4".

# julian returns the number of days (possibly fractional) since the origin, with the origin as a "origin" attribute. All time calculations in R are done ignoring leap-seconds.

# Note
# Other components such as the day of the month or the year are very easy to compute: just use as.POSIXlt and extract the relevant component. Alternatively (especially if the components are desired as character strings), use strftime.

# See Also
# DateTimeClasses, Date

# Examples

p1 <- weekdays(.leap.seconds)
p2 <- months(.leap.seconds)
p3 <- quarters(.leap.seconds)

## Show how easily you get month, day, year, day (of {month, week, yr}), ... :
## (remember to count from 0 (!): mon = 0..11, wday = 0..6,  etc !!)

##' Transform (Time-)Date vector  to  convenient data frame :
dt2df <- function(dt, dName = deparse(substitute(dt)), stringsAsFactors = FALSE) {
    DF <- as.data.frame(unclass(as.POSIXlt( dt )), stringsAsFactors=stringsAsFactors)
    `names<-`(cbind(dt, DF, deparse.level=0L), c(dName, names(DF)))
}
## e.g.,
p4 <- dt2df(.leap.seconds)    # date+time
p5 <- dt2df(Sys.Date() + 0:9) # date

##' Even simpler:  Date -> Matrix - dropping time info {sec,min,hour, isdst}
d2mat <- function(x) simplify2array(unclass(as.POSIXlt(x))[4:7])
## e.g.,
p6 <- d2mat(seq(as.Date("2000-02-02"), by=1, length.out=30)) # has R 1.0.0's release date


## Julian Day Number (JDN, https://en.wikipedia.org/wiki/Julian_day)
## is the number of days since noon UTC on the first day of 4317 BC.
## in the proleptic Julian calendar.  To more recently, in
## 'Terrestrial Time' which differs from UTC by a few seconds
## See https://en.wikipedia.org/wiki/Terrestrial_Time
p7 <- julian(Sys.Date(), -2440588) # from a day
p8 <- floor(as.numeric(julian(Sys.time())) + 2440587.5) # from a date-time
