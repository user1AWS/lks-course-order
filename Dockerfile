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
ARG AWS_ACCESS_KEY
ARG AWS_SECRET_KEY

ENV AWS_ACCESS_KEY=$AWS_ACCESS_KEY
ENV AWS_SECRET_KEY=$AWS_SECRET_KEY
ENV PORT=${PORT}
ENV NODE_ENV=${NODE_ENV}
ENV AWS_REGION=us-east-1
ENV AWS_DYNAMODB_TABLE_PROD=lks-order-production
ENV AWS_DYNAMODB_TABLE_TEST=lks-order-testing

WORKDIR /usr/src/app
COPY . .

RUN aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID && \
    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY && \
    aws configure set region $AWS_REGION && \
    aws sts get-caller-identity

RUN echo "AWS Access Key: $AWS_ACCESS_KEY_ID" && \
    echo "AWS Secret Key: $AWS_SECRET_ACCESS_KEY" && \
    aws sts get-caller-identity

RUN node -v
RUN npm -v
RUN npm install


EXPOSE ${PORT}
CMD [ "npm", "run", "start" ]
