# Stage 1: Build the Flutter web app
FROM dart:3.2.6-sdk AS builder

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /opt/flutter
ENV PATH="/opt/flutter/bin:${PATH}"

# Install Git
RUN apt-get update && apt-get install -y git

# Copy the Flutter project files
WORKDIR /app
COPY . .

# Enable Flutter web support
#RUN flutter upgrade
RUN flutter config --enable-web

# Build the Flutter web app
RUN flutter build web

# Stage 2: Serve the built web app using Nginx
FROM nginx:alpine

# Copy the built web app from the previous stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
