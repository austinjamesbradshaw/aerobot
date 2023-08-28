FROM node:16-bullseye
ARG SESSION_SECRET_KEY
ARG DATABASE_URL

ENV SESSION_SECRET_KEY=$SESSION_SECRET_KEY
ENV NODE_ENV=production
ENV PATH /home/node/app/node_modules/.bin:$PATH
ENV TINI_VERSION v0.19.0
WORKDIR /home/node/app
RUN chown -R node:node /home/node/app
 
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
USER node
COPY --chown=node:node package*.json yarn.lock* ./
 
RUN npm ci --only=production --ignore-scripts
 
COPY --chown=node:node . .

RUN blitz build

EXPOSE 3000

CMD blitz start --port 3000
ENTRYPOINT ["/tini", "--"]