.PHONY: build run test test-cover lint fmt vet clean check docs-gen docs-check docs-serve

BINARY_NAME=server
BUILD_DIR=bin
GO=go
GOFLAGS=-v
COVER_PROFILE=coverage.out

# Build the application
build:
	$(GO) build $(GOFLAGS) -o $(BUILD_DIR)/$(BINARY_NAME) ./cmd/server

# Run the application
run: build
	./$(BUILD_DIR)/$(BINARY_NAME)

# Run all tests
test:
	$(GO) test ./... -race -count=1

# Run tests with coverage report
test-cover:
	$(GO) test ./... -race -coverprofile=$(COVER_PROFILE) -covermode=atomic
	$(GO) tool cover -func=$(COVER_PROFILE)

# Run linter
lint:
	golangci-lint run ./...

# Format code
fmt:
	$(GO) fmt ./...
	goimports -w .

# Run go vet
vet:
	$(GO) vet ./...

# Remove build artifacts
clean:
	rm -rf $(BUILD_DIR) $(COVER_PROFILE) coverage.html tmp/

# Generate API reference docs from OpenAPI spec
docs-gen:
	./scripts/gen-api-docs.sh

# Check that generated docs are in sync with spec
docs-check:
	./scripts/docs-check.sh

# Serve user docs locally (requires mkdocs: pip install mkdocs-material)
docs-serve:
	mkdocs serve

# Run all checks (CI parity)
check: fmt vet lint test docs-check
