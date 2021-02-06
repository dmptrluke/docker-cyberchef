FROM node:10
ENV NODE_OPTIONS=--max_old_space_size=2048

WORKDIR /code
RUN npm install -g grunt-cli
RUN git clone -b master --depth=1 --branch v9.24.3 https://github.com/gchq/CyberChef.git .
RUN npm install --unsafe-perm
RUN grunt prod

FROM nginx:latest 
LABEL version=v9.24.3
COPY --from=0 /code/build/prod /usr/share/nginx/html
