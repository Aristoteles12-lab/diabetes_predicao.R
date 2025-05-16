
# ------------------------------------------
# Predição de Diabetes com R
# ------------------------------------------

# 1. Carregamento de bibliotecas
library(dplyr)
library(caTools)
library(caret)
library(e1071)
library(ggplot2)
library(klaR)
library(kernlab)

# 2. Carregamento e inspeção dos dados
diabetes <- read.csv(file.choose())  # Se preferir, use "data/diabetes.csv"
str(diabetes)
colSums(is.na(diabetes))
diabetes$Outcome <- as.factor(diabetes$Outcome)

# 3. Análise exploratória
summary(diabetes$Insulin)
ggplot(diabetes, aes(x = Insulin)) +
  geom_boxplot(fill = "tomato", alpha = 0.5) +
  theme_minimal()

# Histograma para variáveis
ggplot(diabetes, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  theme_minimal()

# 4. Tratamento de outliers (Insulin)
Q1 <- quantile(diabetes$Insulin, 0.25)
Q3 <- quantile(diabetes$Insulin, 0.75)
IQR <- Q3 - Q1

diabetes2 <- diabetes %>% 
  filter(Insulin >= (Q1 - 1.5 * IQR) & Insulin <= (Q3 + 1.5 * IQR))

# 5. Divisão dos dados
set.seed(123)
index <- sample.split(diabetes2$Pregnancies, SplitRatio = 0.7)
train <- subset(diabetes2, index == TRUE)
test <- subset(diabetes2, index == FALSE)

# 6. Modelagem
ctrl <- trainControl(method = "cv", number = 5)

# KNN com ajuste de hiperparâmetros
modelo_knn <- train(Outcome ~ ., data = train, method = "knn",
                    trControl = ctrl,
                    tuneGrid = expand.grid(k = 1:20))

plot(modelo_knn)
modelo_knn$bestTune

# Naive Bayes
modelo_nb <- train(Outcome ~ ., data = train, method = "naive_bayes",
                   trControl = ctrl)
modelo_nb$results

# SVM com kernel radial
modelo_svm <- train(Outcome ~ ., data = train, method = "svmRadial",
                    trControl = ctrl,
                    preProcess = c("center", "scale"))
modelo_svm$results

# 7. Avaliação no conjunto de teste
predicoes <- predict(modelo_svm, test)
conf <- confusionMatrix(predicoes, test$Outcome)
print(conf)

# 8. Predição em novos dados
novos.dados <- data.frame(
  Pregnancies = 3,
  Glucose = 111.50,
  BloodPressure = 70,
  SkinThickness = 20,
  Insulin = 47.49,
  BMI = 30.80,
  DiabetesPedigreeFunction = 0.34,
  Age = 38
)

previsao <- predict(modelo_svm, novos.dados)
resultado <- ifelse(previsao == 1, "positivo", "negativo")
print(paste("Resultado:", resultado))

# 9. Exportação dos resultados
write.csv(predicoes, "resultados.csv", row.names = FALSE)
