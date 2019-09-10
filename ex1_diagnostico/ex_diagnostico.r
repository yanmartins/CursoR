
# COLETA DE DADOS
wbcd <- read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE)

str(wbcd)

# EXPLORANDO E PREPARANDO OS DADOS
# Exclui a primeira coluna (id dos pacientes, dado desnecessário)
wbcd <- wbcd[-1]

# Conta a quantidade de dados por tipo de diagnósticos
table(wbcd$diagnosis)

# Define rótulos para os fatores
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"),
                         labels = c("Benign", "Malignant"))

# Realiza a proporção dos dados contidos na tabela na coluna diagnóstico
round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)

sumary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])

# Criando uma função
# Normalização numérica: Para normalizar as características
normalize <- function(x){
  return ((x - min(x)) / (max(x) - min(x)))
}

# Aplica em todas as listas (as características) a função normalize
wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

summary(wbcd_n$area_mean)

wbcd_train <- wbcd_n[1:469,]
wbcd_test <- wbcd_n[470:569,]

wbcd_train_labels <- wbcd[1:469,1]
wbcd_test_labels <- wbcd[470:569,1]

library(class)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)

library(gmodels)

CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq = FALSE)
