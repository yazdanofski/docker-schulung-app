FROM hugomods/hugo AS build-stage

RUN mkdir /hugo
WORKDIR /hugo
COPY . .

RUN hugo build

FROM nginx:alpine AS production-stage
COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build-stage /hugo/public /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
