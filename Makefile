.PHONY: help build run test clean fmt vet docker-build docker-run docker-stop deps tidy

# Variables
APP_NAME=app
BINARY_DIR=bin
MAIN_PATH=cmd/app/main.go
DOCKER_IMAGE=idzb-dev
DOCKER_TAG=latest

help:
	@echo "Available targets:"
	@echo "  make build          - Build the application binary"
	@echo "  make run            - Run the application"
	@echo "  make test           - Run all tests"
	@echo "  make clean          - Remove build artifacts"
	@echo "  make fmt            - Format code"
	@echo "  make vet            - Run go vet"
	@echo "  make deps           - Download dependencies"
	@echo "  make tidy           - Clean up dependencies"
	@echo "  make docker-build   - Build Docker image"
	@echo "  make docker-run     - Run Docker container"
	@echo "  make docker-stop    - Stop Docker container"

build:
	@echo "Building $(APP_NAME)..."
	@mkdir -p $(BINARY_DIR)
	@go build -o $(BINARY_DIR)/$(APP_NAME) $(MAIN_PATH)
	@echo "Build complete: $(BINARY_DIR)/$(APP_NAME)"

run:
	@echo "Running $(APP_NAME)..."
	@go run $(MAIN_PATH)

test:
	@echo "Running tests..."
	@go test ./... -v

clean:
	@echo "Cleaning..."
	@rm -rf $(BINARY_DIR)
	@go clean
	@echo "Clean complete"

fmt:
	@echo "Formatting code..."
	@go fmt ./...

vet:
	@echo "Running go vet..."
	@go vet ./...

deps:
	@echo "Downloading dependencies..."
	@go mod download

tidy:
	@echo "Tidying dependencies..."
	@go mod tidy

docker-build:
	@echo "Building Docker image..."
	@docker build --progress=plain --no-cache -t $(DOCKER_IMAGE):$(DOCKER_TAG) .
	@echo "Docker image built: $(DOCKER_IMAGE):$(DOCKER_TAG)"

docker-run:
	@echo "Running Docker container..."
	@docker run -d --name $(DOCKER_IMAGE) -p 3000:3000 $(DOCKER_IMAGE):$(DOCKER_TAG)
	@echo "Container running on port 3000"

docker-stop:
	@echo "Stopping Docker container..."
	@docker stop $(DOCKER_IMAGE) || true
	@docker rm $(DOCKER_IMAGE) || true
	@echo "Container stopped"