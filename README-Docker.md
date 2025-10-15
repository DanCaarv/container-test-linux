# Docker Compose - Variável Ambiente Linux

Este projeto contém a configuração Docker Compose para a aplicação Spring Boot.

## Estrutura dos Arquivos

- `docker-compose.yml` - Configuração principal do Docker Compose
- `docker-compose.override.yml` - Configurações específicas para desenvolvimento
- `.env.example` - Exemplo de variáveis de ambiente

## Como Usar

### 1. Configurar Variáveis de Ambiente (Opcional)

Copie o arquivo de exemplo e modifique conforme necessário:

```bash
cp .env.example .env
```

### 2. Construir e Executar a Aplicação

```bash
# Construir e executar em modo detached
docker-compose up -d --build

# Ou executar em foreground para ver os logs
docker-compose up --build
```

### 3. Verificar a Aplicação

A aplicação estará disponível em:
- URL principal: http://localhost:8080
- Endpoint de variável: http://localhost:8080/app/variavel
- Health check: http://localhost:8080/actuator/health

### 4. Parar a Aplicação

```bash
docker-compose down
```

### 5. Ver Logs

```bash
# Ver logs em tempo real
docker-compose logs -f

# Ver logs apenas da aplicação
docker-compose logs -f app
```

## Configurações

### Variáveis de Ambiente

- `PORT`: Porta da aplicação (padrão: 8080)
- `CONSULT_DG`: Nome da aplicação retornado no endpoint
- `SPRING_PROFILES_ACTIVE`: Profile ativo do Spring Boot

### Health Check

O Docker Compose inclui um health check que verifica se a aplicação está respondendo no endpoint `/actuator/health` a cada 30 segundos.

### Networks

A aplicação utiliza uma rede bridge personalizada (`app-network`) para isolamento e comunicação entre containers.

## Desenvolvimento

O arquivo `docker-compose.override.yml` contém configurações específicas para desenvolvimento, incluindo:
- Logs em nível DEBUG
- Volume montado para logs locais
- Profile de desenvolvimento ativo

## Comandos Úteis

```bash
# Reconstruir apenas a aplicação
docker-compose build app

# Executar comando dentro do container
docker-compose exec app sh

# Ver status dos containers
docker-compose ps

# Remover containers, redes e volumes
docker-compose down -v
```