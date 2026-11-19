// App Store Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Apps for a keyword with 100+ ratings
const run = await client.actor('Turboextract/app-store-charts-apps').call({
    "searchTerms": [
        "habit tracker",
        "budget planner"
    ],
    "minRatingCount": 100
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.rank, item.name, item.developer, item.ratingCount);
}
