FROM 339712871948.dkr.ecr.us-east-1.amazonaws.com/order:latest
RUN apk update && apk add --no-cache \
    curl \
    unzip \
    less \
    groff \
    python3 \
    py3-pip \
    git \
    aws-cli

ARG NODE_ENV=production
ARG PORT=8000

ENV PORT=${PORT}
ENV NODE_ENV=${NODE_ENV}
ENV AWS_REGION=us-east-1
ENV AWS_DYNAMODB_TABLE_PROD=lks-order-production
ENV AWS_DYNAMODB_TABLE_TEST=lks-order-testing

WORKDIR /usr/src/app
COPY . .
RUN node -v
RUN npm -v
RUN npm install


EXPOSE ${PORT}
CMD [ "npm", "run", "start" ]
