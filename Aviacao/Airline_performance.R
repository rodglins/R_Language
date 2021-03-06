
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

# criando vari�vel para receber os dados
voos2008 <- read_csv("C:/users/rodgl/Downloads/DataExpo2009/2008.csv.bz2")

# Filtrando os dados, com seed 42 e amostra de 100.000 observa��es
set.seed(42)
sampleDados <- sample_n(voos2008, 100000)
str(sampleDados)
head(sampleDados$TailNum)

# Salvando uma c�pia da amostra
write_csv(sampleDados, 'voos2008.csv')

# 1) Qual � o dia da semana/�poca do ano para voar que minimiza atrasos?

#filtrando os campos necess�rios para resposnder a quest�o
# 100.000 observa��es (linhas) s�o mantidas, mas somente as sete vari�veis 
# %>% � a fun��o pipe, permite que fun��es sejam executadas de forma ordenada
# select � a fun��o respons�vel por selecionar determinadas colunas
novoDataset <- voos2008 %>%
  select(Year,Month,DayofMonth,DepTime,DepDelay,ArrDelay,Cancelled)
str(novoDataset)
head(novoDataset)

# Com os dados do novoDataset
# Selecionamdo apenas sete vari�veis.
# Fazendo um filtro para o m�s de setembro. 
# Resultado: o conjunto de dados ficou com 7.739 linhas ref. setembro:
novoDataset <- voos2008 %>% 
  select(Year,Month,DayofMonth,DepTime,DepDelay,ArrDelay,Cancelled) %>% 
  filter(Month == 9)
str(novoDataset)

# quais �pocas s�o melhores para se ter mais efici�ncia com os voos?
# dia da semana e �poca do ano. �poca do ano == m�s. 
# calcular a m�dia de atraso de um m�s espec�fico, deve-se filtrar o m�s que deseja e calcular a m�dia 
# de atraso da decolagem com a fun��o mean. 
novoDataset <- voos2008 %>%
  select(Year,Month,DayofMonth,DepTime,DepDelay,ArrDelay,Cancelled) %>%
  filter(Month == 9)
mean(novoDataset$DepDelay, na.rm = TRUE)

# qual melhor �poca do ano para n�o ter atrasos?
# A fun��o mutate, capaz de criar uma nova vari�vel a partir de alguma opera��o programada; 
# a fun��o group_by, capaz de fazer o agrupamento dos dados a partir das vari�veis definidas; 
# e a fun��o arrange, capaz de ordenar os dados de forma crescente a partir das vari�veis informadas. 
voos2008 %>%
  select(Month,DepDelay) %>%
  group_by(Month) %>%
  mutate(atrasoMedio = mean(DepDelay, na.rm = TRUE)) %>%
  select(Month,atrasoMedio) %>%
  unique() %>%
  arrange(atrasoMedio)

# A m�dia de atraso foi criada com a fun��o mean e salva em uma nova vari�vel chamada 
#atrasoMedio com a fun��o mutate. No final do bloco de c�digo acima, foi inclu�da a fun��o 
#unique que remove os valores duplicados. Como anteriormente � fun��o unique estava 
#uma fun��o de sele��o das vari�veis Month e atrasoMedio, somente uma apari��o da 
#combina��o dessas duas vari�veis ser� apresentada. Por fim, � feita a ordena��o com a vari�vel atrasoMedio para que o 
#resultado apresente os atrasos em ordem crescente. Assim, � poss�vel ver quais meses s�o 
#os melhores para voar:

#Pergunta 1) Aproveitando a fun��o mutate, como deve ser feito o c�lculo de tempo 
#m�dio de atraso de voo com todas as observa��es (linhas) que temos no dataset 
#original? Mostre os dez primeiros registros deste resultado.

#Pergunta 2) No experimento para mostrar o m�s com menos atrasos, o que 
#acontece se executar a fun��o unique() antes de executar a fun��o select?
