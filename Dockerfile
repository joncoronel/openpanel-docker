# Use Node.js as base
FROM node:20-slim

# Install pnpm and other dependencies including Python
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3 \
    python3-pip \
    build-essential \
    && npm install -g pnpm

# Set working directory
WORKDIR /app

# Clone OpenPanel repository
RUN git clone https://github.com/Openpanel-dev/openpanel.git .

# Copy env file template
RUN cp .env.example .env

# Install dependencies
RUN cd self-hosting && pnpm install

# Expose necessary port
EXPOSE 3000

# Set environment variables
ENV PORT=3000
ENV NODE_ENV=production

# Debug: List files and check package.json
RUN ls -la self-hosting && cat self-hosting/package.json

# Start command
CMD ["sh", "-c", "cd self-hosting && ls -la && node server.js"]