#!/usr/bin/env bash
# App Store Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~app-store-charts-apps"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Top free and paid charts in three countries (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "charts": [
      "top-free",
      "top-paid"
    ],
    "countries": [
      "us",
      "gb",
      "de"
    ],
    "chartLimit": 100
  }'

# 2. Apps for a keyword with 100+ ratings (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "searchTerms": [
      "habit tracker",
      "budget planner"
    ],
    "minRatingCount": 100
  }'

# 3. Details for specific apps (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "appIds": [
      "284882215",
      "https://apps.apple.com/us/app/instagram/id389801252"
    ],
    "includeDescription": true
  }'
