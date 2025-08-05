FROM node:20-alpine

WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev

COPY backend/src ./src
COPY contract ./contract

CMD ["node", "src/index.js"]
