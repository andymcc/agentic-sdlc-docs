#!/usr/bin/env bash
# Boot script for running the app in isolated worktrees.
# Agents use this to launch an instance per change for validation.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

echo "Building..."
go build -v -o bin/server ./cmd/server

echo "Running tests..."
go test ./... -race -count=1

echo "Starting server on :${PORT:-8080}..."
exec ./bin/server
