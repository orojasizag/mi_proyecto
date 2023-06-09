#Cargar libreria readr
library(readr)

#Importar Data Frame
#epa_http <- read_table("C:/Users/OMAR/Desktop/Data Science aplicada a la Ciberseguridad/epa-http/epa-http.csv")
epa_http <- read_table("C:/Rita/DataScience/epa-http/epa-http.csv",col_names = FALSE)

#Nombrar columnas<
names(epa_http) <- c("source","hora","metodo","recurso","protocolo","cod_retorno","tamaño")
summary(epa_http)
#Cambiar formato de columna tamaño
epa_http$tamaño <- as.numeric(epa_http$tamaño)
#Cargar libreria stringr
library(stringr)
#crear columna metodo limpio y cambiar de formato
epa_http$metodo_limpio <- str_sub(epa_http$metodo,2)
epa_http$metodo_limpio <- as.factor(epa_http$metodo_limpio)
summary(epa_http)
#eliminar columna metodo
epa_http$metodo <- NULL
#crear columna protocolo limpio y cambiar de formato
epa_http$protocolo_limpio <- str_sub(epa_http$protocolo,1,8)
epa_http$protocolo_limpio <- as.factor(epa_http$protocolo_limpio)
#eliminar columna protocolo
epa_http$protocolo <- NULL
summary(epa_http)
#PREGUNTA 1
#Cuales son las dimensiones del dataset cargado (número de filas y columnas)
dim(epa_http)
#Valor medio de la columna bytes(tamaño)
summary(epa_http)
#PREGUNTA 2
#De las diferentes IPs de origen accediendo al servidor, ¿cuantas pertenecen a una IP
#claramente educativa (que contenga ".edu")?
#Cargar libreria dplyr
library(dplyr)
#contar filas que continen ".edu"
count(epa_http[grepl("edu",epa_http$source),])
#PREGUNTA 3
#De todas las peticiones recibidas por el servidor cual es la hora en la que hay mayor volumen
#de peticiones HTTP de tipo "GET"?

datos_get <- epa_http[grepl("GET", epa_http$metodo_limpio ), ]
datos_get$hora_format <- as.POSIXlt(datos_get$hora,format="[%d:%H:%M:%OS]")
datos_get$hora_2 <- datos_get$hora_format$hour
count(datos_get, hora_2, sort = TRUE)

#PREGUNTA 4
#De las peticiones hechas por instituciones educativas (.edu), ¿Cuantos bytes en total se
#han transmitido, en peticiones de descarga de ficheros de texto ".txt"?
ip_edu <- epa_http[grepl("edu", epa_http$source),]
fichero_txt <- ip_edu[grepl(".txt", ip_edu$recurso),]
sum(fichero_txt$tamaño,na.rm = TRUE)

#PREGUNTA 5
#Si separamos la petición en 3 partes (Tipo, URL, Protocolo), usando str_split y el
#separador " " (espacio), ¿cuantas peticiones buscan directamente la URL = "/"
count((filter(epa_http, recurso=="/")))

#PREGUNTA 6
#Aprovechando que hemos separado la petición en 3 partes (Tipo, URL, Protocolo)
#¿Cuantas peticiones NO tienen como protocolo "HTTP/0.2"?
count(epa_http[grepl("HTTP/1.0",epa_http$protocolo_limpio),])

