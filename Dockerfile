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

# Copy env file template
RUN cp .env.example .env

# Install dependencies
RUN cd self-hosting && pnpm install

EXPOSE 3000

ENV PORT=3000
ENV NODE_ENV=production

CMD ["sh", "-c", "cd self-hosting && pnpm start"]