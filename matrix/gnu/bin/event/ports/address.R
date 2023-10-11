#!/usr/bin/r

# Add or Drop All Possible Single Terms to a Model
# Description
# Compute all the single terms in the scope argument that can be added to or dropped from the model, fit those models and compute a table of the changes in fit.

# Usage
# add1(object, scope, ...)

# ## Default S3 method:
# add1(object, scope, scale = 0, test = c("none", "Chisq"),
#      k = 2, trace = FALSE, ...)

# ## S3 method for class 'lm'
# add1(object, scope, scale = 0, test = c("none", "Chisq", "F"),
#      x = NULL, k = 2, ...)

# ## S3 method for class 'glm'
# add1(object, scope, scale = 0,
#      test = c("none", "Rao", "LRT", "Chisq", "F"),
#      x = NULL, k = 2, ...)

# drop1(object, scope, ...)

# ## Default S3 method:
# drop1(object, scope, scale = 0, test = c("none", "Chisq"),
#       k = 2, trace = FALSE, ...)

# ## S3 method for class 'lm'
# drop1(object, scope, scale = 0, all.cols = TRUE,
#       test = c("none", "Chisq", "F"), k = 2, ...)

# ## S3 method for class 'glm'
# drop1(object, scope, scale = 0,
#       test = c("none", "Rao", "LRT", "Chisq", "F"),
#       k = 2, ...)
# Arguments
# object	
# a fitted model object.

# scope	
# a formula giving the terms to be considered for adding or dropping.

# scale	
# an estimate of the residual mean square to be used in computing Cp. Ignored if 0 or NULL.

# test	
# should the results include a test statistic relative to the original model? The F test is only appropriate for lm and aov models or perhaps for glm fits with estimated dispersion. The Chisq test can be an exact test (lm models with known scale) or a likelihood-ratio test or a test of the reduction in scaled deviance depending on the method. For glm fits, you can also choose "LRT" and "Rao" for likelihood ratio tests and Rao's efficient score test. The former is synonymous with "Chisq" (although both have an asymptotic chi-square distribution). Values can be abbreviated.

# k	
# the penalty constant in AIC / Cp.

# trace	
# if TRUE, print out progress reports.

# x	
# a model matrix containing columns for the fitted model and all terms in the upper scope. Useful if add1 is to be called repeatedly. Warning: no checks are done on its validity.

# all.cols	
# (Provided for compatibility with S.) Logical to specify whether all columns of the design matrix should be used. If FALSE then non-estimable columns are dropped, but the result is not usually statistically meaningful.

# ...	
# further arguments passed to or from other methods.

# Details
# For drop1 methods, a missing scope is taken to be all terms in the model. The hierarchy is respected when considering terms to be added or dropped: all main effects contained in a second-order interaction must remain, and so on.

# In a scope formula . means ‘what is already there’.

# The methods for lm and glm are more efficient in that they do not recompute the model matrix and call the fit methods directly.

# The default output table gives AIC, defined as minus twice log likelihood plus 2p where p is the rank of the model (the number of effective parameters). This is only defined up to an additive constant (like log-likelihoods). For linear Gaussian models with fixed scale, the constant is chosen to give Mallows' Cp, RSS/scale + 2p - n. Where Cp is used, the column is labelled as Cp rather than AIC.

# The F tests for the "glm" methods are based on analysis of deviance tests, so if the dispersion is estimated it is based on the residual deviance, unlike the F tests of anova.glm.

# Value
# An object of class "anova" summarizing the differences in fit between the models.

# Warning
# The model fitting must apply the models to the same dataset. Most methods will attempt to use a subset of the data with no missing values for any of the variables if na.action = na.omit, but this may give biased results. Only use these functions with data containing missing values with great care.

# The default methods make calls to the function nobs to check that the number of observations involved in the fitting process remained unchanged.

# Note
# These are not fully equivalent to the functions in S. There is no keep argument, and the methods used are not quite so computationally efficient.

# Their authors' definitions of Mallows' Cp and Akaike's AIC are used, not those of the authors of the models chapter of S.

# Author(s)
# The design was inspired by the S functions of the same names described in Chambers (1992).

# References
# Chambers, J. M. (1992) Linear models. Chapter 4 of Statistical Models in S eds J. M. Chambers and T. J. Hastie, Wadsworth & Brooks/Cole.

# See Also
# step, aov, lm, extractAIC, anova

# Examples

require(graphics); require(utils)
## following example(swiss)
lm1 <- lm(Fertility ~ ., data = swiss)
lm2 <- add1(lm1, ~ I(Education^2) + .^2)
lm3 <- drop1(lm1, test = "F")  # So called 'type II' anova

## following example(glm)

lm4 <- drop1(lm1, test = "Chisq")
lm5 <- drop1(lm1, test = "F")
lm6 <- add1(lm1, scope = ~ I(Education^2) + .^2) ## Pearson Chi-square