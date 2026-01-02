#!/bin/bash

echo "🚨 WARNING: This will reset your Git history!"
echo "This action cannot be undone easily."
echo ""
echo "What will happen:"
echo "  - Create a backup branch"
echo "  - Reset CHANGELOG.md"
echo "  - Set version to 0.0.0"
echo "  - Create fresh Git history"
echo "  - Force push to origin"
echo ""
echo "Press Ctrl+C to cancel, or Enter to continue..."
read

# Create backup with timestamp
BACKUP_BRANCH="backup-$(date +%Y%m%d-%H%M%S)"
echo "📦 Creating backup branch: $BACKUP_BRANCH"
git branch $BACKUP_BRANCH

# Clean changelog
echo "📝 Resetting CHANGELOG.md..."
cat > CHANGELOG.md << 'EOF'
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Follows [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
EOF

# Reset manifest
echo "📋 Resetting version manifest..."
echo '{".":"0.0.0"}' > .release-please-manifest.json

# Update package.json version
echo "📦 Updating package.json..."
if command -v jq &> /dev/null; then
    jq '.version = "0.0.0"' package.json > package.json.tmp && mv package.json.tmp package.json
else
    # Manual fallback if jq is not installed
    sed -i 's/"version": "[^"]*"/"version": "0.0.0"/' package.json
fi

# Create fresh history
echo "🔄 Creating fresh Git history..."
git checkout --orphan fresh-start
git add -A
git commit -m "chore: initial commit"

# Replace main branch
echo "🔀 Replacing main branch..."
git branch -D main
git branch -m main

# Clean up remote release-please branch
echo "🧹 Cleaning up release-please branch..."
git push origin --delete release-please--branches--main 2>/dev/null || echo "  (no release-please branch to delete)"

# Force push
echo "🚀 Force pushing to origin..."
git push -f origin main

echo ""
echo "✅ Done! Your repo has been reset."
echo "📦 Backup saved in branch: $BACKUP_BRANCH"
echo ""
echo "Next steps:"
echo "  1. Make a commit with conventional format:"
echo "     git commit -m 'feat: add initial features'"
echo "  2. Push to trigger release-please:"
echo "     git push origin main"