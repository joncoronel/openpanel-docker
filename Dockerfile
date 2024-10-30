FROM node:20-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3 \
    python3-pip \
    build-essential \
    && npm install -g pnpm

WORKDIR /app

# Clone OpenPanel repository
RUN git clone https://github.com/Openpanel-dev/openpanel.git .

# Install dependencies
WORKDIR /app/self-hosting
RUN pnpm install

# Debug: Show package.json content
RUN echo "Package.json content:" && cat package.json

# Set environment variables
ENV PORT=3000
ENV NODE_ENV=production

EXPOSE 3000

# Start using the development server for now
CMD ["sh", "-c", "pnpm dev"]