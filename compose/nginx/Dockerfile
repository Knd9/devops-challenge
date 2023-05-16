###########
# BUILDER #
###########

# pull official base image
FROM node:14-alpine3.15 as builder

# set working directory
WORKDIR /usr/src/app

# set environment variables
ARG PUBLIC_URL
ENV PUBLIC_URL $PUBLIC_URL
ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

COPY ./frontend/package.json .
COPY ./frontend/package-lock.json .
COPY ./frontend/ .

# install app dependencies
RUN npm cache clean --force
RUN npm update
RUN npm install redux@^4
RUN npm update
RUN npm install webpack-bundle-tracker --save
RUN npm audit fix --force
RUN npm update
# create build
RUN npm run build


#########
# FINAL #
#########

# base image
FROM nginx:stable-alpine

# update nginx conf
RUN rm -rf /etc/nginx/conf.d
COPY conf /etc/nginx

# copy static files
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

# expose port
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]
