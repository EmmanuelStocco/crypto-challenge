@echo off
echo 🚀 Setting up Payment Validation System...

REM Create .env files if they don't exist
if not exist .env (
    echo 📝 Creating .env file...
    copy env.example .env
    echo ✅ .env file created. Please edit it with your configuration.
)

if not exist backend\.env (
    echo 📝 Creating backend\.env file...
    copy backend\env.example backend\.env
    echo ✅ Backend .env file created.
)

if not exist frontend\.env.local (
    echo 📝 Creating frontend\.env.local file...
    copy frontend\env.example frontend\.env.local
    echo ✅ Frontend .env.local file created.
)

echo 🐳 Building and starting Docker containers...
docker-compose up --build -d

echo ⏳ Waiting for services to be ready...
timeout /t 10 /nobreak > nul

echo 🔧 Running database migrations...
docker-compose exec backend npx prisma migrate dev --name init

echo ✅ Setup complete!
echo.
echo 🌐 Frontend: http://localhost:3000
echo 🔧 Backend API: http://localhost:3001
echo 💚 Health Check: http://localhost:3001/health
echo.
echo To stop the services: docker-compose down
echo To view logs: docker-compose logs -f
