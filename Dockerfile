FROM node:20-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends python3 ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json bun.lock* package-lock.json* ./
RUN npm install --no-audit --no-fund

COPY . .

RUN npm run build

ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000

CMD ["npm", "start"]
