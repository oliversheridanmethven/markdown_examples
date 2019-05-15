# Author: Sam Cohen, October 2017. (Adjusted by Oliver Sheridan-Methven)
library("quantmod")
library("MASS")
library('qcc')
library('plotly')
getSymbols("AMZN", src="google")
ret<- -diff(log(coredata(AMZN$AMZN.Close)))
mean<-0
spread<-0
df<-0
Evar<-0  # Empirical expected VaR.
EES<-0  # Empirical expected shortfall.
Mvar<-0  # Model-based VaR.
MES<-0  # Model-based expected shortfall.
alpha<-0.95
year_length<-256  # Number of trading days per year (approximately).
for(i in 1:(length(ret)-year_length)){
    x<-ret[i:(i+year_length)]
    Evar[i]<-quantile(x,alpha)
    EES[i]<-mean(x[x>quantile(x,alpha)])
    param<-fitdistr(x,'t', df=3)$estimate
    mean[i]<-param[1]
    spread[i]<-param[2]
    Mvar[i]<-mean[i]+spread[i]*qt(alpha,df=3)
}
vols = ewma(ret^2, plot=FALSE, lambda = 0.1)
all_dates = index(AMZN$AMZN.Close)[1:length(vols)]
dates=index(AMZN$AMZN.Close)[(year_length+2):length(AMZN$AMZN.Close)]
df = data.frame('date'=dates, EES, Mvar, Evar, vols=7*vols$y[1:length(Mvar)])

plot_ly(df, x=~date, y=~Mvar, type = 'scatter', mode='lines', 
        name='VaR (model)', line = list(color='black')) %>%
layout(xaxis = list(title = 'Date', showline = TRUE),
       yaxis = list(title = 'Risk measure', showline = TRUE),
       legend = list(x = 0.7, y = 0.9), 
       title='Empirical and model based risk measures') %>%
add_trace(y = ~Evar, name = 'VaR (empirical)', mode = 'lines', 
          line = list(color='red')) %>%
add_trace(y = ~EES, name = 'ES (empirical)', mode = 'lines', 
          line = list(color='blue')) %>%
add_trace(y = ~vols, name = 'Volatility (EWMA)', mode = 'none',
          showlegend = TRUE, name = 'VaR (model)', fill = 'tozeroy',
          fillcolor='grey', line=list(width=0)) 

