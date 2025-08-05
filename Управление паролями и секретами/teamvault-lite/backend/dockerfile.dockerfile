FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY backend/src ./src
CMD ["node", "src/index.js"]
