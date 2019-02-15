FROM node

ARG proxy
ENV http_proxy=$proxy
ENV HTTP_PROXY=$proxy
ENV https_proxy=$proxy
ENV HTTPS_PROXY=$proxy
ENV no_proxy=127.0.0.1,localhost
ENV NO_PROXY=127.0.0.1,localhost

RUN npm config set proxy $proxy
RUN npm config set https-proxy $proxy

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

RUN npm config set proxy ""
RUN npm config set https-proxy ""
ENV http_proxy=""
ENV HTTP_PROXY=""
ENV https_proxy=""
ENV HTTPS_PROXY=""

EXPOSE 8086
CMD [ "npm", "start" ]
