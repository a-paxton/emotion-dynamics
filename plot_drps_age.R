drpMax = 100*max(aggregate(graph$RR,by=list(graph$RawLag,graph$Age<16,graph$shuff),mean)$x)+1
p1 <- ggplot(graph[graph$Age<16,],aes(RawLag,100*RR))+
  coord_cartesian(xlim=c(-wsz,wsz),ylim=c(0,drpMax))+
  theme(legend.position="none")+ggtitle('Younger adolescents')+xlab('Lag')+ylab('RR')
p1 = p1 + stat_smooth(aes(fill=factor(shuff)),method = "loess", formula = y ~ x) + 
  scale_fill_manual(values=c("red","blue")) + scale_colour_manual(values=c("black")) # spec loess because > 1,000 points
p2 <- ggplot(graph[graph$Age>=16,],aes(RawLag,100*RR))+
  coord_cartesian(xlim=c(-wsz,wsz),ylim=c(0,drpMax))+
  theme(legend.position="none")+ggtitle('Older adolescents')+xlab('Lag')+ylab('RR')
p2 = p2 + stat_smooth(aes(fill=factor(shuff)),method = "loess", formula = y ~ x) + 
  scale_fill_manual(values=c("red","blue")) + scale_colour_manual(values=c("black","black")) # spec loess because > 1,000 points
p3 = qplot(maxlag, data=descriptives[descriptives$shuff=='observed',], geom="histogram",binwidth=1)+
  coord_cartesian(xlim=c(-wsz-3,wsz+3))+xlab('Lag')+ggtitle('Histogram of max RR lags')
grid.arrange(p1,p2,p3,nrow=1,ncol=3)