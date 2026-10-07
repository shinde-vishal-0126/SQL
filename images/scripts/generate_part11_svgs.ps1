$TargetDir = "d:\IMP\SQL\images"

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

$svg_ntile = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 300">
    <rect width="600" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Courier New" font-size="22" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">NTILE(n)</text>
    <text x="300" y="60" font-family="Arial" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">Divides rows into a specified number of approximately equal groups</text>
    
    <text x="150" y="110" font-family="Courier New" font-size="16" fill="$($Theme.accent4)" text-anchor="middle">Bucket Size =</text>
    <text x="350" y="100" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Number of Rows</text>
    <path d="M 280 110 L 420 110" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="350" y="130" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Number of Buckets (n)</text>

    <!-- Example -->
    <text x="150" y="180" font-family="Courier New" font-size="16" fill="$($Theme.textSecondary)" text-anchor="middle">Example:</text>
    <text x="250" y="180" font-family="Courier New" font-size="16" fill="$($Theme.accent1)" text-anchor="middle">NTILE(2) -> 5 rows</text>
    
    <text x="400" y="170" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">5</text>
    <path d="M 380 180 L 420 180" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="400" y="200" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">2</text>
    <text x="450" y="185" font-family="Arial" font-size="14" fill="$($Theme.accent4)" text-anchor="middle">= 2.5</text>

    <text x="300" y="250" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">SQL RULE: Larger groups come first</text>
    <text x="300" y="270" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">(Group 1 gets 3 rows, Group 2 gets 2 rows)</text>
</svg>
"@

$svg_window_rank_summary = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 350">
    <rect width="600" height="350" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">WINDOW RANK FUNCTIONS SUMMARY</text>
    
    <!-- Types Box -->
    <rect x="50" y="60" width="230" height="120" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="165" y="80" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">Types</text>
    <text x="60" y="110" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">• Integer-based:</text>
    <text x="70" y="130" font-family="Courier New" font-size="12" fill="$($Theme.textSecondary)">ROW_NUMBER, RANK, DENSE_RANK, NTILE</text>
    <text x="60" y="150" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">• Percentage-based:</text>
    <text x="70" y="170" font-family="Courier New" font-size="12" fill="$($Theme.textSecondary)">PERCENT_RANK, CUME_DIST</text>

    <!-- Rules Box -->
    <rect x="50" y="200" width="230" height="120" fill="$($Theme.boxBg)" stroke="$($Theme.accent5)" stroke-width="2"/>
    <text x="165" y="220" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">Rules</text>
    <text x="60" y="250" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">• Expression -> Empty</text>
    <text x="60" y="275" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">• ORDER BY -> Required</text>
    <text x="60" y="300" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">• FRAME -> Not Allowed</text>

    <!-- Use Cases Box -->
    <rect x="320" y="60" width="230" height="260" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="435" y="80" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">Use Cases</text>
    <text x="330" y="110" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">• Top-N / Bottom-N Analysis</text>
    <text x="330" y="140" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">• Identify &amp; Remove Duplicates</text>
    <text x="330" y="170" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">• Assign Unique ID (Pagination)</text>
    <text x="330" y="200" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">• Data Segmentation (NTILE)</text>
    <text x="330" y="230" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">• Distribution Analysis</text>
    <text x="330" y="260" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">• Equalizing Load Processing</text>

</svg>
"@

Write-Svg "svg_ntile.svg" $svg_ntile
Write-Svg "svg_window_rank_summary.svg" $svg_window_rank_summary
