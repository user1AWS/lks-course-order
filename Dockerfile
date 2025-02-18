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

WORKDIR /usr/src/app
RUN git clone https://github.com/user1AWS/lks-course-order.git /usr/src/app
COPY . .
RUN node -v
RUN npm -v
RUN npm install


EXPOSE ${PORT}
CMD [ "npm", "run", "start" ]
