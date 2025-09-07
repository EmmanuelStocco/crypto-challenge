# Payment Validation System

Sistema full stack para validação de transações de pagamento com suporte a idempotência.

## 🚀 Tecnologias

### Backend
- **Node.js** com **TypeScript**
- **Express.js** para API REST
- **PostgreSQL** como banco de dados
- **Prisma** como ORM
- **Joi** para validação de dados
- **Docker** para containerização

### Frontend
- **Next.js 14** com **App Router**
- **React 18** com **TypeScript**
- **Tailwind CSS** para estilização
- **Tanstack Query** para gerenciamento de estado
- **Axios** para requisições HTTP

### DevOps
- **Docker Compose** para orquestração
- **PostgreSQL** containerizado
- **Multi-stage builds** para otimização

## 📋 Funcionalidades

- ✅ Criação de pagamentos com validação
- ✅ Sistema de idempotência com X-Idempotency-Key
- ✅ Autenticação via SUPER_SECRET_TOKEN
- ✅ Interface responsiva e moderna
- ✅ Histórico de pagamentos em tempo real
- ✅ Validação de dados no frontend e backend
- ✅ Tratamento de erros robusto

## 🛠️ Instalação e Execução

### Pré-requisitos
- Docker e Docker Compose instalados
- Node.js 18+ (para desenvolvimento local)

### Execução com Docker (Recomendado)

1. **Clone o repositório**
```bash
git clone https://github.com/EmmanuelStocco/crypto-challenge
cd payment-validation-system
```

2. **Configure as variáveis de ambiente**
```bash
cp env.example .env
# Edite o arquivo .env com suas configurações
```

3. **Execute o projeto**
```bash
docker-compose up --build
```

4. **Acesse a aplicação**
- Frontend: http://localhost:3000
- Backend API: http://localhost:3001
- Health Check: http://localhost:3001/health
 

## 📚 API Endpoints

### POST /api/payments
Cria um novo pagamento.

**Headers:**
- `Authorization: Bearer <SUPER_SECRET_TOKEN>`
- `X-Idempotency-Key: <unique-key>`

**Body:**
```json
{
  "amount": 100.50,
  "description": "Payment description"
}
```

**Respostas:**
- `201 Created`: Pagamento criado com sucesso
- `409 Conflict`: Pagamento já existe (idempotência)
- `400 Bad Request`: Dados inválidos
- `401 Unauthorized`: Token inválido

### GET /api/payments
Lista todos os pagamentos.

**Headers:**
- `Authorization: Bearer <SUPER_SECRET_TOKEN>`

### GET /api/payments/:id
Busca um pagamento específico.

**Headers:**
- `Authorization: Bearer <SUPER_SECRET_TOKEN>`
 

## 🔧 Processos e Ferramentas

Inicialmente, organizei toda a base do projeto usando Docker, integrando a arquitetura do front e do back. Optei por essa abordagem porque, devido ao tempo limitado, era prioritário garantir que o núcleo do projeto estivesse funcional desde o início. Utilizei ferramentas exigidas misturando com as que possuo mais familiariedade como Express, Prisma, Axios, etc. 

Após estruturar o backend, configurei o frontend, aplicando a lógica de criação e validações necessárias e integrando as telas com o backend. Em seguida, ajustei o Docker para que ambos os projetos rodassem corretamente com um único comando.

Em relação ao desafio de criptografia, o primeiro arquivo era codificado em Base64, então bastou realizar a decodificação para obter a frase secreta:  
*"The key will be one before its time and will stand for anetnity and serve as a source of integration. Convenades will be broken. Our return is the gift of chaos"*  

Com base nessa frase, tentei aplicar lógicas de descriptografia invertendo caracteres conforme as dicas fornecidas, mas não obtive resultados concretos. Por isso, segui utilizando chaves aleatórias para continuar o desenvolvimento do projeto.


## 🏗️ Decisões Arquiteturais

### Backend
```
backend/
├── src/
│   ├── controllers/     # Controladores da API
│   ├── middleware/      # Middlewares (auth, validation, error)
│   ├── routes/         # Definição das rotas
│   ├── services/       # Lógica de negócio
│   └── index.ts        # Ponto de entrada
├── prisma/
│   └── schema.prisma   # Schema do banco de dados
└── Dockerfile
```
**Justificativa da Arquitetura Backend:**
- Controllers: Separação da lógica de rotas, facilitando manutenção e testes.
- Middleware: Centraliza autenticação, validação e tratamento de erros.
- Routes: Define caminhos da API de forma clara e modular.
- Services: Contém a lógica de negócio, mantendo controllers leves e focados.
- Prisma: ORM moderno que facilita integração com o banco de dados e migrations.
- Dockerfile: Permite empacotar o backend em container isolado, pronto para deploy.

### Frontend
```
frontend/
├── app/
│   ├── components/     # Componentes React
│   ├── services/       # Serviços de API
│   ├── providers/      # Providers (Query, etc)
│   └── globals.css     # Estilos globais
└── Dockerfile
```
**Justificativa da Arquitetura Frontend:**
- Components: Separação de componentes reutilizáveis, facilitando manutenção e testes.
- Services: Centraliza chamadas de API, evitando duplicação de lógica.
- Providers: Contexts e Query providers para gerenciamento de estado e dados.
- Globals.css: Estilos globais, garantindo consistência visual.
- Dockerfile: Permite empacotar o frontend em container isolado, integrável facilmente com backend.
 
 

**Base (.env geral para o Docker)**
```env
# Database
DATABASE_URL=postgresql://postgres:postgres123@postgres:5432/paymentdb

# Authentication
SUPER_SECRET_TOKEN=meu_token_super_secreto_123

# Backend
PORT=3001
NODE_ENV=development

# Frontend
NEXT_PUBLIC_API_URL=http://localhost:3001
NEXT_PUBLIC_SUPER_SECRET_TOKEN=meu_token_super_secreto_123
```

**Backend (.env)**
```env
DATABASE_URL=postgresql://postgres:postgres123@postgres:5432/paymentdb 
# Authentication
SUPER_SECRET_TOKEN=meu_token_super_secreto_123 
# Server
PORT=3001
NODE_ENV=development
```

**Frontend (.env)**
```env
NEXT_PUBLIC_API_URL=http://localhost:3001
NEXT_PUBLIC_SUPER_SECRET_TOKEN=meu_token_super_secreto_123
```
 
 ## 🏗️ Decisões Arquiteturais

### Escalabilidade para Alto Volume de Transações

O projeto foi estruturado de forma modular, permitindo adicionar novas funcionalidades e realizar mudanças com facilidade. Além disso, utiliza validações por meio de **middlewares**, o que facilita a aplicação de regras de negócio e verificações de forma descentralizada, garantindo consistência em múltiplos componentes sem acoplamento direto.


#### Pensando em escalar a aplicação seria possives aplicar:
- **Microservices**  
  - Serviços separados: usuários, pagamentos, notificações, backend principal e frontend.  
  - Permite escalar apenas os serviços que precisam de mais recursos.

- **Processamento Assíncrono e Filas (Queues)**  
  - Tarefas críticas, como pagamentos ou envio de notificações, são processadas de forma assíncrona.  
  - Implementação via **RabbitMQ** ou **Kafka**, garantindo que picos de tráfego não travem o backend.
 
- **Event-Driven Architecture**  
  - Eventos disparados por mudanças de estado (ex: pagamento confirmado) permitem que múltiplos serviços consumam essas informações sem acoplamento direto.

- **Auto Scaling e Load Balancer**  
  - AWS Auto Scaling ajusta o número de instâncias do backend conforme a carga.  
  - Load Balancer distribui requisições de forma uniforme entre instâncias.

---

## 🔍 Observabilidade

Para garantir observabilidade da aplicação, poderia ser utilizado serviços específicos para isso:

- **Logs Centralizados**  
  - Logs do backend centralizados via **ELK Stack (Elasticsearch + Logstash + Kibana)** ou **Grafana Loki**.  
  - Facilita rastrear erros e identificar padrões de uso.

- **Monitoramento de Métricas**  
  - Métricas de CPU, memória, latência das APIs e tempo de resposta do DB.  
  - Ferramentas sugeridas: **Prometheus + Grafana**, **Datadog** ou **New Relic**.

- **Tracing Distribuído**  
  - Permite acompanhar o caminho completo de uma requisição entre serviços.  
  - Ferramentas: **Jaeger**, **OpenTelemetry**.

- **Alertas Proativos**  
  - Alertas configurados para alta latência, aumento de erros ou sobrecarga do DB.  
  - Notificações via **Slack, email ou SMS**.

Outra possibilidade é utilizar as proprias ferramentas de onde o projeto estiver em deploy. Através por exemplo do EC2 da AWS é possível acompanhar metricas de uso de memória, processamento, etc.

## 🚀 Deploy
### 🗄 Banco de Dados
O banco de dados foi deployado na **Render**. 
**URL de conexão:** postgresql://crypto_challenge_user:g1WtRPxPwZUSQjD3kwH6Q64FMkqxP9Pf@dpg-d2ut4vmr433s73elma30-a.oregon-postgres.render.com/crypto_challenge em seguida, linkei com o backend e rodei as migrations para organizar a estrutura do bd. 

Após isso, o backend foi conectado ao banco e as migrations foram executadas para organizar a estrutura do banco.

### 💻 Backend
O backend foi deployado na **Vercel**, conectado ao banco hospedado na Render.  
**URL do Backend:** [https://crypto-challenge-backend-only-23hk.vercel.app/api/payments](https://crypto-challenge-backend-only-23hk.vercel.app/api/payments)

### 🖥 Frontend
O frontend também foi deployado na **Vercel**, permitindo testar a aplicação diretamente.  
**URL do Frontend:** [https://crypto-challenge-frontend-only-vercel.app/](https://crypto-challenge-frontend-only-vercel.app/)


## 📝 Licença

MIT License

## 👨‍💻 Autor

Emmanuel - Desafio Técnico Full Stack
