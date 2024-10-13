# Stage 1: Build stage
FROM mongo:latest AS builder

# Set the working directory
WORKDIR /app

# Create a non-root user
RUN useradd -ms /bin/bash mongodbuser

# Copy initialization script to build context
COPY init-mongo.sh .

# Stage 2: Final stage
FROM mongo:latest

# Set the working directory for the final stage
WORKDIR /data/db

# Create the non-root user and group
RUN groupadd mongodbuser && \
    useradd -m -g mongodbuser mongodbuser

# Set environment variables for MongoDB initialization
ENV MONGO_INITDB_ROOT_USERNAME=${MONGO_INITDB_ROOT_USERNAME}
ENV MONGO_INITDB_ROOT_PASSWORD=${MONGO_INITDB_ROOT_PASSWORD}
ENV DB_USERNAME=${DB_USERNAME}
ENV DB_USER_PASSWORD=${DB_USER_PASSWORD}
ENV DB_NAME=${DB_NAME}

# Copy initialization script to the final stage
COPY --from=builder /app/init-mongo.sh /docker-entrypoint-initdb.d/

# Create the data directory, set ownership and permissions
RUN mkdir -p /data/db && \
    chown -R mongodbuser:mongodbuser /data/db

# Expose the MongoDB port
EXPOSE 27017

# Switch to the non-root user
USER mongodbuser

# Start MongoDB
CMD ["mongod", "--bind_ip", "0.0.0.0"]