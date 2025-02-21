FROM 339712871948.dkr.ecr.us-east-1.amazonaws.com/order:latest

# Install dependencies
RUN apk update && apk add --no-cache \
    curl \
    unzip \
    less \
    groff \
    python3 \
    py3-pip \
    git \
    aws-cli

# Set environment variables
ARG NODE_ENV=production
ARG PORT=8000
ARG AWS_ACCESS_KEY
ARG AWS_SECRET_KEY

ENV AWS_ACCESS_KEY=$AWS_ACCESS_KEY
ENV AWS_SECRET_KEY=$AWS_SECRET_KEY
ENV PORT=8000
ENV NODE_ENV=${NODE_ENV}
ENV AWS_REGION=us-east-1
ENV AWS_DYNAMODB_TABLE_PROD=lks-order-production
ENV AWS_DYNAMODB_TABLE_TEST=lks-order-testing

# Ambil AWS credentials langsung dari SSM saat build
RUN export PORT=8000
RUN export AWS_ACCESS_KEY=$(aws ssm get-parameter --name "/course-order/AWS_ACCESS_KEY" --with-decryption --query "Parameter.Value" --output text) && \
    export AWS_SECRET_KEY=$(aws ssm get-parameter --name "/course-order/AWS_SECRET_KEY" --with-decryption --query "Parameter.Value" --output text)

# Debugging: Periksa apakah kredensial berhasil diambil
RUN echo "AWS Access Key: $AWS_ACCESS_KEY" && aws sts get-caller-identity

# Set work directory dan copy source code
WORKDIR /usr/src/app
COPY . .

# Install dependencies
RUN node -v
RUN npm -v
RUN npm install

# Expose port
EXPOSE 8000

# Jalankan aplikasi
CMD ["npm", "run", "start"]
