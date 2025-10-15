# Multi-stage build para otimizar o tamanho da imagem final
FROM eclipse-temurin:17-jdk-alpine AS builder

# Definir variáveis de ambiente que podem ser alteradas durante a construção
ARG PORT=8080
ARG APP_NAME=MinhaAplicacao

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos de configuração do Maven
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn

# Tornar o mvnw executável
RUN chmod +x ./mvnw

# Baixar dependências (melhor para cache do Docker)
RUN ./mvnw dependency:go-offline -B

# Copiar código fonte
COPY src ./src

# Compilar a aplicação
RUN ./mvnw clean package -DskipTests

# Segunda stage - imagem final otimizada
FROM eclipse-temurin:17-jre-alpine

# Definir variáveis de ambiente que podem ser sobrescritas no runtime
ARG PORT=8080
ARG APP_NAME=MinhaAplicacao

# Definir as variáveis como environment variables
ENV PORT=${PORT}
ENV APP_NAME=${APP_NAME}

# Criar usuário não-root para segurança
RUN addgroup -g 1001 -S spring && adduser -u 1001 -S spring -G spring

# Instalar curl para healthcheck
RUN apk add --no-cache curl

# Definir diretório de trabalho
WORKDIR /app

# Copiar o JAR compilado da stage anterior
COPY --from=builder /app/target/*.jar app.jar

# Alterar ownership para o usuário spring
RUN chown spring:spring app.jar

# Trocar para usuário não-root
USER spring

# Expor a porta (usando a variável de ambiente)
EXPOSE ${PORT}

# Definir healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:${PORT}/actuator/health || exit 1

# Comando para executar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]