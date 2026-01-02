#!/bin/bash

REPO="reslava/WINDOWS.Tools"

echo "⚠️  WARNING: This will delete ALL releases and tags!"
echo "Press Ctrl+C to cancel, or Enter to continue..."
read

# Method 1: Using gh release (recommended)
echo "📦 Deleting releases..."
gh release list --repo $REPO --limit 1000 | while IFS=$'\t' read -r title type tag; do
    echo "  Deleting: $tag"
    gh release delete "$tag" --repo $REPO --yes --cleanup-tag 2>/dev/null
    sleep 0.5
done

# Cleanup any remaining tags
echo ""
echo "🧹 Cleaning up remaining tags..."
git fetch --tags origin 2>/dev/null
git tag | while read -r tag; do
    echo "  Deleting local tag: $tag"
    git tag -d "$tag" 2>/dev/null
    git push --delete origin "$tag" 2>/dev/null
    sleep 0.3
done

echo ""
echo "✅ All releases and tags deleted!"