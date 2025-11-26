# Stage 1: Build the Angular app
FROM node:20-bullseye AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular app
RUN npm run build --prod

# Stage 2: Serve the app with Nginx
FROM nginx:stable-alpine

# Copy the built Angular app from the build stage
COPY --from=build /app/dist/angular-conduit/browser /usr/share/nginx/html



EXPOSE 3000


# Start Nginx
CMD ["nginx", "-g", "daemon off;"]