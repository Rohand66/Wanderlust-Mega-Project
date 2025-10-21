#!/bin/bash

# Get the Minikube IP address
ipv4_address=$(minikube ip)

# Path to the .env file
file_to_find="../backend/.env.docker"

# Frontend port (default for Vite dev server or NodePort frontend)
FRONTEND_PORT=5173

# Desired line content
new_value="FRONTEND_URL=\"http://${ipv4_address}:${FRONTEND_PORT}\""

# Check if the file exists
if [ ! -f "$file_to_find" ]; then
    echo "❌ ERROR: File not found at $file_to_find"
    exit 1
fi

# Get current line containing FRONTEND_URL
current_url=$(grep 'FRONTEND_URL' "$file_to_find")

# Update only if IP/port has changed
if [[ "$current_url" != "$new_value" ]]; then
    echo "🔧 Updating FRONTEND_URL in $file_to_find"
    sed -i -e "s|FRONTEND_URL.*|$new_value|g" "$file_to_find"
    echo "✅ Updated: $new_value"
else
    echo "✅ No changes needed. Already up to date."
fi

