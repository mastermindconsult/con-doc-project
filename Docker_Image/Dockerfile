# Use NGINX as base image
FROM nginx:latest

# Copy  HTML files to the container
COPY . /usr/share/nginx/html/

# Expose port 80 and 443 for incoming traffic
EXPOSE 80 443

# Start NGINX server on container lunch
CMD ["nginx", "-g", "daemon off;"]

