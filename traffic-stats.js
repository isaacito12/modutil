// Load traffic data and create visualizations
fetch('./traffic-data/history.json')
    .then(response => response.json())
    .then(data => {
        const latest = data[data.length - 1];
        
        // Update stats cards
        document.getElementById('total-views').textContent = latest.views?.count || '0';
        document.getElementById('total-clones').textContent = latest.clones?.count || '0';
        document.getElementById('unique-visitors').textContent = latest.views?.uniques || '0';
        
        // Release downloads
        const latestRelease = latest.releases?.[0];
        const downloads = latestRelease?.assets?.reduce((sum, asset) => sum + (asset.download_count || 0), 0) || 0;
        document.getElementById('release-downloads').textContent = downloads;
        
        // Last updated
        document.getElementById('last-updated').textContent = 'Last updated: ' + new Date(latest.timestamp).toLocaleDateString();
        
        // Create chart
        const ctx = document.getElementById('trafficChart').getContext('2d');
        const chartData = data.slice(-12).map(entry => ({
            date: new Date(entry.timestamp).toLocaleDateString(),
            views: entry.views?.count || 0,
            clones: entry.clones?.count || 0
        }));
        
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: chartData.map(d => d.date),
                datasets: [{
                    label: 'Views',
                    data: chartData.map(d => d.views),
                    borderColor: '#007bff',
                    backgroundColor: 'rgba(0,123,255,0.1)',
                    tension: 0.1
                }, {
                    label: 'Clones',
                    data: chartData.map(d => d.clones),
                    borderColor: '#28a745',
                    backgroundColor: 'rgba(40,167,69,0.1)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    title: {
                        display: true,
                        text: 'Traffic Trends (Last 12 Weeks)'
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    })
    .catch(error => {
        console.error('Error loading traffic data:', error);
        document.querySelector('.container').innerHTML = '<h1>Error loading traffic data</h1>';
    });