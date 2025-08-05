FROM node:20-alpine

RUN apk add --no-cache xvfb dbus-x11

WORKDIR /app
COPY package*.json ./
RUN npm ci

COPY . .
RUN npx electron-builder --linux --dir

ENV DISPLAY=:99
EXPOSE 8080

CMD ["sh", "-c", "Xvfb :99 -screen 0 1024x768x16 & electron . --no-sandbox"]
