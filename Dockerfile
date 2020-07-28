FROM node:10

WORKDIR /code
RUN npm install -g grunt-cli
RUN git clone https://github.com/gchq/CyberChef.git .
ENV NODE_OPTIONS=--max_old_space_size=2048
RUN npm install
RUN grunt prod

FROM nginx:latest 
COPY --from=0 /code/build/prod /usr/share/nginx/html