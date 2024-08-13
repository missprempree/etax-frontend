# Use an official Node.js runtime as a parent image
FROM node:18.12.1 AS build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the React app for production
RUN npm run build

# Use an official NGINX image to serve the built app
FROM nginx:latest

# Adjust permissions for Nginx directories
RUN mkdir -p /var/run/nginx && chown -R nginx:nginx /var/run/nginx

# Run NGINX as the nginx user
USER nginx

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]

# Labelize
LABEL org.opencontainers.image.source=https://github.com/missprempree/etax-frontend
