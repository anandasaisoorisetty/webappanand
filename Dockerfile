# Stage 1: Build Angular app with npm
FROM node:14 AS builder

WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app source code
COPY . .

# Build the Angular app
RUN npm run build

# Stage 2: Serve the built app with Nginx
FROM nginx:latest

# Copy the built app from the previous stage
COPY --from=builder /app/dist/webappanand /usr/share/nginx/html

# Copy the Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
