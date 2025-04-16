# Visitor Counter Service

A simple Node.js application that counts and displays the number of visitors. The count is stored and retrieved from a Redis database.

## 🚀 Tech Stack

- **Node.js** + **Express** — Web server
- **Redis** — In-memory store for tracking visits
- **Docker** — Containerization
- **GitHub Actions** — CI for Docker builds
- **Terraform** — Infrastructure as Code (IaC)
- **AWS EC2** — Hosting the application

## 🧠 How It Works

1. The server increments a counter in Redis every time the root endpoint `/` is accessed.
2. The current visitor count is returned in the response.
3. Docker and Docker Compose are used to containerize both the app and Redis.
4. The Docker image is built using GitHub Actions and pushed to GitHub Container Registry (GHCR).
5. Terraform provisions an EC2 instance and runs the containerized app on the cloud.

## 📂 Project Structure

visitor-counter-service/
├── .github/workflows/ # GitHub Actions CI config
│ └── docker-ci.yml
├── infra/ # Terraform configurations
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ └── ec2_key / ec2_key.pub
├── src/
│ └── index.js # Main Express server
├── docker-compose.yml
├── Dockerfile
├── package.json
├── .gitignore
└── README.md

## 🧪 Running Locally

Make sure you have Docker and Redis installed or use Docker Compose.

### Using Docker Compose

docker-compose up -d

The app will be available at "http://localhost:3000"

## 🔄 GitHub Actions Workflow

Every push to the main branch triggers the GitHub Actions pipeline to:

Checkout code
Build Docker image
Optionally run tests/lint
Push to GHCR (GitHub Container Registry)

## ☁️ Deployment via Terraform

1. Set up AWS credentials (aws cli)
    - cmd : aws configure

2. Generate SSH Keys
    - cmd : ssh-keygen -f ec2_key

3. Apply Terraform
    - cmd : cd infra
            terraform init
            terraform apply
    This will:
        Provision an EC2 instance
        SSH into it
        Install Docker
        Pull your Docker image from GHCR
        Start the container

## 🔐 Environment Variables

Variable | Default / Required | Description
REDIS_URL | redis://localhost:6379 | Redis connection string

### 📌 TODOs / Improvements

Add persistent storage for Redis
Add Prometheus/Grafana monitoring
Improve logging
Add unit tests and linting (ESLint)
Add CI/CD for automatic Terraform deployments

## 🧑‍💻 Author

@tennis-kumar
Backend | Cloud | DevOps Enthusiast

## License

MIT © 2025

Let me know if you'd like to tweak or add a scetion!