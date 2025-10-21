#!/bin/bash

# Get the Minikube IP address
ipv4_address=$(minikube ip)

# Path to the .env file
file_to_find="../frontend/.env.docker"

# Port your backend service is exposed on (NodePort)
BACKEND_PORT=31100

# Desired line to set
new_value="VITE_API_PATH=\"http://${ipv4_address}:${BACKEND_PORT}\""

# Check if the file exists
if [ ! -f "$file_to_find" ]; then
    echo "❌ ERROR: File not found at $file_to_find"
    exit 1
fi

# Check current value
current_url=$(grep 'VITE_API_PATH' "$file_to_find")

# Update only if the IP has changed
if [[ "$current_url" != "$new_value" ]]; then
    echo "🔧 Updating VITE_API_PATH in $file_to_find"
    sed -i -e "s|VITE_API_PATH.*|$new_value|g" "$file_to_find"
    echo "✅ Updated: $new_value"
else
    echo "✅ No changes needed. Already up to date."
fi

