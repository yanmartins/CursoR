
# COLETA DE DADOS
wbcd <- read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE)


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


# Criando uma função
# Normalização numérica: Para normalizar as características
normalize <- function(x){
  return ((x - min(x)) / (max(x) - min(x)))
}

# Aplica em todas as listas (as características) a função normalize
wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

summary(wbcd_n$area_mean)



