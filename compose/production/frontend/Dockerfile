FROM node:14-alpine3.15

# set working directory
WORKDIR /usr/src/app

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

COPY ./frontend/package.json .
COPY ./frontend/package-lock.json .
COPY ./frontend/yarn.lock .

# copy project
COPY ./frontend .

# install app dependencies
RUN npm install

CMD ["npm", "start"]
