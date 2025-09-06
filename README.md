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
git clone <repository-url>
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

### Execução Local (Desenvolvimento)

1. **Backend**
```bash
cd backend
npm install
npm run db:generate
npm run db:migrate
npm run dev
```

2. **Frontend**
```bash
cd frontend
npm install
npm run dev
```

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

## 🏗️ Arquitetura

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

## 🔧 Configuração de Ambiente

### Variáveis de Ambiente

**Backend (.env)**
```env
DATABASE_URL=postgresql://postgres:postgres123@postgres:5432/paymentdb
SUPER_SECRET_TOKEN=your_super_secret_token_here
PORT=3001
NODE_ENV=development
```

**Frontend (.env.local)**
```env
NEXT_PUBLIC_API_URL=http://localhost:3001
NEXT_PUBLIC_SUPER_SECRET_TOKEN=your_super_secret_token_here
```

## 🚀 Deploy

### Backend (Railway/Heroku/Vercel)
1. Configure as variáveis de ambiente
2. Deploy do Dockerfile
3. Configure a DATABASE_URL para PostgreSQL

### Frontend (Vercel/Netlify)
1. Configure as variáveis de ambiente
2. Deploy automático via Git

## 📊 Escalabilidade

### Para Alto Volume de Transações

1. **Filas de Processamento**
   - Redis + Bull para processamento assíncrono
   - Dead letter queues para retry de falhas

2. **Banco de Dados**
   - Read replicas para consultas
   - Sharding por região/usuário
   - Índices otimizados

3. **Cache**
   - Redis para cache de consultas frequentes
   - CDN para assets estáticos

4. **Monitoramento**
   - APM (Application Performance Monitoring)
   - Logs centralizados (ELK Stack)
   - Métricas de negócio

## 🔍 Observabilidade

### Logs
- Structured logging com Winston
- Log levels configuráveis
- Correlação de requests

### Métricas
- Prometheus + Grafana
- Métricas de negócio (pagamentos/minuto)
- Health checks

### Tracing
- OpenTelemetry para distributed tracing
- Correlação entre serviços

## 🧪 Testes

```bash
# Backend
cd backend
npm test

# Frontend
cd frontend
npm test
```

## 📝 Licença

MIT License

## 👨‍💻 Autor

Emmanuel - Desafio Técnico Full Stack
