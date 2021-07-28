mensagem <- "Hello world"
print(mensagem)

# Isto é um comentário

?print

# Instalando um novo pacote
install.packages("ggplot2")

# Carregando um pacote
library(ggplot2)

# Vetores
cidade <- c("Brasília",
            "São Paulo",
            "Rio de Janeiro",
            "Porto Alegre"
            )
cidade

temperatura <- c(32,22,35,17)

regiao <- c(1,2,2,3)

?c()

# Acessando o primeiro elemento
cidade[1]

# Acessando um intervalo de elementos
temperatura[1:3]

# Copiando um vetor
cidade2 <- cidade
cidade2

# Excluindo o segundo elemento da consulta
temperatura[-2]

# Alterando um vetor
cidade2[3] <- "Belo Horizonte"

# Adicionando um novo elemento
cidade2[5] <- "Curitiba"

cidade2

# Deletando um vetor
cidade2 <- NULL

cidade2

# Fatores
?factor

UF <- factor(c("DF", "SP", "RJ", "RS"))

UF

# Levels

grau.instrucao <- factor(c("Nível Médio",
                           "Superior",
                           "Nível Médio",
                           "Fundamental"),
                levels = c("Fundamental",
                            "Nível Médio",
                           "Superior"),
                ordered = TRUE)
grau.instrucao

# Listas
?list()
pessoa <- list(sexo = "M", cidade = "Brasília", idade = "20")

pessoa

# Acessando o primeiro elemento da lista
pessoa[1]

# Acessando o valor do primeito elemento da lista
pessoa[[1]]

# Editando a lista
pessoa[["idade"]] <- 22
pessoa

# Deletando elemento da lista
pessoa[["idade"]] <-NULL

pessoa

# Lista de listas
cidades <- list(cidade = cidade,
                temperatura = temperatura,
                regiao = regiao)
cidades
região <- NULL

# Criando um data frame com vetores
df <- data.frame(cidade, temperatura)

df

# Criando um data frame com lista
df2 <- data.frame(cidades)

df2

# Filtrando valores do data frame
# Recuperando o valor da linha1, coluna 2
df[1, 2]

# Todas as linhas da primeira coluna
df[, 1]

# primeira linha e todas as colunas
df[1,]

# selecionando as 3 primeiras linhas da primeira e da ultima coluna
df2[c(1:3), c( 1, 3 )]

# verificando o nome das colunas
names(df)

# verificando numero de linhas x colunas
dim(df)

# verificando os tipos de dados
str(df)

# Acessar uma coluna do dataframe
df$cidade
df['cidade']

?matrix()
# Matrizes
m <- matrix(seq(1:9), nrow = 3)
m

m2 <- matrix(seq(1:25),
             ncol = 5,
             byrow = TRUE,
             dimnames = list(c(seq(1:5)),
                            c('A','B','C','D','E')
                              )
            )
m2    

# Filtrando a matriz
m2[c(1:2),c("B","C")]

# Join Juncao

df1 <- data.frame(Produto = c(1,2,3,5),Preco = c(15,10,25,20))
head(df1)

df2 <- data.frame(Produto = c(1,2,3,4),Nome = c("A","B","C","D"))
head(df2)

# Instala o pacote dplyr 
install.packages("dplyr", dependencies = TRUE)

library(dplyr)

df3 <- left_join(df1,df2,"Produto")
head(df3)

df4 <- right_join(df1,df2,"Produto")
head(df4)

df5 <- inner_join(df1,df2,"Produto")
head(df5)

# DPLYR
library(dplyr)
?iris

head(iris)

glimpse(iris)
?glimpse

# Filter - filtrando os dados - apenas versicolor
versicolor <- filter(iris,Species == "versicolor")
dim(versicolor)

# slice - selecionando algumas linhas especificas
slice(iris,5:10)

# select - selecionando algumas colunas
select(iris,2:4)

# todas as colunas exceto Sepal width
select(iris, -Sepal.Width)

# Criando uma nova coluna com base em colunas existentes
iris3 <- mutate(iris, nova.coluna = Sepal.Length + Sepal.Width)

iris3[,c("Sepal.Length","Sepal.Width","nova.coluna")]

# Arrange - Ordenar dados
?arrange

select(iris,Sepal.Length) %>%
  arrange(Sepal.Length)

?group_by

# Group by media por especie
iris %>% group_by(Species) %>%
  summarise(mean(Sepal.Length))

# Tidyr transformacao de dados
library(tidyr)
# Quantidade de vendas por ano e produto
dfDate <- data.frame(Produto=c('A','B','C'),
                     A.2015 = c(10,12,20),
                     A.2016 = c(20,25,35),
                     A.2017 = c(15,20,30)
                     )

head(dfDate)

# Mudando o formato do dataframe de linhas para colunas

?gather

dfDate2 <- gather(dfDate, "Ano", "Quantidade", 2:4)
head(dfDate2)

# Limpando dados da coluna

?separate
dfDate3 <- separate(dfDate2, Ano, c("A","Ano"))

dfDate3 <- dfDate3[-2]
dfDate3

# Acrescentando uma coluna mes
dfDate3$Mes <- c('01','02','03')

dfDate3

#Juntar dados de diferentes colunas
?unite

dfDate4 <- dfDate3 %>%
  unite(Data,Mes,Ano,sep='/')

head(dfDate4)

browseVignettes(package = "dplyr")