# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Go project (`github.com/EgoDZB/idzb-dev`) using Go version 1.25.4. The project is in its early stages with minimal structure.

## Project Structure

```
cmd/app/main.go    - Main application entry point
go.mod             - Go module definition
```

## Development Commands

### Running the Application
```bash
go run cmd/app/main.go
```

### Building the Application
```bash
go build -o bin/app cmd/app/main.go
```

### Running Tests
```bash
go test ./...
```

### Running a Single Test
```bash
go test -run TestName ./path/to/package
```

### Managing Dependencies
```bash
go mod tidy        # Clean up dependencies
go mod download    # Download dependencies
go get package     # Add a new dependency
```

### Formatting and Linting
```bash
go fmt ./...       # Format code
go vet ./...       # Run Go vet
```

## Architecture Notes

The project currently has a minimal structure with a single entry point at `cmd/app/main.go`. As the codebase grows, follow standard Go project layout conventions:
- `cmd/` for application entry points
- `internal/` for private application code
- `pkg/` for public library code (if needed)