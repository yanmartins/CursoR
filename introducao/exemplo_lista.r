# Listas

subject1 <- list(fullname = subjetct_name[1],
                 temperature = temperature[1],
                 gender = gender[1],
                 blood = blood[1],
                 symptoms = symptoms[1])

subject1

# Obtendo a característica temperatura e seu valor
subject1[2]

# Obtendo apenas o valor, sem a característica
subject1[[2]]

# Obtem o valor pelo nome
subject1$temperature

# Obtem características e valores dos itens entre 2 e 3
subject1[2:3]