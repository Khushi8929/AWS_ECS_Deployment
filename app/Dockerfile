FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --only=production

COPY . .

ENV PORT=3000

EXPOSE 3000

CMD ["npm", "start"]
