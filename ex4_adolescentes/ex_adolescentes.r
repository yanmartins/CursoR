teens <- read.csv("snsdata.csv")

str(teens)

# Número de pessoas que usavam a rede social por sexo
table(teens$gender)

# Número de pessoas que usavam a rede social por sexo e pessoas que não informaram
table(teens$gender, useNA = "ifany")

summary(teens$age)

# Trata como NA todos os valores fora dessa escala
teens$age <- ifelse(teens$age >= 13 & teens$age < 20, teens$age, NA)

summary(teens$age)

# Se é Feminino e não é NA, então é Feminino (1). Senão é Masculino ou NA (0)
teens$female <- ifelse(teens$gender == "F" & !is.na(teens$gender), 1, 0)

# Se é NA, então é NA (1). Senão é Masculino ou Feminino (0)
teens$no_gender <- ifelse(is.na(teens$gender), 1, 0)

table(teens$gender, useNA = "ifany")
table(teens$female, useNA = "ifany")
table(teens$no_gender, useNA = "ifany")

ave_age <- ave(teens$age, teens$gradyear, FUN = function(x) mean(x, na.rm = TRUE))
teens$age <- ifelse(is.na(teens$age), ave_age, teens$age)

summary(teens$age)

library(stats)

interest <- teens[5:40]
interest_z <- as.data.frame(lapply(interest, scale))

set.seed(2345)

# Gera os grupos de adolescentes
teen_clusters <- kmeans(interest_z, 5)

# Quantidade de adolescentes em cada cluster
teen_clusters$size

teen_clusters$centers

teens$cluster <- teen_clusters$cluster

teens[1:5, c("cluster", "gender", "age", "friends")]
