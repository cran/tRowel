## ----global, include=FALSE----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

#setwd("/Users/gwen/Desktop/tRowel") #change this to your own file path

## ----load tRowel--------------------------------------------------------------
library(tRowel)

## ----import data--------------------------------------------------------------
data(testPit, package = "tRowel")
data(testElevation, package = "tRowel")

## ----munsling with testPit----------------------------------------------------
testPit_withMun <- munsling(testPit, munsellCol = "Munsell")

## ----ratio1-------------------------------------------------------------------
testPit_withRatio <- ratioRustler(df = testPit, numerator = "Fe",denominator = "Ca", new_col = "MyRatio", 
removeNAs = TRUE)


## ----ratio2-------------------------------------------------------------------
nums <- list(c("Fe","Ca"),"Al", "Si")
denoms <- list("K","P",c("Sr","Fe"))

#Create the following ratios: (Fe+Ca)/K, Al/P, and Si/(Sr+Fe)
testPit_withRatio <- ratioRustler(df = testPit, numerator = nums, denominator = denoms, new_col = NULL, 
removeNAs = TRUE)


## ----terra--------------------------------------------------------------------
#filter for one profile
testPitP5 <- dplyr::filter(testPit, ProfileID == "Profile_5")

terraP5 <- terraTrend(testPitP5,depth = "Depth_cm_Start",max_depth = 140,proxies = c("Ca","Mg"),measurement_lab = "PPM", linecolors = c("green","blue"),legendtitle = "Elements",depth_lab = "Depth (cm)")

terraP5


## ----buriedBar examples-------------------------------------------------------
#filter for one profile
testPitP5 <- dplyr::filter(testPit, ProfileID == "Profile_5")

buriedP5 <- buriedBar(testPitP5, proxies = c("OrganicC_pct","Carbonate_pct"), depth = "Depth_cm_Start", title = "LOI", max_depth = 140, measurement_lab = "% of sample", legendtitle= "Proxies", barcolors = c("purple","orange")) 

buriedP5

#add panel example



## ----loam---------------------------------------------------------------------
#filter for one profile
testPitP5 <- dplyr::filter(testPit, ProfileID == "Profile_5")

loamP5 <- loamRanger(testPitP5, depth = "Depth_cm_Start", sand = "Sand_pct", silt = "Silt_pct", sandcolor = "blue", siltcolor = "green", claycolor = "purple", mindepth=0, title = "Texture of Profile 5")

loamP5


## ----groundTruth ex-----------------------------------------------------------
#download example image
file_path <- system.file("extdata", "groundTruth.png", package = "tRowel")

#save to figure name
soilpic <- groundTruth(file_path, imageformat = "png", width = 10, height = 10, WHratio = 1)

## ----paleoPanel ex------------------------------------------------------------
#No groundTruth image:
paleoPanel(terraP5,buriedP5,loamP5,cols = 3,border=TRUE) 

#With groundTruth
paleoPanel(terraP5,buriedP5,loamP5,cols = 3,profile = soilpic,plotwidths = c(1,3))



## ----clastCluster Example, eval = FALSE---------------------------------------
# #Example using Euclidean distance and PCA
# library(dplyr)
# testPitM <- testPit_withMun
# testPitM <- select(testPitM, -c(Munsell) )
# 
# EuclidExample <- clastCluster(dirtdata = testPitM, distance = "E", depthStart = "Depth_cm_Start", depthEnd = "Depth_cm_End",
#   profile = "ProfileID", ordination = TRUE, plot = TRUE, maxDepth = 150, depthticks = 10)
# 
# 4#For the number of clusters to select
# 
# EuclidExample
# 
# #Example using Gower's distance and PCoA
# # testPit2 <- testPit
# # testPit2 <- select(testPit2, -c(SampleID) )
# GowerExample <- clastCluster(dirtdata = testPitM, distance = "G",depthStart = "Depth_cm_Start", depthEnd = "Depth_cm_End",
#    minK = 2, maxK=8, profile = "ProfileID", ordination = TRUE, plot = TRUE, plotTitle="Cluster Analysis of Arroyo Profiles",
#    maxDepth = 150, depthticks = 10)
# 
# 4#For the number of clusters to select
# 
# GowerExample

## ----terrace ex, eval = FALSE-------------------------------------------------
# terraceWrangler(clastData = EuclidExample$data, elevData = testElevation,surfaceElevM = "surfaceElevM",profileClast = "ProfileID",profileElev = "ProfileID")
# 
# 

