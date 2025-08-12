#!/bin/bash

# ParentConnect Assist - GitHub Repository Setup Script
# Run this script to initialize your repository structure

echo "🚀 Setting up ParentConnect Assist repository..."

# Create main directory structure
mkdir -p {docs,server,infra,android,ios-helper,scripts}

# Create docs structure
mkdir -p docs/{compliance,architecture,marketing}

# Create server structure
mkdir -p server/{src,tests,config}
mkdir -p server/src/{routes,services,middleware,models}

# Create infra structure
mkdir -p infra/{docker,kubernetes,terraform}

# Create android structure
mkdir -p android/{senior-app,helper-app}
mkdir -p android/senior-app/{app/src/main/{java,res},gradle}
mkdir -p android/helper-app/{app/src/main/{java,res},gradle}

# Create iOS helper structure
mkdir -p ios-helper/{ParentConnectHelper,Tests}

# Create scripts structure
mkdir -p scripts/{setup,deploy,monitoring}

echo "✅ Directory structure created!"

# Create essential files
echo "📝 Creating essential files..."

# Root README.md (already provided by user)
cat > README.md << 'EOF'
# ParentConnect Assist

Android-first remote assistance for seniors. MVP = Android (Senior) with full assist; Helper on Android/iOS (guidance mode).

## Monorepo Layout
- `docs/` — cost matrix, sprints, AI roadmap, compliance
- `server/` — Node.js + Socket.io signaling API
- `infra/` — docker-compose for Postgres/Redis/server, coturn template
- `android/` — (placeholder) Senior + Helper apps
- `ios-helper/` — (placeholder) Helper guidance-mode app
- `scripts/` — setup and deploy scripts

## Quick start
```bash
# 1) Copy .env.example → .env and fill values
cp server/.env.example server/.env

# 2) Start local stack (Postgres, Redis, server)
docker compose -f infra/docker-compose.yml up --build

# API: http://localhost:8080/health
```

## License
Proprietary (All rights reserved). Replace with your preferred license if needed.
EOF

# .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Environment variables
.env
.env.local
.env.production
.env.staging

# Build outputs
dist/
build/
*.log

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# Android
*.apk
*.aab
*.dex
*.class
bin/
gen/
.gradle/
local.properties
*.keystore
!debug.keystore

# iOS
*.ipa
*.dSYM.zip
*.dSYM
DerivedData/
*.xcworkspace/xcuserdata/
*.xcodeproj/xcuserdata/

# Docker
*.log
docker-compose.override.yml

# Terraform
*.tfstate
*.tfstate.*
.terraform/

# Temporary files
*.tmp
*.temp
*.pid
*.seed
*.pid.lock

# Coverage reports
coverage/
.coverage
.nyc_output

# Database
*.sqlite
*.db

# Secrets
secrets/
*.pem
*.key
!*.example.*
EOF

# License file
cat > LICENSE << 'EOF'
Proprietary License

Copyright (c) 2025 ParentConnect Assist

All rights reserved.

This software and associated documentation files (the "Software") are proprietary 
and confidential to ParentConnect Assist. No part of the Software may be reproduced, 
distributed, or transmitted in any form or by any means, including photocopying, 
recording, or other electronic or mechanical methods, without the prior written 
permission of the copyright holder.

For permission requests, please contact: [your-email@domain.com]
EOF

# GitHub Actions workflow
mkdir -p .github/workflows

cat > .github/workflows/ci.yml << 'EOF'
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  server-test:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: test
          POSTGRES_DB: parentconnect_test
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 5432:5432
      
      redis:
        image: redis:7-alpine
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 6379:6379

    steps:
    - uses: actions/checkout@v4
    
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        cache: 'npm'
        cache-dependency-path: server/package-lock.json
    
    - name: Install dependencies
      working-directory: ./server
      run: npm ci
    
    - name: Run tests
      working-directory: ./server
      run: npm test
      env:
        NODE_ENV: test
        DATABASE_URL: postgresql://postgres:test@localhost:5432/parentconnect_test
        REDIS_URL: redis://localhost:6379

  android-build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Setup Java
      uses: actions/setup-java@v4
      with:
        java-version: '17'
        distribution: 'temurin'
    
    - name: Setup Android SDK
      uses: android-actions/setup-android@v3
    
    - name: Build Android apps
      working-directory: ./android
      run: |
        echo "Android build steps will be added here"
        # ./gradlew assembleDebug testDebugUnitTest

  security-scan:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Run Trivy vulnerability scanner
      uses: aquasecurity/trivy-action@master
      with:
        scan-type: 'fs'
        scan-ref: '.'
        format: 'sarif'
        output: 'trivy-results.sarif'
    
    - name: Upload Trivy scan results
      uses: github/codeql-action/upload-sarif@v3
      if: always()
      with:
        sarif_file: 'trivy-results.sarif'
EOF

# Issue templates
mkdir -p .github/ISSUE_TEMPLATE

cat > .github/ISSUE_TEMPLATE/bug_report.md << 'EOF'
---
name: Bug report
about: Create a report to help us improve
title: '[BUG] '
labels: bug
assignees: ''
---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Device Information:**
- Device: [e.g. Samsung Galaxy A52]
- OS Version: [e.g. Android 13]
- App Version: [e.g. 1.0.0]

**Network Information:**
- Connection Type: [WiFi/Mobile Data]
- Location: [Country/State]
- ISP: [if known]

**Additional context**
Add any other context about the problem here.
EOF

cat > .github/ISSUE_TEMPLATE/feature_request.md << 'EOF'
---
name: Feature request
about: Suggest an idea for this project
title: '[FEATURE] '
labels: enhancement
assignees: ''
---

**Is your feature request related to a problem? Please describe.**
A clear and concise description of what the problem is. Ex. I'm always frustrated when [...]

**Describe the solution you'd like**
A clear and concise description of what you want to happen.

**Describe alternatives you've considered**
A clear and concise description of any alternative solutions or features you've considered.

**Target Users**
- [ ] Senior users (primary)
- [ ] Helper users (children/caregivers)
- [ ] Both

**Platform**
- [ ] Android Senior App
- [ ] Android Helper App
- [ ] iOS Helper App
- [ ] Backend/Server

**Additional context**
Add any other context or screenshots about the feature request here.
EOF

# Pull request template
cat > .github/pull_request_template.md << 'EOF'
## Description
Brief description of changes made.

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Security improvement

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed
- [ ] Tested on real devices (if applicable)

## Security Considerations
- [ ] No sensitive data exposed
- [ ] Proper input validation
- [ ] Authentication/authorization maintained
- [ ] Encryption standards maintained

## Deployment Notes
Any special deployment considerations or database migrations needed.

## Related Issues
Closes #[issue number]
EOF

# Server package.json template
cat > server/package.json << 'EOF'
{
  "name": "parentconnect-server",
  "version": "1.0.0",
  "description": "ParentConnect Assist signaling server",
  "main": "src/app.js",
  "scripts": {
    "start": "node src/app.js",
    "dev": "nodemon src/app.js",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "lint": "eslint src/",
    "lint:fix": "eslint src/ --fix"
  },
  "dependencies": {
    "express": "^4.18.2",
    "socket.io": "^4.7.2",
    "pg": "^8.11.3",
    "redis": "^4.6.8",
    "bcrypt": "^5.1.1",
    "jsonwebtoken": "^9.0.2",
    "helmet": "^7.0.0",
    "cors": "^2.8.5",
    "rate-limiter-flexible": "^3.0.8",
    "dotenv": "^16.3.1",
    "winston": "^3.10.0"
  },
  "devDependencies": {
    "nodemon": "^3.0.1",
    "jest": "^29.6.2",
    "supertest": "^6.3.3",
    "eslint": "^8.46.0"
  },
  "engines": {
    "node": ">=18.0.0"
  }
}
EOF

# Server .env.example
cat > server/.env.example << 'EOF'
# Environment
NODE_ENV=development

# Server
PORT=8080
HOST=localhost

# Database
DATABASE_URL=postgresql://username:password@localhost:5432/parentconnect
DATABASE_SSL=false

# Redis
REDIS_URL=redis://localhost:6379

# Security
JWT_SECRET=your-super-secret-jwt-key-here
BCRYPT_ROUNDS=12

# TURN Server
TURN_HOST=localhost
TURN_PORT=3478
TURN_USERNAME=parentconnect
TURN_PASSWORD=your-turn-password

# Storage (for recordings)
S3_BUCKET=parentconnect-recordings
S3_REGION=ap-south-1
AWS_ACCESS_KEY_ID=your-aws-key
AWS_SECRET_ACCESS_KEY=your-aws-secret

# Monitoring
LOG_LEVEL=info

# Rate limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100
EOF

# Docker compose for local development
cat > infra/docker-compose.yml << 'EOF'
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: parentconnect
      POSTGRES_USER: parentconnect
      POSTGRES_PASSWORD: parentconnect_dev
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./postgres/init.sql:/docker-entrypoint-initdb.d/init.sql
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U parentconnect"]
      interval: 30s
      timeout: 10s
      retries: 3

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    command: redis-server --appendonly yes
    volumes:
      - redis_data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 30s
      timeout: 10s
      retries: 3

  coturn:
    image: coturn/coturn:latest
    ports:
      - "3478:3478/udp"
      - "3478:3478/tcp"
      - "49152-65535:49152-65535/udp"
    volumes:
      - ./coturn/turnserver.conf:/etc/coturn/turnserver.conf
    command: turnserver -c /etc/coturn/turnserver.conf
    depends_on:
      - postgres

  server:
    build: 
      context: ../server
      dockerfile: Dockerfile
    ports:
      - "8080:8080"
    environment:
      NODE_ENV: development
      DATABASE_URL: postgresql://parentconnect:parentconnect_dev@postgres:5432/parentconnect
      REDIS_URL: redis://redis:6379
      TURN_HOST: coturn
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    volumes:
      - ../server:/app
      - /app/node_modules

volumes:
  postgres_data:
  redis_data:
EOF

# Basic coturn config template
mkdir -p infra/coturn
cat > infra/coturn/turnserver.conf << 'EOF'
# ParentConnect TURN Server Configuration
listening-port=3478
tls-listening-port=5349

# Public IP (replace with your server's public IP)
external-ip=127.0.0.1

# Authentication
lt-cred-mech
user=parentconnect:parentconnect_turn_secret

# Database for persistent authentication (optional)
# psql-userdb="host=postgres dbname=parentconnect user=parentconnect password=parentconnect_dev"

# Security
fingerprint
stale-nonce=600

# Logging
log-file=/var/log/turn.log
verbose

# Optimization for mobile networks
max-bps=1000000
bps-capacity=0

# Relay configuration
min-port=49152
max-port=65535

# Restrict to specific realms
realm=parentconnect.app

# Security settings
no-loopback-peers
no-multicast-peers
EOF

echo "✅ Repository structure and essential files created!"
echo ""
echo "🔧 Next steps:"
echo "1. Initialize git repository: git init"
echo "2. Add remote: git remote add origin [your-repo-url]"
echo "3. Add all files: git add ."
echo "4. Initial commit: git commit -m 'Initial repository setup'"
echo "5. Push to GitHub: git push -u origin main"
echo ""
echo "📋 Don't forget to:"
echo "- Replace placeholder values in .env.example"
echo "- Update LICENSE with your actual contact information"
echo "- Set up GitHub repository secrets for CI/CD"
echo "- Configure branch protection rules"
echo ""
echo "🚀 Happy coding!"
EOF
