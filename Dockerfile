# Gunakan base image yang ringan
FROM node:16-alpine

# Install dependencies yang dibutuhkan AWS CLI v2
RUN apk add --no-cache \
    curl \
    unzip \
    less \
    groff \
    python3 \
    py3-pip

# Download dan install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

# Verifikasi instalasi AWS CLI
RUN aws --version

# Lanjutkan dengan perintah yang ada
WORKDIR /usr/src/app
COPY . .
RUN npm install

EXPOSE 8000
CMD [ "npm", "run", "start" ]
