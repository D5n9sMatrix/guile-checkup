#!/usr/bin/r

# Express Table Entries as Fraction of Marginal Table
# Description
# Returns conditional proportions given margins, i.e. entries of x, divided by the appropriate marginal sums.

# Usage
# proportions(x, margin = NULL)
# prop.table(x, margin = NULL)
# Arguments
# x	
# table

# margin	
# a vector giving the margins to split by. E.g., for a matrix 1 indicates rows, 2 indicates columns, c(1, 2) indicates rows and columns. When x has named dimnames, it can be a character vector selecting dimension names.

# Value
# Table like x expressed relative to margin

# Note
# prop.table is an earlier name, retained for back-compatibility.

# Author(s)
# Peter Dalgaard

# See Also
# marginSums. apply, sweep are a more general mechanism for sweeping out marginal statistics.

# Examples

m1 <- matrix(1:4, 2)
m1
m2 <- proportions(m1, 1)
m2
DF <- as.data.frame(UCBAdmissions)
m4 <- xtabs(Freq ~ Gender + Admit, DF)
m5 <- proportions(m4, "Gender")
m5