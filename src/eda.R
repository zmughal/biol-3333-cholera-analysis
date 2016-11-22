library('ProjectTemplate')
load.project()

library(ggplot2)

for (dataset in project.info$data)
{
  message(paste('Showing top 5 rows of', dataset))
  plot <- ggplot(get(dataset), aes(Date,DeltaCases)) + geom_line()
  #ggsave(file.path('graphs', 'plot1.pdf'))
  #print(plot)
  print(head(get(dataset)))
}

keep_cols <- c('Date','CleanDeltaCases','CleanDeltaDeaths')
tracking.stack.all <- rbind(
		tracking.a[,keep_cols],
		tracking.b[,keep_cols],
		tracking.c[,keep_cols]
	)
tracking.agg <- aggregate( x = tracking.stack.all, by = list(tracking.stack.all$Date), FUN = 'mean' )

# Date for the Haiti landfall of Hurricane Matthew
hurricane_matthew_date <- as.Date('2016-10-07')
hurricane_matthew_date_vline <- geom_vline(xintercept=as.numeric(hurricane_matthew_date), linetype=4)

plot.all.delta.cases <- ggplot(tracking.agg, aes(Date,CleanDeltaCases)) +
	geom_bar( stat = 'identity' ) +
	hurricane_matthew_date_vline
#print(plot.all.delta.cases)
ggsave( file.path('graphs', 'plot.all.delta.cases.png'))

#plot.all.delta.deaths <- ggplot(tracking.agg, aes(Date,CleanDeltaDeaths)) +
	#geom_line() +
	#hurricane_matthew_date_vline
##print(plot.all.delta.deaths)
#ggsave( file.path('graphs', 'plot.all.delta.deaths.png'))

plot.all.cum.delta.cases <- ggplot(
	subset( tracking.agg, !is.na(CleanDeltaCases) ),
	aes(Date,cumsum(CleanDeltaCases))) + geom_line() +
	hurricane_matthew_date_vline
#print(plot.all.cum.delta.cases)
ggsave( file.path('graphs', 'plot.all.cum.delta.cases.png'))

#plot.all.cum.delta.deaths <- ggplot(
	#subset( tracking.agg, !is.na(CleanDeltaDeaths) ),
	#aes(Date,cumsum(CleanDeltaDeaths))) + geom_line() +
	#hurricane_matthew_date_vline
##print(plot.all.cum.delta.deaths)
#ggsave( file.path('graphs', 'plot.all.cum.delta.deaths.png'))
