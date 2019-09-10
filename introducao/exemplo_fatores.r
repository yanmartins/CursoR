# Fatores

# Separa em níveis de acordo com a informação
gender <- factor(c("MALE", "FEMALE", "MALE"))
gender

# Existem quatro níveis, porém só três são mencionados
blood <- factor(c("O", "AB", "A"), 
                levels = c("A", "B", "AB", "O"))
blood

# Adiciona uma ordem de prioridade a partir dos níveis criados
symptoms <- factor(c("SEVERE", "MILD", "MODERATE"), 
                   levels = c("MILD", "MODERATE", "SEVERE"), 
                   ordered = TRUE)
symptoms

# Verificando sintomas maiores que o moderado
symptoms > "MODERATE"
