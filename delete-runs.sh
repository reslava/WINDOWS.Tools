#!/bin/bash

REPO="reslava/WINDOWS.Tools"

echo "🔍 Fetching workflow runs..."

# Get all run IDs
RUN_IDS=$(gh api --paginate "repos/$REPO/actions/runs" --jq '.workflow_runs[].id')

if [ -z "$RUN_IDS" ]; then
    echo "✅ No workflow runs found to delete."
    exit 0
fi

# Count total runs
TOTAL=$(echo "$RUN_IDS" | wc -l)
echo "📊 Found $TOTAL workflow runs to delete"
echo ""

COUNTER=0
echo "$RUN_IDS" | while read -r RUN_ID; do
    COUNTER=$((COUNTER + 1))
    echo "[$COUNTER/$TOTAL] Deleting run $RUN_ID..."
    
    if gh api -X DELETE "repos/$REPO/actions/runs/$RUN_ID" 2>/dev/null; then
        echo "  ✅ Deleted"
    else
        echo "  ❌ Failed (may already be deleted or no permission)"
    fi
    
    # Small delay to avoid rate limiting
    sleep 0.5
done

echo ""
echo "✅ Done!"