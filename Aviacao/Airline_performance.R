
#instalando pacotes:
install.packages("installr")
library(installr)
updateR()
install.packages('devtools')
library(devtools)
install.packages('tidyverse', dependencies=TRUE)
library(tidyverse)

#Definindo origem dos dados e baixando:
#URL <- "http://ww2.amstat.org/sections/graphics/datasets/DataExpo2009.zip"
#nomeArquivo <- 'arquivo_baixado'

# criando variável para receber os dados
voos2008 <- read_csv("C:/users/rodgl/Downloads/DataExpo2009/2008.csv.bz2")

# Filtrando os dados, com seed 42 e amostra de 100.000 observações
set.seed(42)
sampleDados <- sample_n(voos2008, 100000)
str(sampleDados)
head(sampleDados$TailNum)

# Salvando uma cópia da amostra
write_csv(sampleDados, 'voos2008.csv')

# 1) Qual é o dia da semana/época do ano para voar que minimiza atrasos?

#filtrando os campos necessários para resposnder a questão
# 100.000 observações (linhas) são mantidas, mas somente as sete variáveis 
# %>% é a função pipe, permite que funções sejam executadas de forma ordenada
# select é a função responsável por selecionar determinadas colunas
novoDataset <- voos2008 %>%
  select(Year,Month,DayofMonth,DepTime,DepDelay,ArrDelay,Cancelled)
str(novoDataset)
head(novoDataset)

# Com os dados do novoDataset
# Selecionamdo apenas sete variáveis.
# Fazendo um filtro para o mês de setembro. 
# Resultado: o conjunto de dados ficou com 7.739 linhas ref. setembro:
novoDataset <- voos2008 %>% 
  select(Year,Month,DayofMonth,DepTime,DepDelay,ArrDelay,Cancelled) %>% 
  filter(Month == 9)
str(novoDataset)

# quais épocas são melhores para se ter mais eficiência com os voos?
# dia da semana e época do ano. época do ano == mês. 
# calcular a média de atraso de um mês específico, deve-se filtrar o mês que deseja e calcular a média 
# de atraso da decolagem com a função mean. 
novoDataset <- voos2008 %>%
  select(Year,Month,DayofMonth,DepTime,DepDelay,ArrDelay,Cancelled) %>%
  filter(Month == 9)
mean(novoDataset$DepDelay, na.rm = TRUE)

# qual melhor época do ano para não ter atrasos?
# A função mutate, capaz de criar uma nova variável a partir de alguma operação programada; 
# a função group_by, capaz de fazer o agrupamento dos dados a partir das variáveis definidas; 
# e a função arrange, capaz de ordenar os dados de forma crescente a partir das variáveis informadas. 
voos2008 %>%
  select(Month,DepDelay) %>%
  group_by(Month) %>%
  mutate(atrasoMedio = mean(DepDelay, na.rm = TRUE)) %>%
  select(Month,atrasoMedio) %>%
  unique() %>%
  arrange(atrasoMedio)

# A média de atraso foi criada com a função mean e salva em uma nova variável chamada 
#atrasoMedio com a função mutate. No final do bloco de código acima, foi incluída a função 
#unique que remove os valores duplicados. Como anteriormente à função unique estava 
#uma função de seleção das variáveis Month e atrasoMedio, somente uma aparição da 
#combinação dessas duas variáveis será apresentada. Por fim, é feita a ordenação com a variável atrasoMedio para que o 
#resultado apresente os atrasos em ordem crescente. Assim, é possível ver quais meses são 
#os melhores para voar:

#Pergunta 1) Aproveitando a função mutate, como deve ser feito o cálculo de tempo 
#médio de atraso de voo com todas as observações (linhas) que temos no dataset 
#original? Mostre os dez primeiros registros deste resultado.

#Pergunta 2) No experimento para mostrar o mês com menos atrasos, o que 
#acontece se executar a função unique() antes de executar a função select?
