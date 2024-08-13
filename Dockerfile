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
FROM nginx:alpine

# Copy the build output to the NGINX html directory
COPY --from=build /app/build /usr/share/nginx/html

# Ensure NGINX runs with the necessary permissions 
#RUN mkdir -p /var/cache/nginx/client_temp && \
#    chown -R nginx:nginx /var/cache/nginx /usr/share/nginx/html
#RUN mkdir -p /var/cache/nginx && \
#    chown -R nginx:nginx /var/cache/nginx /usr/share/nginx/html
RUN mkdir -p /var/cache/nginx/client_temp /var/cache/nginx/proxy_temp && \
    chown -R nginx:nginx /var/cache/nginx /usr/share/nginx/html /etc/nginx/conf.d

# Remove the user directive from the NGINX configuration
RUN sed -i '/user  nginx;/d' /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 8080

# Run NGINX as the nginx user
USER nginx

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]

LABEL org.opencontainers.image.source=https://github.com/missprempree/etax-frontend
