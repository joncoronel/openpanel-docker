# Use Node.js as base
FROM node:20-slim

# Install pnpm and other dependencies
RUN apt-get update && apt-get install -y git curl && \
    npm install -g pnpm

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

# Start command
CMD ["sh", "-c", "cd self-hosting && ./start"]