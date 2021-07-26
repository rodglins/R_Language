
# Instalando um novo pacote
install.packages("ggplot2")

# Carregando um pacote
library(ggplot2)

# Instala o pacote dplyr 
install.packages("dplyr", dependencies = TRUE)

# Tidyr transformacao de dados
library(tidyr)


# Carregando dados portal transparencia viagens
?read.csv

viagens <- read.csv(
  file = "C:/2020_Viagem.csv",
  sep = ';',
  dec = ','
)

head(viagens)

View(viagens)

dim(viagens)

?summary

summary(viagens)

summary(viagens$Valor.passagens)

library(dplyr)

glimpse(viagens)

?as.Date

viagens$data.inicio <- as.Date(viagens$Período...Data.de.início,
                               "%d/%m/%y")
glimpse(viagens)

viagens$data.inicio.formatada <- format(viagens$data.inicio, "%Y-%m")

viagens$data.inicio.formatada

?format

hist(viagens$Valor.passagens)

# valores min, max, media ... da coluna valor
summary(viagens$Valor.passagens)

# visualizando os valores em um boxplot
boxplot(as.numeric(viagens$Valor.passagens))
boxplot(viagens$Valor.passagens)

# calculando o desvio padrao
sd(viagens$valor.passagens)

?is.na
?colSums

colSums(is.na(viagens))

str(viagens$Situação)

table(viagens$Situação)

prop.table(table(viagens$Situação))*100

# 1. Quais orgaos estao gastando mais com passagens aereas?

#criando um dataframe com os 15 orgaos que gastam mais
p1 <- viagens %>%
  group_by(Nome.do.órgão.superior) %>%
  summarise(n = sum(Valor.passagens)) %>%
  arrange(desc(n)) %>%
  top_n(15)

names(p1) <- c("orgao","valor")

p1

# plotando os dados com o gplot

library(ggplot2)

ggplot(p1,aes(x= reorder(orgao,valor),y= valor))+
  geom_bar(stat ="identity")+
  coord_flip()+
  labs(x="valor",y="Órgãos")

# valor gasto por cidade

p2 <- viagens %>%
  group_by(Destinos) %>%
  summarise(n = sum(Valor.passagens)) %>%
  arrange(desc(n)) %>%
  top_n(15)

names(p2) <- c('destino','valor')

# criando o grafico
ggplot(p2,aes(x= reorder(destino,valor),y= valor))+
  geom_bar(stat ="identity",fill = "#0ba791")+
  geom_text(aes(label=valor), vjust=0.3, size=3)+
  coord_flip()+
  labs(x="Valor",y="Destino")

options(scipen = 999)


# viagens realizadas por mes

p3 <- viagens %>%
  group_by(data.inicio.formatada) %>%
  summarise(qtd = n_distinct(Identificador.do.processo.de.viagem))

head(p3)

#criando o grafico
ggplot(p3, aes(x=data.inicio.formatada, y=qtd, group=1)) +
  geom_line()+
  geom_point()


#instalando rtools

writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', con = "~/.Renviron")

Sys.which("make")
## "C:\\rtools40\\usr\\bin\\make.exe"

install.packages("jsonlite", type = "source")

#visualizacao dos dados



install.packages("rmarkdown")
install.packages('tinytex')

tinytex::install_tinytex()