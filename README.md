# HAProxy Docker Load Balancer

A simple HAProxy reverse proxy and load balancer running on Docker, using Ubuntu 22.04.

## 📦 Features
- Load balancing using **round-robin**
- Real-time stats dashboard (`/haproxy?stats`)
- Dockerized deployment
- Easily customizable backend servers

## 🚀 Quick Start

```bash
git clone https://github.com/<your-username>/haproxy-docker.git
cd haproxy-docker
docker-compose up -d
```

Access the stats page:  
```
http://<your-server-ip>/haproxy?stats
```

## ⚙️ Configuration

All HAProxy settings are inside:
```
config/haproxy.cfg
```

You can change backend IPs, timeouts, stats URL, etc.

## 🧰 Dependencies
- Docker
- Docker Compose

## 🔒 Optional Enhancements
- Add basic auth for `/haproxy?stats`
- Use SSL with Let's Encrypt
- Enable logging to external system
