# Backend Dockerfile
FROM node:18-alpine

WORKDIR /app

# Install deps
COPY package*.json ./

RUN npm ci --only=production

# Install curl for health checks
RUN apk add --no-cache curl

# Copy app
COPY . .

EXPOSE 3000

ENV NODE_ENV=production

CMD ["node", "index.js"]
