#!/usr/bin/env bash
# Generates docs/user/api-reference.md from docs/api/openapi.yaml.
# Agents and CI use this to keep user docs in sync with the API spec.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
SPEC="$PROJECT_ROOT/docs/api/openapi.yaml"
OUTPUT="$PROJECT_ROOT/docs/user/api-reference.md"

if ! command -v yq &> /dev/null; then
  echo "Error: yq is required. Install with: brew install yq" >&2
  exit 1
fi

# Header
cat > "$OUTPUT" <<'HEADER'
# API Reference

Generated from `docs/api/openapi.yaml`. Do not edit manually.

## Endpoints
HEADER

# Get all paths
paths=$(yq -r '.paths | keys | .[]' "$SPEC")

for path in $paths; do
  # Get all methods for this path
  methods=$(yq -r ".paths.\"$path\" | keys | .[]" "$SPEC")

  for method in $methods; do
    method_upper=$(echo "$method" | tr '[:lower:]' '[:upper:]')
    summary=$(yq -r ".paths.\"$path\".${method}.summary // \"\"" "$SPEC")
    description=$(yq -r ".paths.\"$path\".${method}.description // \"\"" "$SPEC")

    echo "" >> "$OUTPUT"
    echo "### ${method_upper} ${path}" >> "$OUTPUT"
    echo "" >> "$OUTPUT"

    if [ -n "$summary" ]; then
      echo "${summary}." >> "$OUTPUT"
    fi
    if [ -n "$description" ] && [ "$description" != "$summary" ]; then
      echo "${description}" >> "$OUTPUT"
    fi

    # Extract response codes and descriptions
    response_codes=$(yq -r ".paths.\"$path\".${method}.responses | keys | .[]" "$SPEC" 2>/dev/null || true)

    for code in $response_codes; do
      resp_desc=$(yq -r ".paths.\"$path\".${method}.responses.\"$code\".description // \"No description\"" "$SPEC")
      echo "" >> "$OUTPUT"
      echo "**Response ${code}** — ${resp_desc}" >> "$OUTPUT"

      # Extract example schema properties if present
      has_schema=$(yq -r ".paths.\"$path\".${method}.responses.\"$code\".content.\"application/json\".schema // \"null\"" "$SPEC" 2>/dev/null)
      if [ "$has_schema" != "null" ]; then
        echo "" >> "$OUTPUT"
        echo '```json' >> "$OUTPUT"
        yq -r -o=json ".paths.\"$path\".${method}.responses.\"$code\".content.\"application/json\".schema.properties" "$SPEC" >> "$OUTPUT"
        echo '```' >> "$OUTPUT"
      fi
    done
  done
done

echo "Generated: $OUTPUT"
