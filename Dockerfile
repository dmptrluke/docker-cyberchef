FROM --platform=$BUILDPLATFORM node:17 as build
ARG VERSION

WORKDIR /code
RUN npm install -g grunt-cli
RUN git clone -b master --depth=1 --branch "$VERSION" https://github.com/gchq/CyberChef.git .
RUN npm install --unsafe-perm
RUN npm run setheapsize
RUN grunt prod

FROM nginx:latest-alpine
COPY --from=build /code/build/prod /usr/share/nginx/html
