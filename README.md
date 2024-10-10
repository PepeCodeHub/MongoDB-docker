# 🚀 MongoDB in Docker

## 📖 Overview
This project sets up a MongoDB instance using Docker and Docker Compose. It includes:
- A `Dockerfile` for building a custom MongoDB image.
- A `docker-compose.yml` file for defining the services.
- A `Makefile` for managing the Docker setup.
- An initialization script for setting up the database.

## 📂 Files

### 📝 docker-compose.yml
Defines the MongoDB service, including environment variables, volumes, ports, and networks.

### 🛠️ Dockerfile
Builds a custom MongoDB image with the following stages:
- **Build stage**: Copies the initialization script.
- **Final stage**: Sets up the MongoDB environment, copies the initialization script, and starts MongoDB.

### 📋 Makefile
Provides commands for managing the Docker setup:
- `build`: Build the Docker image and run the containers.
- `up`: Start the containers without rebuilding.
- `down`: Stop and remove the containers.
- `logs`: View logs from containers.
- `ps`: Show running containers.
- `clean`: Clean up unused Docker resources.
- `publish`: Tag and push the Docker image to Docker Hub.
- `help`: Display available commands.

### 🏁 init-mongo.sh
Initialization script that waits for MongoDB to start, creates a database, a user with read and write access, and a dummy collection with a sample document.

### 📄 .env.example
Example environment variables file to configure MongoDB credentials and Docker image details.

## 🚀 Usage
1. Copy `.env.example` to `.env` and fill in the required values.
2. Use the Makefile commands to manage the Docker setup:
    - `make build` to build and start the containers.
    - `make up` to start the containers without rebuilding.
    - `make down` to stop and remove the containers.
    - `make logs` to view logs from the containers.
    - `make ps` to show running containers.
    - `make clean` to clean up unused Docker resources.
    - `make publish` to tag and push the Docker image to Docker Hub.
    - `make help` to display available commands.

Happy coding! 🎉