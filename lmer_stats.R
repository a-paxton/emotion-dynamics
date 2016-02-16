# all data - unstandardized
lmo.simple.raw = lmer(RR ~ LinearLag + QuadLag + (1 + LinearLag + QuadLag | dyad), data = drps_raw)
coefs.simple.raw = data.frame(summary(lmo.simple.raw)$coefficient)
coefs.simple.raw$p = 2*(1-pnorm(abs(coefs.simple.raw$t.value)))
#coefs.simple.raw

# all data - standardized
lmo.simple = lmer(RR ~ LinearLag + QuadLag + (1 + LinearLag + QuadLag | dyad), data = drps)
coefs.simple = data.frame(summary(lmo.simple)$coefficient)
coefs.simple$p = 2*(1-pnorm(abs(coefs.simple$t.value)))
#coefs.simple

# by satisfaction - unstandardized
lmo.satisfaction.raw = lmer(RR ~ Satisfaction * (LinearLag + QuadLag) + (1 + LinearLag + Satisfaction:QuadLag | dyad), data = drps_raw)
coefs.satisfaction.raw = data.frame(summary(lmo.satisfaction.raw)$coefficient)
coefs.satisfaction.raw$p = 2*(1-pnorm(abs(coefs.satisfaction.raw$t.value)))
#coefs.satisfaction.raw

# by satisfaction - standardized
lmo.satisfaction = lmer(RR ~ Satisfaction + LinearLag + QuadLag + SatisXLinear + SatisXQuad + (1 + LinearLag + SatisXQuad | dyad), data = drps)
coefs.satisfaction = data.frame(summary(lmo.satisfaction)$coefficient)
coefs.satisfaction$p = 2*(1-pnorm(abs(coefs.satisfaction$t.value)))
#coefs.satisfaction

# by age group - unstandardized
if ((sum(c(neg) %in% a_target_emotion) > 0) && (sum(c(neg) %in% p_target_emotion) > 0)){
  lmo.age.raw = lmer(RR ~ Age * (LinearLag + QuadLag) + (1 + LinearLag + Age:QuadLag | dyad), data = drps_raw)
} else {
  lmo.age.raw = lmer(RR ~ Age * (LinearLag + QuadLag) + (1 + Age:LinearLag + Age:QuadLag | dyad), data = drps_raw)
}
coefs.age.raw = data.frame(summary(lmo.age.raw)$coefficient)
coefs.age.raw$p = 2*(1-pnorm(abs(coefs.age.raw$t.value)))
#coefs.age.raw

# by age group - standardized
if ((sum(c(neg) %in% a_target_emotion) > 0) && (sum(c(neg) %in% p_target_emotion) > 0)){
  lmo.age = lmer(RR ~ Age + LinearLag + QuadLag + AgeXLinear + AgeXQuad + (1 + LinearLag + AgeXQuad | dyad), data = drps)
} else {
  lmo.age = lmer(RR ~ Age + LinearLag + QuadLag + AgeXLinear + AgeXQuad + (1 + AgeXLinear + AgeXQuad | dyad), data = drps)
}
coefs.age = data.frame(summary(lmo.age)$coefficient)
coefs.age$p = 2*(1-pnorm(abs(coefs.age$t.value)))
#coefs.age
