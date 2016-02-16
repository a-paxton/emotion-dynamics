# cycle through all dyads
for (dyad in dyads[,1]) {
  
  # read in data table and prep data for analysis
  a = read.table(paste('data/',dyad,'.txt',sep=''),skip=1,sep='\t')  
  
  ts = get_time_series(a,a_target_emotion,p_target_emotion)
  aix = ts$aix
  pix = ts$pix
  print(dyad)
  
  # calculate diagonal recurrence profile using categorical recurrence
  drp_results = drpdfromts(pix,aix,ws=wsz,datatype="categorical")      
  
  # if the first dyad, start the data frame
  if (dim(drps)[1]==0) {
    drps = data.frame(dyad,timeVals$raw,timeVals$ot1,timeVals$ot2,drp_results$profile,
                      dyads[dyads[,1]==dyad,]$age,dyads[dyads[,1]==dyad,]$meansat,shuff='observed')
    descriptives = data.frame(dyad,maxrec = drp_results$maxrec,maxlag = drp_results$maxlag-(wsz+1),
                              outcome=dyads[dyads[,1]==dyad,]$meansat,shuff='observed',mpix=mean(pix==1),maix=mean(aix==1))
  } else { # subsequently, rbind it
    drps = rbind(drps,data.frame(dyad,timeVals$raw,timeVals$ot1,timeVals$ot2,drp_results$profile,
                                 dyads[dyads[,1]==dyad,]$age,dyads[dyads[,1]==dyad,]$meansat,shuff='observed'))
    descriptives = rbind(descriptives,data.frame(dyad,maxrec = drp_results$maxrec,
                                                 maxlag = drp_results$maxlag-(wsz+1),outcome=dyads[dyads[,1]==dyad,]$meansat,shuff='observed',
                                                 mpix=mean(pix==1),maix=mean(aix==1)))
  }    
  
  for (dyad_baseline in sample(dyads[dyads[,1]!=dyad,1],5)) {
    a = read.table(paste('data/',dyad_baseline,'.txt',sep=''),skip=1,sep='\t')  
    ts = get_time_series(a,a_target_emotion,p_target_emotion)
    aix = ts$aix
    if (length(pix)>length(aix)) {
      pix2 = pix[1:length(aix)]
    } else {
      aix = aix[1:length(pix)]
      pix2 = pix
    }
    
    if (mean(aix==1)==1) {
      print(paste(dyad_baseline,'WTF'))
    }
    
    drp_results = drpdfromts(pix2,aix,ws=wsz,datatype="categorical")          
    drps = rbind(drps,data.frame(dyad,timeVals$raw,timeVals$ot1,timeVals$ot2,
      drp_results$profile,dyads[dyads[,1]==dyad,]$age,dyads[dyads[,1]==dyad,]$meansat,shuff='baseline'))
    descriptives = rbind(descriptives,data.frame(dyad,maxrec = drp_results$maxrec,
      maxlag = drp_results$maxlag-(wsz+1),outcome=dyads[dyads[,1]==dyad,]$meansat,shuff='baseline',
      mpix=mean(pix==1),maix=mean(aix==1)))        
  }
}

# name variables in data frame
colnames(drps) = list('dyad','RawLag','LinearLag','QuadLag','RR','Age','Satisfaction','shuff')
excluded = length(totalPool) - length(unique(drps$dyad))
chosenSample = length(unique(drps$dyad))

# save a version of the data frame for graphing
graph = drps

# create an unstandardized data frame
drps_raw = drps[drps$shuff=='observed',] # remove shuffled baseline data
drps_raw$Satisfaction = drps_raw$Satisfaction
drps_raw$Age = drps_raw$Age

# standardize data frame and create standardized interaction terms
drps = drps[drps$shuff=='observed',] # remove shuffled baseline data
drps$dyad = scale(drps$dyad)
drps$RR = scale(drps$RR)
drps$AgeXLinear = scale(drps$LinearLag * drps$Age)
drps$AgeXQuad = scale(drps$QuadLag * drps$Age)
drps$SatisXLinear = scale(drps$LinearLag * drps$Satisfaction)
drps$SatisXQuad = scale(drps$QuadLag * drps$Satisfaction)
drps$LinearLag = scale(drps$LinearLag)
drps$QuadLag = scale(drps$QuadLag)
drps$Satisfaction = scale(drps$Satisfaction)
drps$Age = scale(drps$Age)
drps$RawLag = scale(drps$RawLag)