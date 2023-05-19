# base image
FROM nginx:stable-alpine

WORKDIR /usr/src/app

# update nginx conf
RUN rm -rf /etc/nginx/conf.d
COPY ./compose/nginx/default.conf /etc/nginx/conf.d

# copy static files
COPY ./frontend/public/index.html /usr/share/nginx/html

# expose port
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]

