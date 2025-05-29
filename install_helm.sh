#!/bin/bash

echo "Attempting to install Helm using method 1..."

# Try the first method
if curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash; then
    echo "Helm installed successfully using method 1."
    exit 0
else
    echo "Method 1 failed. Trying method 2..."
fi

# Fallback method
TEMP_SCRIPT="get_helm.sh"
if curl -fsSL https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get-helm-3 -o "$TEMP_SCRIPT"; then
    chmod 700 "$TEMP_SCRIPT"
    if ./"$TEMP_SCRIPT"; then
        echo "Helm installed successfully using method 2."
        rm -f "$TEMP_SCRIPT"
        exit 0
    else
        echo "Helm installation failed using method 2."
        rm -f "$TEMP_SCRIPT"
        exit 1
    fi
else
    echo "Failed to download script for method 2."
    exit 1
fi

