# Gunakan base image yang ringan
FROM node:18-alpine

# Set direktori kerja awal
WORKDIR /usr/src/app

# Install dependencies yang dibutuhkan AWS CLI v2
RUN apk update && apk add --no-cache \
    curl \
    unzip \
    less \
    groff \
    python3 \
    py3-pip \
    git \
    aws-cli

# Clone repository agar file app.js tersedia
RUN git clone https://github.com/user1AWS/lks-course-order.git /usr/src/app

# Pastikan file ada
RUN ls -l /usr/src/app

# Salin semua file setelah cloning
COPY . .

# Install dependencies
RUN npm install

# Expose port aplikasi
EXPOSE 8000

# Jalankan aplikasi
CMD [ "npm", "run", "start" ]
