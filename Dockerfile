FROM node:20-alpine

ARG GIT_COMMIT
ARG GIT_BRANCH


# Healthcheck
HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
    CMD wget -q --spider http://localhost:8080/health || exit 1

# NodeJS Setup
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app

# TypeScript Setup
RUN npm install -g typescript

USER node

COPY --chown=node:node . .

RUN npm cache clean --force && \
    npm install --unsafe-perm && \
    npm run build

RUN npm prune --omit=dev

EXPOSE 8080
CMD [ "node", "-r", "./dist/src/telemetry.js ./dist/src/index.js" ]
