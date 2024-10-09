# Makefile for managing the MongoDB Docker setup with docker-compose

# Load environment variables from .env
include .env
export $(shell sed 's/=.*//' .env)

# Default target
.PHONY: build up down logs ps publish

# Build the Docker image and run the containers
build:
	@echo "Building and starting containers..."
	docker-compose up --build -d

# Start the containers without rebuilding
up:
	@echo "Starting containers..."
	docker-compose up -d

# Stop and remove the containers
down:
	@echo "Stopping and removing containers..."
	docker-compose down

# View logs from containers
logs:
	@echo "Viewing logs..."
	docker-compose logs -f

# Show running containers
ps:
	@echo "Showing running containers..."
	docker-compose ps

# Clean up unused Docker resources (optional)
clean:
	@echo "Cleaning up unused Docker resources..."
	docker system prune -f

# Tag and push the Docker image to DockerHub
publish:
	@echo "Tagging the image..."
	docker tag $(IMAGE_NAME):$(TAG) $(DOCKER_USERNAME)/$(IMAGE_NAME):$(TAG)
	@echo "Pushing the image to Docker Hub..."
	docker push $(DOCKER_USERNAME)/$(IMAGE_NAME):$(TAG)

# Display help
help:
	@echo "Available commands:"
	@echo "  build       Build the Docker image and run MongoDB containers"
	@echo "  up          Start MongoDB containers without rebuilding"
	@echo "  down        Stop and remove MongoDB containers"
	@echo "  logs        View logs from running MongoDB containers"
	@echo "  ps          Show running MongoDB containers"
	@echo "  clean       Clean up unused Docker resources"
	@echo "  publish     Tag and push the Docker image to Docker Hub"