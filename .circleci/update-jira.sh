#!/usr/bin/env bash

set -euo pipefail

# Use JIRA automation webhooks to move issues to SHIPPED:
# https://support.atlassian.com/jira-software-cloud/docs/automation-triggers/#Automationtriggers-Incomingwebhook

git log --max-count=50 --pretty=format:'%s' | grep -Eo '^\w+-[0-9]+' | sort -u | while read i; do
  curl -X POST "$UPDATE_JIRA_WEBHOOK_URL?issue=$i"
done
