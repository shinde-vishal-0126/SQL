$TargetDir = "d:\IMP\SQL\mysql\mysql_basic"

function Write-Svg {
    param (
        [string]$FileName,
        [string]$Content
    )
    $Path = Join-Path $TargetDir $FileName
    [System.IO.File]::WriteAllText($Path, $Content, [System.Text.Encoding]::UTF8)
    Write-Host "Generated $Path"
}

$Theme = @{
    bg = "#1E1E1E"
    boxBg = "#2D2D30"
    border = "#3E3E42"
    textPrimary = "#E0E0E0"
    textSecondary = "#A0A0A0"
    accent1 = "#4FC1FF" # Blue
    accent2 = "#4EC9B0" # Green
    accent3 = "#C586C0" # Purple
    accent4 = "#DCDCAA" # Yellow
    accent5 = "#F44747" # Red
}

$svg_aggregation_overview = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Aggregation Functions Overview</text>
    <text x="300" y="55" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Accept multiple rows -> Return a SINGLE summarized value.</text>
    
    <rect x="50" y="80" width="100" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="100" y="100" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">COUNT()</text>
    
    <rect x="250" y="80" width="100" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="300" y="100" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">SUM()</text>

    <rect x="450" y="80" width="100" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent3)" stroke-width="2"/>
    <text x="500" y="100" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">AVG()</text>

    <rect x="50" y="140" width="100" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="100" y="160" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">MIN()</text>

    <rect x="250" y="140" width="100" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent5)" stroke-width="2"/>
    <text x="300" y="160" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">MAX()</text>

    <rect x="420" y="140" width="160" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.textSecondary)" stroke-width="2"/>
    <text x="500" y="160" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">GROUP_CONCAT()</text>
</svg>
"@

$svg_window_vs_groupby = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">GROUP BY vs WINDOW FUNCTIONS</text>
    
    <!-- GROUP BY -->
    <rect x="20" y="60" width="260" height="160" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="150" y="90" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">GROUP BY</text>
    <text x="150" y="120" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Squashes / Collapses Rows</text>
    <text x="150" y="150" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Loses row-level details</text>
    <text x="150" y="180" font-family="Courier New" font-size="14" fill="$($Theme.accent5)" text-anchor="middle">4 Rows -> 2 Rows</text>

    <!-- WINDOW -->
    <rect x="320" y="60" width="260" height="160" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="450" y="90" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">WINDOW FUNCTION</text>
    <text x="450" y="120" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Adds a calculation column</text>
    <text x="450" y="150" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Keeps original row details</text>
    <text x="450" y="180" font-family="Courier New" font-size="14" fill="$($Theme.accent1)" text-anchor="middle">4 Rows -> 4 Rows</text>
</svg>
"@

$svg_rank_vs_dense_rank = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">Ranking Functions (Handling Ties)</text>
    
    <text x="50" y="60" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="start">Data: 100, 100, 80</text>
    
    <!-- ROW_NUMBER -->
    <rect x="30" y="80" width="160" height="140" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="110" y="105" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">ROW_NUMBER()</text>
    <text x="110" y="130" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">100 -> 1</text>
    <text x="110" y="150" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">100 -> 2</text>
    <text x="110" y="170" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle"> 80 -> 3</text>
    <text x="110" y="200" font-family="Arial" font-size="10" fill="$($Theme.accent5)" text-anchor="middle">No Ties, Unique</text>

    <!-- RANK -->
    <rect x="220" y="80" width="160" height="140" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="300" y="105" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">RANK()</text>
    <text x="300" y="130" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">100 -> 1</text>
    <text x="300" y="150" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">100 -> 1</text>
    <text x="300" y="170" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle"> 80 -> 3</text>
    <text x="300" y="200" font-family="Arial" font-size="10" fill="$($Theme.accent5)" text-anchor="middle">Ties allowed, Skips 2</text>

    <!-- DENSE_RANK -->
    <rect x="410" y="80" width="160" height="140" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="490" y="105" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">DENSE_RANK()</text>
    <text x="490" y="130" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">100 -> 1</text>
    <text x="490" y="150" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">100 -> 1</text>
    <text x="490" y="170" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle"> 80 -> 2</text>
    <text x="490" y="200" font-family="Arial" font-size="10" fill="$($Theme.accent5)" text-anchor="middle">Ties allowed, NO Gaps</text>
</svg>
"@


Write-Svg "svg_aggregation_overview.svg" $svg_aggregation_overview
Write-Svg "svg_window_vs_groupby.svg" $svg_window_vs_groupby
Write-Svg "svg_rank_vs_dense_rank.svg" $svg_rank_vs_dense_rank
