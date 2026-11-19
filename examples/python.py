"""App Store Scraper - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Top free and paid charts in three countries
run = client.actor("Turboextract/app-store-charts-apps").call(run_input={
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
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("rank"), item.get("name"), item.get("developer"), item.get("ratingCount"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
