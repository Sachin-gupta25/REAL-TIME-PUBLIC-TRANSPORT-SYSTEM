# Yatra Yatri Management System

A comprehensive travel management system built with Spring Boot backend and React PWA frontend, designed for booking and tracking travel trips with real-time updates.

## 🚀 Features

- **User Authentication & Authorization** with JWT
- **Trip Management** - Create, search, and book trips
- **Real-time Tracking** with WebSocket integration
- **Progressive Web App (PWA)** - Works offline and installable
- **Responsive Design** - Works on desktop and mobile
- **Secure API** with role-based access control
- **Database Integration** with MySQL
- **Docker Support** for easy deployment

## 🏗️ Architecture

```
Yatra-Yatri-Management-System/
├── backend/                    # Spring Boot API server
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/yatrayatri/
│   │   │   │   ├── entity/     # JPA entities
│   │   │   │   ├── repository/ # Data repositories
│   │   │   │   ├── service/    # Business logic
│   │   │   │   ├── controller/ # REST controllers
│   │   │   │   ├── config/     # Configuration classes
│   │   │   │   ├── security/   # Security & JWT
│   │   │   │   └── dto/        # Data transfer objects
│   │   │   └── resources/
│   │   └── test/
│   └── pom.xml
├── frontend/                   # React PWA client
│   ├── public/
│   │   ├── manifest.json      # PWA manifest
│   │   ├── sw.js              # Service worker
│   │   └── index.html
│   ├── src/
│   │   ├── App.js             # Main React component
│   │   ├── App.css            # Styles
│   │   └── index.js           # Entry point
│   └── package.json
├── database/
│   └── schema.sql             # MySQL database schema
├── docker/
│   ├── backend.Dockerfile     # Backend container
│   ├── frontend.Dockerfile    # Frontend container
│   └── nginx.conf             # Nginx configuration
├── docker-compose.yml         # Multi-container setup
├── .env.example               # Environment variables template
└── README.md
```

## 🛠️ Technology Stack

### Backend
- **Spring Boot 3.1.5** - Java framework
- **Spring Security** - Authentication & authorization
- **Spring Data JPA** - Database abstraction
- **JWT** - Token-based authentication
- **WebSocket** - Real-time communication
- **MySQL** - Database
- **Maven** - Dependency management

### Frontend
- **React 18** - UI framework
- **React Router** - Client-side routing
- **Axios** - HTTP client
- **Socket.IO** - WebSocket client
- **Workbox** - PWA service worker
- **CSS3** - Styling

### DevOps
- **Docker** - Containerization
- **Docker Compose** - Multi-container orchestration
- **Nginx** - Reverse proxy & static file serving

## 🚀 Quick Start

### Prerequisites

- Java 17+
- Node.js 18+
- MySQL 8.0+
- Docker & Docker Compose (optional)

### Using Docker (Recommended)

1. **Clone the repository**
   ```bash
   git clone https://github.com/VinodKumarMaurya5649/Yatra-Yatri-Management-System.git
   cd Yatra-Yatri-Management-System
   ```

2. **Start with Docker Compose**
   ```bash
   docker-compose up -d
   ```

3. **Access the application**
   - Frontend: http://localhost:80
   - Backend API: http://localhost:8080
   - Database: localhost:3306

### Manual Setup

#### Backend Setup

1. **Configure Database**
   ```bash
   # Create MySQL database
   mysql -u root -p
   CREATE DATABASE yatra_yatri_db;
   ```

2. **Import Database Schema**
   ```bash
   mysql -u root -p yatra_yatri_db < database/schema.sql
   ```

3. **Configure Application Properties**
   ```bash
   cd backend
   cp application.properties.example src/main/resources/application.properties
   # Edit the file with your database credentials
   ```

4. **Run Backend**
   ```bash
   ./mvnw spring-boot:run
   ```

#### Frontend Setup

1. **Install Dependencies**
   ```bash
   cd frontend
   npm install
   ```

2. **Start Development Server**
   ```bash
   npm start
   ```

3. **Access Application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8080

## 🔧 Configuration

### Environment Variables

Copy `.env.example` to `.env` and update the values:

```env
# Database
DB_HOST=localhost
DB_PORT=3306
DB_NAME=yatra_yatri_db
DB_USERNAME=your_username
DB_PASSWORD=your_password

# JWT
JWT_SECRET=your_jwt_secret_minimum_256_bits

# CORS
CORS_ORIGINS=http://localhost:3000

# API
REACT_APP_API_URL=http://localhost:8080/api
```

### Application Properties

Update `backend/src/main/resources/application.properties`:

```properties
# Database Configuration
spring.datasource.url=jdbc:mysql://localhost:3306/yatra_yatri_db
spring.datasource.username=your_username
spring.datasource.password=your_password

# JWT Configuration
jwt.secret=your_jwt_secret_key
jwt.expiration=86400000

# CORS Configuration
cors.allowed.origins=http://localhost:3000
```

## 📱 PWA Features

The frontend is a Progressive Web App with:

- **Offline Support** - Works without internet connection
- **Installable** - Can be installed on desktop and mobile
- **Push Notifications** - Real-time notifications
- **Background Sync** - Syncs data when connection is restored
- **Responsive Design** - Optimized for all screen sizes

## 🔐 API Endpoints

### Authentication
- `POST /api/auth/login` - User login
- `GET /api/auth/test` - Test endpoint

### Trips
- `GET /api/trips/search` - Search trips (public)
- `GET /api/trips/{id}` - Get trip by ID (authenticated)
- `GET /api/trips` - Get all trips (admin only)
- `POST /api/trips` - Create trip (admin only)

### WebSocket
- `/ws` - WebSocket endpoint for real-time updates

## 🧪 Testing

### Backend Tests
```bash
cd backend
./mvnw test
```

### Frontend Tests
```bash
cd frontend
npm test
```

## 🚀 Deployment

### Docker Deployment

1. **Build and deploy with Docker Compose**
   ```bash
   docker-compose up -d --build
   ```

2. **Scale services**
   ```bash
   docker-compose up -d --scale backend=3
   ```

### Manual Deployment

1. **Build Backend**
   ```bash
   cd backend
   ./mvnw clean package
   java -jar target/yatra-yatri-backend-0.0.1-SNAPSHOT.jar
   ```

2. **Build Frontend**
   ```bash
   cd frontend
   npm run build
   # Serve the build folder with a web server
   ```

## 📊 Database Schema

The system uses the following main entities:

- **Users** - User accounts with roles (ADMIN, OPERATOR, TRAVELER)
- **Trips** - Travel trips with details like destination, timing, price
- **Bookings** - User bookings for trips
- **Payments** - Payment transactions (future enhancement)
- **Vehicles** - Vehicle information (future enhancement)

## 🔒 Security Features

- **JWT Authentication** - Stateless token-based auth
- **Role-based Authorization** - Different access levels
- **CORS Configuration** - Cross-origin request handling
- **Input Validation** - Request data validation
- **Security Headers** - Protection against common attacks

## 🌐 Real-time Features

- **Trip Status Updates** - Live trip status changes
- **Booking Notifications** - Real-time booking confirmations
- **Location Tracking** - Live vehicle tracking (future)
- **Chat Support** - Real-time customer support (future)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

- **Developer**: Vinod Kumar Maurya
- **Email**: [Your Email]
- **GitHub**: [@VinodKumarMaurya5649](https://github.com/VinodKumarMaurya5649)

## 🆘 Support

For support, email [your-email] or create an issue on GitHub.

## 🔄 Changelog

### v0.1.0 (Current)
- Initial project setup
- Basic authentication system
- Trip management functionality
- PWA implementation
- Docker configuration
- Database schema design

## 🚧 Roadmap

- [ ] Payment gateway integration
- [ ] Real-time location tracking
- [ ] Mobile app development
- [ ] Advanced analytics dashboard
- [ ] Multi-language support
- [ ] Email/SMS notifications
- [ ] Advanced search filters
- [ ] Customer support chat
- [ ] Review and rating system
- [ ] Loyalty program