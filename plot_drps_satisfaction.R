drpMax = 100*max(aggregate(graph$RR,by=list(graph$RawLag,graph$Satisfaction<3.96,graph$shuff),mean)$x)+1
p1 <- ggplot(graph[graph$Satisfaction<3.96,],aes(RawLag,100*RR))+
  coord_cartesian(xlim=c(-wsz,wsz),ylim=c(0,drpMax))+
  theme(legend.position="none")+ggtitle('Low satisfaction')+xlab('Lag')+ylab('RR')
p1 = p1 + stat_smooth(aes(fill=factor(shuff)),method = "loess", formula = y ~ x) + 
  scale_fill_manual(values=c("red","blue")) + scale_colour_manual(values=c("black")) # spec loess because > 1,000 points
p2 <- ggplot(graph[graph$Satisfaction>3.96,],aes(RawLag,100*RR))+
  coord_cartesian(xlim=c(-wsz,wsz),ylim=c(0,drpMax))+
  theme(legend.position="none")+ggtitle('High satisfaction')+xlab('Lag')+ylab('RR')
p2 = p2 + stat_smooth(aes(fill=factor(shuff)),method = "loess", formula = y ~ x) + 
  scale_fill_manual(values=c("red","blue")) + scale_colour_manual(values=c("black","black")) # spec loess because > 1,000 points
p3 = qplot(maxlag, data=descriptives[descriptives$shuff=='observed',], geom="histogram",binwidth=1)+
  coord_cartesian(xlim=c(-wsz-3,wsz+3))+xlab('Lag')+ggtitle('Histogram of max RR lags')
grid.arrange(p1,p2,p3,nrow=1,ncol=3)
