const fs = require('fs');
const { execSync } = require('child_process');

function fetchAPI(endpoint) {
  try {
    const cmd = `curl -s -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${process.env.GITHUB_TOKEN}" "https://api.github.com/repos/${process.env.REPO}${endpoint}"`;
    return JSON.parse(execSync(cmd, { encoding: 'utf8' }));
  } catch (e) {
    console.warn(`Failed to fetch ${endpoint}:`, e.message);
    return null;
  }
}

// Collect all data
const timestamp = new Date().toISOString();
const entry = {
  timestamp,
  views: fetchAPI('/traffic/views'),
  clones: fetchAPI('/traffic/clones'),
  referrers: fetchAPI('/traffic/popular/referrers'),
  paths: fetchAPI('/traffic/popular/paths'),
  releases: fetchAPI('/releases')
};

// Only proceed if we got valid data
if (!entry.views && !entry.clones) {
  console.log('No valid data collected, skipping update');
  process.exit(0);
}

// Update history
const history = JSON.parse(fs.readFileSync('traffic-data/history.json', 'utf8'));
history.push(entry);

// Keep only last 156 weeks (3 years) of data
if (history.length > 156) {
  history.splice(0, history.length - 156);
}

fs.writeFileSync('traffic-data/history.json', JSON.stringify(history, null, 2));

// Copy templates to docs directory
if (!fs.existsSync('docs')) fs.mkdirSync('docs');
if (!fs.existsSync('docs/traffic-data')) fs.mkdirSync('docs/traffic-data');

// Copy HTML template
fs.copyFileSync('.github/templates/index.html', 'docs/index.html');

// Copy JavaScript file
fs.copyFileSync('.github/templates/traffic-stats.js', 'docs/traffic-stats.js');

// Copy JSON data
fs.copyFileSync('traffic-data/history.json', 'docs/traffic-data/history.json');

// Output summary for commit message
const views = entry.views?.count || 0;
const clones = entry.clones?.count || 0;
console.log(`STATS_SUMMARY=Views: ${views}, Clones: ${clones}`);