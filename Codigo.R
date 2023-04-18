epa_http <- read_table("C:/Users/OMAR/Desktop/Data Science aplicada a la Ciberseguridad/epa-http/epa-http.csv")
names(epa_http) <- c("source","hora","metodo","recurso","protocolo","cod_retorno","tamaño")
summary(epa_http)
epa_http$tamaño <- as.numeric(epa_http$tamaño)
head(epa_http$metodo)
library(stringr)
epa_http$metodo_limpio <- str_sub(epa_http$metodo,2)
epa_http$metodo_limpio <- as.factor(epa_http$metodo_limpio)
summary(epa_http)
epa_http$metodo <- NULL
epa_http$protocolo_limpio <- str_sub(epa_http$protocolo,1,8)
epa_http$protocolo <- NULL
epa_http$protocolo_limpio <- as.factor(epa_http$protocolo_limpio)
summary(epa_http)



