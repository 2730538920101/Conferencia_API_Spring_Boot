# Etapa de construcción
FROM openjdk:23-jdk-slim as build

# Instalar Maven
RUN apt-get update && apt-get install -y maven

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el archivo pom.xml y descargar las dependencias
COPY pom.xml .
RUN mvn dependency:go-offline

# Copiar el código fuente del proyecto
COPY src ./src

# Construir el proyecto usando Maven
RUN mvn clean package -DskipTests

# Etapa de ejecución
FROM openjdk:23-jdk-slim

# Copiar el archivo JAR construido desde la imagen build
COPY --from=build /app/target/api-conferencia-0.0.1-SNAPSHOT.jar /app/api-conferencia.jar

# Exponer el puerto en el que Spring Boot escucha (por defecto 8080)
EXPOSE 8080

# Comando para ejecutar la aplicación Spring Boot
ENTRYPOINT ["java", "-jar", "/app/api-conferencia.jar"]