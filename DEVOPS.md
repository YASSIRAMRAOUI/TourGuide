# TourGuide DevOps Setup

## Prerequisites
✅ Docker Desktop (with Kubernetes enabled)
✅ Jenkins (running locally)
✅ SonarQube (running locally)

## Quick Start

### 1. Docker Compose (Development)
```cmd
docker-compose up -d
```
Access: http://localhost:8080

### 2. Kubernetes (Production)

**Deploy MySQL:**
```cmd
kubectl apply -f k8s/mysql-deployment.yaml
```

**Deploy Application:**
```cmd
docker build -t tourguide-app:latest .
kubectl apply -f k8s/app-deployment.yaml
```

Access: http://localhost:30080

### 3. Jenkins Pipeline

**Jenkins Configuration:**
1. Create new Pipeline job
2. Point to your Git repository
3. Set Pipeline script from SCM
4. Configure tools:
   - Maven: `Maven`
   - JDK: `JDK11`

**Run Pipeline:**
Pipeline will automatically:
- Build the project
- Run tests
- Run SonarQube analysis
- Build Docker image
- Deploy to Kubernetes

### 4. SonarQube

**Start Analysis:**
```cmd
mvn sonar:sonar -Dsonar.host.url=http://localhost:9000 -Dsonar.login=admin -Dsonar.password=admin
```

## Useful Commands

### Docker
```cmd
# Build image
docker build -t tourguide-app .

# Run container
docker run -p 8080:8080 tourguide-app

# View logs
docker logs tourguide-app
```

### Kubernetes
```cmd
# Get all resources
kubectl get all

# View pods
kubectl get pods

# View logs
kubectl logs <pod-name>

# Delete deployment
kubectl delete -f k8s/
```

### Maven
```cmd
# Build
mvn clean package

# Run tests
mvn test

# Skip tests
mvn package -DskipTests
```

## Project Structure
```
TourGuide/
├── Dockerfile              # Docker image definition
├── Jenkinsfile            # CI/CD pipeline
├── docker-compose.yml     # Docker Compose config
├── sonar-project.properties # SonarQube config
├── k8s/                   # Kubernetes manifests
│   ├── mysql-deployment.yaml
│   └── app-deployment.yaml
└── init-db.sql           # Database initialization
```

## Ports
- Application: 8080 (Docker), 30080 (Kubernetes)
- MySQL: 3306
- Jenkins: 8080 (default)
- SonarQube: 9000 (default)
