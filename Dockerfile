FROM node:10-alpine


# Healthcheck
HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
    CMD wget -q --spider http://localhost:8080/health || exit 1

# NodeJS Setup
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package*.json ./

USER node
RUN npm install --only=production
COPY --chown=node:node ./src .

RUN npm run build

EXPOSE 8080
CMD [ "node", "./dist/index.js" ]
