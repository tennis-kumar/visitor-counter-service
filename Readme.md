# 🔢 Visitor Counter Service

A simple Node.js application that counts and displays the number of visitors. The count is stored and retrieved from a Redis database.

## 🚀 Tech Stack

- <img src="https://nodejs.org/static/images/favicons/favicon.ico" width="16" height="16"> **Node.js** + <img src="https://expressjs.com/images/favicon.png" width="16" height="16"> **Express** — Web server
- <img src="https://cdn.iconscout.com/icon/free/png-256/redis-4-1175103.png" width="16" height="16"> **Redis** — In-memory store for tracking visits
- <img src="https://www.docker.com/wp-content/uploads/2023/04/cropped-Docker-favicon-32x32.png" width="16" height="16"> **Docker** — Containerization
- <img src="https://github.githubassets.com/favicons/favicon.svg" width="16" height="16"> **GitHub Actions** — CI for Docker builds
- <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/terraform/terraform-original.svg" width="16" height="16"> **Terraform** — Infrastructure as Code (IaC)
- <img src="https://aws.amazon.com/favicon.ico" width="16" height="16"> **AWS EC2** — Hosting the application

## 🧠 How It Works

1. The server increments a counter in Redis every time the root endpoint `/` is accessed
2. The current visitor count is returned in the response
3. Docker and Docker Compose are used to containerize both the app and Redis
4. The Docker image is built using GitHub Actions and pushed to GitHub Container Registry (GHCR)
5. Terraform provisions an EC2 instance and runs the containerized app on the cloud

## 📂 Project Structure

```
visitor-counter-service/
├── .github/workflows/    # GitHub Actions CI config
│   └── docker-ci.yml
├── infra/                # Terraform configurations
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── ec2_key / ec2_key.pub
├── src/
│   └── index.js          # Main Express server
├── docker-compose.yml
├── Dockerfile
├── package.json
├── .gitignore
└── README.md
```

## 🧪 Running Locally

Make sure you have Docker and Redis installed or use Docker Compose.

### Using Docker Compose

```bash
docker-compose up -d
```

The app will be available at [http://localhost:3000](http://localhost:3000)

## 🔄 GitHub Actions Workflow

Every push to the main branch triggers the GitHub Actions pipeline to:

1. Checkout code
2. Build Docker image
3. Optionally run tests/lint
4. Push to GHCR (GitHub Container Registry)

## ☁️ Deployment via Terraform

1. Set up AWS credentials

    - make sure aws cli is installed before proceeding


   ```bash
   aws configure
   ```

2. Generate SSH Keys

   ```bash
   ssh-keygen -f infra/ec2_key
   ```

3. Apply Terraform

   ```bash
   cd infra
   terraform init
   terraform apply
   ```

   This will:
   - Provision an EC2 instance
   - SSH into it
   - Install Docker
   - Pull your Docker image from GHCR
   - Start the container

## 🔐 Environment Variables

| Variable | Default / Required | Description |
|----------|-------------------|-------------|
| `REDIS_URL` | `redis://localhost:6379` | Redis connection string |

## 📌 TODOs / Improvements

- [ ] Add persistent storage for Redis
- [ ] Add Prometheus/Grafana monitoring
- [ ] Improve logging
- [ ] Add unit tests and linting (ESLint)
- [ ] Add CI/CD for automatic Terraform deployments

## 🧑‍💻 Author

[@tennis-kumar](https://github.com/tennis-kumar)  
Backend | Cloud | DevOps Enthusiast

## 📄 License

[MIT](https://opensource.org/licenses/MIT) © 2025 Tennis Kumar
