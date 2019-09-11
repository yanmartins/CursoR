# Todas as strings já virão como fator
wines <- read.csv("wine.csv", stringsAsFactors = TRUE)

str(wines)

library(stats)


wines$Year2 <- wines$Year^2
wines$Age2 <- wines$Age^2
wines$AGST2 <- wines$AGST/2

# Valor gasto
ins_model <- lm(Price ~ AGST, data = wines)

summary(ins_model)

plot(wines$AGST,wines$Price,main="Avergae Growing Season Temp vs Price", xlab="AGST",ylab="Price", col="blue")
abline(ins_model,col="red")

