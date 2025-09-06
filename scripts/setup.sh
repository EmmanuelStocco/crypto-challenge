#!/bin/bash

echo "🚀 Setting up Payment Validation System..."

# Create .env files if they don't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file..."
    cp env.example .env
    echo "✅ .env file created. Please edit it with your configuration."
fi

if [ ! -f backend/.env ]; then
    echo "📝 Creating backend/.env file..."
    cp backend/env.example backend/.env
    echo "✅ Backend .env file created."
fi

if [ ! -f frontend/.env.local ]; then
    echo "📝 Creating frontend/.env.local file..."
    cp frontend/env.example frontend/.env.local
    echo "✅ Frontend .env.local file created."
fi

echo "🐳 Building and starting Docker containers..."
docker-compose up --build -d

echo "⏳ Waiting for services to be ready..."
sleep 10

echo "🔧 Running database migrations..."
docker-compose exec backend npx prisma migrate dev --name init

echo "✅ Setup complete!"
echo ""
echo "🌐 Frontend: http://localhost:3000"
echo "🔧 Backend API: http://localhost:3001"
echo "💚 Health Check: http://localhost:3001/health"
echo ""
echo "To stop the services: docker-compose down"
echo "To view logs: docker-compose logs -f"
