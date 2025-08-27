# Backend Dockerfile
FROM node:18-alpine

WORKDIR /app

# Install deps
COPY package*.json ./

RUN npm ci --only=production

# Copy app
COPY . .

EXPOSE 3000

ENV NODE_ENV=production

CMD ["node", "index.js"]
