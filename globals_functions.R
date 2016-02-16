# preliminaries: loading libraries and changing workspace
library(gridExtra)
library(crqa)
library(lme4)
library(ggplot2)
library(pander)

# create affective categories using SPAFF codes
neg = c('contempt' , 'criticism' , 'stonewalling' , 'belligerence' , 'defensiveness' , 'domineering' , 'anger')
pos = c('affection', 'enthusiasm' , 'humor')
val = c('backchannels' , 'direct expressions of understanding' , 'sentence finishing ' , 'paraphrasing' , 'mirroring with validation'  , 'apologizing' , 'identification' , 'acknowledging different point of view')
int = c('mirroring with interest' , 'positive nonverbal attention' , 'open-ended questions' , 'elaboration and clarification seeking')

################## Data import and preparation. ################################

wsz = 30 # width of the diagonal recurrence profile
'%!in%' <- function(x,y)!('%in%'(x,y))

# read in dyads' metadata
a = read.csv('Key Grouping Variables.csv')
a = a[!is.na(a[,1]),] # remove NA categories
a = a[a$ID!=1,]

# choose all or subset of dyads
dyads = a
totalPool = unique(a$ID)

# create frame for data
drps = data.frame()
descriptives = data.frame()
#max_lag_loc = c()
#max_rr = c()

# create the values for the quadratic analyses
raw = -wsz:wsz
timeVals = data.frame(raw)
t <- poly(1:(wsz*2+1), 2)
timeVals[, paste("ot", 1:2, sep="")] <- t[timeVals$raw+(wsz+1), 1:2]

################## Functions ################################

get_time_series = function(a,a_target_emotion,p_target_emotion) {
  parent = as.character(tolower(a[,2])) # column 2, all rows, turn it into string
  adolescent = as.character(tolower(a[,3])) # column 3, all rows, turn it into string
  adolescent[adolescent==""] = " adol_nothing" # wipe out junk
  parent[parent==""] = " parent_nothing" # wipe out junk
  
  # let's get emotion state out (string)
  for (i in 1:length(parent)) {
    parent[i] = paste(unlist(strsplit(parent[i]," "))[-1],collapse=" ") # without the P / A prefix
    adolescent[i] = paste(unlist(strsplit(adolescent[i]," "))[-1],collapse=" ")
  }
  
  # relabel for pairwise temporal relations (FILTERING IF YOU WANT)
  parent[(parent %in% p_target_emotion)==F] = 'parent_nothing'
  adolescent[(adolescent %in% a_target_emotion)==F] = 'adol_nothing'
  parent[parent %in% p_target_emotion] = '0target' # so that target always = 1
  adolescent[adolescent %in% a_target_emotion] = '0target' 
  
  # get unique affect terms; to be used as #'s below
  uniques = c('0target','adol_nothing','parent_nothing') #sort(unique(c(parent,adolescent))) # unless changed, should only yield "target", "p_nothing", and "a_nothing"
  
  # let's generate unique numbers
  pix = (1:length(parent))*0;aix = (1:length(parent))*0 # default to 0's
  for (i in 1:length(parent)) {
    pix[i] = which(uniques==parent[i]) # which = get the position in uniques to numerically identify...
    aix[i] = which(uniques==adolescent[i]) # ...the affect categories
  }      
  return(data.frame(pix,aix))
}