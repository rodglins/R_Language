# Carregando os dados

diabetes <- read.csv(
  file = "C:/Datasets/diabetes.csv"
  
)

head(diabetes)

diabetes$Outcome <- as.factor(diabetes$Outcome)

diabetes$Outcome


?str

# organizando a tabela
str(diabetes)

# verificando campos vazios
colSums(is.na(diabetes))

# médias
summary(diabetes$Insulin)

# grafico desvio padrao
boxplot(diabetes$Insulin)

# funções analise de dados

boxplot(diabetes)

# Analise exploratoria

hist(diabetes2$Pregnancies)
hist(diabetes2$Age)
hist(diabetes2$BMI)

library(dplyr)

# removendo valores distantes da media

diabetes2 <- diabetes %>%
  filter(Insulin <= 250)



boxplot(diabetes2$Insulin)

boxplot(diabetes2)
summary(diabetes2$Insulin)

#Construcao do modelo

# divisao dos dados


install.packages("caTools")
library(caTools)
library(dbplyr)
library(tidyr)



set.seed(123)
index = sample.split(diabetes2$Pregnancies, SplitRatio = .70)

index

# DADOS DE TREINO

train = subset(diabetes2, index == TRUE)
test = subset(diabetes2, index == FALSE)

dim(diabetes2)
dim(train)
dim(test)

# criando modelos com pacote caret

install.packages("caret")
install.packages("e1071")

library(caret)
library(e1071)


?caret::train

library(KRLS)



modelo <- train(
   Outcome ~., data = train, method = "knn")

modelo$results
modelo$bestTune

modelo2 <- train(
  Outcome ~., data = train, method = "knn",
  tuneGrid = expand.grid(k = c(1:20)))

modelo2$results
modelo2$bestTune

plot(modelo2)

library(naivebayes)
install.packages(mlbench)

modelo3 <- train(
  Outcome ~., data = train, method = "naive_bayes")

modelo3$results
modelo3$bestTune

library(kernlab)

set.seed(100)
modelo4 <- train(
  Outcome ~., data = train, method = "svmRadialSigma"
  ,preProcess=c("center")
)

modelo4$results
modelo4$bestTune


# Avaliando o modelo
?predict

predicoes <- predict(modelo4,test)

predicoes

?caret::confusionMatrix
confusionMatrix(predicoes, test$Outcome)

# Realizando predicoes

novos.dados <- data.frame(
  Pregnancies= c(3),
  Glucose = c(111.50),
  BloodPressure = c(70),
  SkinThickness = c(20),
  Insulin = c(47.49),
  BMI = c(30.80),
  DiabetesPedigreeFunction = c(0.34),
  Age = c(28)
)

novos.dados

previsao <- predict(modelo4,novos.dados)

resultado <- ifelse(previsao == 1, "Positivo","Negativo")
print(paste("Resultado:",resultado))

write.csv(predicoes,'resultado.csv')


# Obtencao dos dados


?view
