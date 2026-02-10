FROM node:20 AS build
WORKDIR /opt/server
COPY package.json .
COPY server.js .
RUN npm install

FROM node:20.19-alpine
WORKDIR /opt/server
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop 
ENV REDIS_HOST=redis \
    CATALOGUE_HOST=catalogue \
    CATALOGUE_PORT=8080    
LABEL created_by="Kishore" \
      component="cart" \
      project="roboshop"
EXPOSE 8080
# Copying build artifacts from build stage and also changing ownership to roboshop user. THis is more efficient way than using separate RUN command for ownership change
COPY --from=build --chown=roboshop:roboshop /opt/server .
USER roboshop
# CMD providing default arguments to ENTRYPOINT - so the CMD that keeps the container running will be CMD ["node", "server.js"]
ENTRYPOINT ["node"]
CMD ["server.js"]

# FROM node:20
# WORKDIR /opt/server
# COPY package.json .
# COPY server.js .
# RUN npm install
# EXPOSE 8080
# ENV REDIS_HOST=redis \
#     CATALOGUE_HOST=catalogue \
#     CATALOGUE_PORT=8080
# CMD ["node", "server.js"]
