#!/usr/bin/r

# Calculate Contour Lines
# Description
# Calculate contour lines for a given set of data.

# Usage
# contourLines(x = seq(0, 1, length.out = nrow(z)),
#              y = seq(0, 1, length.out = ncol(z)),
#              z, nlevels = 10,
#              levels = pretty(range(z, na.rm = TRUE), nlevels))
# Arguments
# x, y	
# locations of grid lines at which the values in z are measured. These must be in ascending order. By default, equally spaced values from 0 to 1 are used. If x is a list, its components x$x and x$y are used for x and y, respectively. If the list has component z this is used for z.

# z	
# a matrix containing the values to be plotted (NAs are allowed). Note that x can be used instead of z for convenience.

# nlevels	
# number of contour levels desired iff levels is not supplied.

# levels	
# numeric vector of levels at which to draw contour lines.

# Details
# contourLines draws nothing, but returns a set of contour lines.

# There is currently no documentation about the algorithm. The source code is in ‘R_HOME/src/main/plot3d.c’.

# Value
# A list of contours, each itself a list with elements:

# level	
# The contour level.

# x	
# The x-coordinates of the contour.

# y	
# The y-coordinates of the contour.

# See Also
# options("max.contour.segments") for the maximal complexity of a single contour line.

# contour: Its ‘Examples’ demonstrate how contourLines() can be drawn and are the same (as those from contour()).

# Examples

x1 <- 10*1:nrow(volcano)
y1 <- 10*1:ncol(volcano)
m6 <- contourLines(x1, y1, volcano)
## summarize the sizes of each the contour lines :
v1 <- cbind(lev = vapply(m6, `[[`, .5, "level"),
       n  = vapply(v1, function(l) length(l$x), 1))

out1 <- outer(-9:25, -9:25)
p9 <- pretty(range(out1), 10) # -300 -200 ... 600 700
p10 <- utils::str(p11 <- contourLines(out1))
   # no segments for {-300, 700};
   #  2 segments for {-200, -100, 0}
   #  1 segment  for  100:600