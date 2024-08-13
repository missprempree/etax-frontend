# Use an official Node.js runtime as a parent image
FROM node:18.12.1

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
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
