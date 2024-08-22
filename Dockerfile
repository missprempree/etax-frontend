# Use an official Node.js runtime as a parent image
FROM node:18.12.1-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json into the container
COPY package*.json ./

# Install dependencies
RUN npm install --silent

# Copy the rest of the application code into the container
COPY . .

# Build the React application
RUN npm run build

# Expose the port that the app will run on
EXPOSE 3000

# Start the Node.js application
CMD ["npm", "start"]

# Labelize
LABEL org.opencontainers.image.source=https://github.com/missprempree/etax-frontend
