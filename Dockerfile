FROM node:24.4.1-alpine

ENV NODE_ENV=production \
    HOST=0.0.0.0 \
    PORT=8100

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --omit=dev --ignore-scripts \
    && npm cache clean --force

COPY src ./src
COPY .env.example README.md LICENSE ./

RUN chmod +x src/servers/*.js

EXPOSE 8100

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD node -e "fetch('http://127.0.0.1:' + (process.env.PORT || 8100) + '/health').then(r => process.exit(r.ok ? 0 : 1)).catch(() => process.exit(1))"

CMD ["node", "src/servers/all.js", "--http", "--host", "0.0.0.0", "--port", "8100"]
