sms_raw <- read.csv("sms_spam.csv", stringsAsFactors = FALSE)

str(sms_raw)

# Define dois níves (ham e spam)
sms_raw$type <- factor(sms_raw$type)

str(sms_raw$type)
table(sms_raw$type)

#install.packages("tm")
library(tm)

# Cria um pacote de palavras
sms_corpus <- VCorpus(VectorSource(sms_raw$text))

print(sms_corpus)
inspect(sms_corpus[1:2])

# Nota-se que existem espaços, pontos, vírgulas...
as.character(sms_corpus[[1]])
lapply(sms_corpus[1:2], as.character)

# Deixa todas as letras minúsculas
sms_corpus_clean <- tm_map(sms_corpus, content_transformer(tolower))
as.character(sms_corpus[[1]])
as.character(sms_corpus_clean[[1]])

sms_corpus_clean <- tm_map(sms_corpus_clean, removeNumbers) # remove números
sms_corpus_clean <- tm_map(sms_corpus_clean, removeWords, stopwords())
sms_corpus_clean <- tm_map(sms_corpus_clean, removePunctuation)
sms_corpus_clean <- tm_map(sms_corpus_clean, stemDocument)
sms_corpus_clean <- tm_map(sms_corpus_clean, stripWhitespace)

lapply(sms_corpus[1:3], as.character)
lapply(sms_corpus_clean[1:3], as.character)

sms_dtm <- DocumentTermMatrix(sms_corpus_clean)

sms_dtm_train <- sms_dtm[1:4169,]
sms_dtm_test <- sms_dtm[4170:5559,]

sms_train_labels <- sms_raw[1:4169,]$type
sms_test_labels <- sms_raw[4170:5559,]$type

prop.table(table(sms_train_labels))
prop.table(table(sms_test_labels))

#install.packages("wordcloud")
library(wordcloud)

wordcloud(sms_corpus_clean, min.freq = 50, random.order = FALSE)

spam <- subset(sms_raw, type == "spam")
ham <- subset(sms_raw, type == "ham")

wordcloud(spam$text, max.words = 40, scale = c(3, 0.5))
wordcloud(ham$text, max.words = 40, scale = c(3, 0.5))

findFreqTerms(sms_dtm_train, 5)

sms_freq_words <- findFreqTerms(sms_dtm_train,5)
str(sms_freq_words)

# Sequências de treinamento e de teste que ocorreram a maior frequência das palavras
sms_dtm_freq_train <- sms_dtm_train[,sms_freq_words]
sms_dtm_freq_test <- sms_dtm_test[,sms_freq_words]

convert_counts <- function(x){
  x <- ifelse(x > 0, "Yes", "No")
}

sms_train <- apply(sms_dtm_freq_train, MARGIN = 2, convert_counts)
sms_test <- apply(sms_dtm_freq_test, MARGIN = 2, convert_counts)

#install.packages("e1071")
library(e1071)
sms_classifier <- naiveBayes(sms_train, sms_train_labels)

sms_test_pred <- predict(sms_classifier, sms_test)

library(gmodels)

CrossTable(sms_test_pred2, sms_test_labels,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))

## Step 5: Improving model performance ----
sms_classifier2 <- naiveBayes(sms_train, sms_train_labels, laplace = 1)
sms_test_pred2 <- predict(sms_classifier2, sms_test)
CrossTable(sms_test_pred2, sms_test_labels,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))
