# Todas as strings já virão como fator
insurance <- read.csv("insurance.csv", stringsAsFactors = TRUE)

str(insurance)

# Exibe um resumo estatístico
summary(insurance$expenses)

# Plota um histograma dos gastos
hist(insurance$expenses)

# Exibe a quantidade de pessoas por região
table(insurance$region)

# Exibe a quantidade de pessoas por sexo
table(insurance$sex)

# Exibe a quantidade de fumantes
table(insurance$smoker)

# Exibe o número de filhos por fumantes
table(insurance$children, insurance$smoker)

# Exibe a correlação entre as seguintes características
cor(insurance[c("age", "bmi", "children", "expenses")])

library(stats)

# Valor gasto
ins_model <- lm(expenses ~ age + children + bmi + sex + smoker +
                  region, data = insurance)

summary(ins_model)

# Quanto maior o R-squared seornece uma medida de quão bom é o modelo
insurance$age2 <- insurance$age^2
ins_model2 <- lm(expenses ~ age + children + bmi + children*age + sex + smoker*bmi*age + smoker +
                   region, data = insurance)

summary(ins_model2)
