#!/usr/bin/env bash
# Validates that generated docs are in sync with the API spec.
# Used by CI to enforce that agents updated docs when the spec changed.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
OUTPUT="$PROJECT_ROOT/docs/user/api-reference.md"

# Save current state
cp "$OUTPUT" "$OUTPUT.bak"

# Regenerate
"$SCRIPT_DIR/gen-api-docs.sh" > /dev/null

# Compare
if ! diff -q "$OUTPUT.bak" "$OUTPUT" > /dev/null 2>&1; then
  echo "ERROR: docs/user/api-reference.md is out of sync with docs/api/openapi.yaml"
  echo ""
  echo "Diff:"
  diff "$OUTPUT.bak" "$OUTPUT" || true
  echo ""
  echo "Run 'make docs-gen' to regenerate."
  # Restore original so the working tree isn't modified by CI
  mv "$OUTPUT.bak" "$OUTPUT"
  exit 1
fi

rm "$OUTPUT.bak"
echo "Docs are in sync."
