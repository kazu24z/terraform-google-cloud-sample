FROM node:20 as builder

WORKDIR /app
COPY package.json package-lock.json tsconfig.json ./
RUN npm ci

COPY . .

RUN npx prisma generate
RUN npm run build

FROM node:20 as runner

WORKDIR /app
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/package-lock.json ./package-lock.json

EXPOSE 8080

CMD ["node", "./build/index.js"]
