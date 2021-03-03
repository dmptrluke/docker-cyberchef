FROM node:10

WORKDIR /code
RUN npm install -g grunt-cli
RUN git clone -b master --depth=1 --branch v9.27.6 https://github.com/gchq/CyberChef.git .
RUN npm install --unsafe-perm
RUN npm run setheapsize
RUN grunt prod

FROM nginx:latest 
COPY --from=0 /code/build/prod /usr/share/nginx/html
