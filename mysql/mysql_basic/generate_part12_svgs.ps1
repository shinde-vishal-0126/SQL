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

$svg_window_agg_usecases = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 250">
    <rect width="700" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="350" y="30" font-family="Arial" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Aggregate Window Functions | Use Cases</text>
    
    <!-- Use Case 1 -->
    <rect x="20" y="70" width="200" height="130" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <rect x="20" y="70" width="200" height="30" fill="$($Theme.border)"/>
    <text x="120" y="90" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">#1 OVERALL ANALYSIS</text>
    <text x="120" y="130" font-family="Arial" font-size="14" fill="$($Theme.accent1)" text-anchor="middle">Quick summary or</text>
    <text x="120" y="150" font-family="Arial" font-size="14" fill="$($Theme.accent1)" text-anchor="middle">snapshot of the</text>
    <text x="120" y="170" font-family="Arial" font-size="14" fill="$($Theme.accent1)" text-anchor="middle">entire dataset</text>

    <!-- Use Case 2 -->
    <rect x="250" y="70" width="200" height="130" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <rect x="250" y="70" width="200" height="30" fill="$($Theme.border)"/>
    <text x="350" y="90" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">#2 TOTAL PER GROUPS</text>
    <text x="350" y="130" font-family="Arial" font-size="14" fill="$($Theme.accent2)" text-anchor="middle">Group-wise analysis,</text>
    <text x="350" y="150" font-family="Arial" font-size="14" fill="$($Theme.accent2)" text-anchor="middle">to understand patterns</text>
    <text x="350" y="170" font-family="Arial" font-size="14" fill="$($Theme.accent2)" text-anchor="middle">within categories</text>

    <!-- Use Case 3 -->
    <rect x="480" y="70" width="200" height="130" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <rect x="480" y="70" width="200" height="30" fill="$($Theme.border)"/>
    <text x="580" y="90" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">#3 COMPARISON</text>
    <text x="580" y="130" font-family="Arial" font-size="14" fill="$($Theme.accent3)" text-anchor="middle">Compare the current</text>
    <text x="580" y="150" font-family="Arial" font-size="14" fill="$($Theme.accent3)" text-anchor="middle">value and aggregated</text>
    <text x="580" y="170" font-family="Arial" font-size="14" fill="$($Theme.accent3)" text-anchor="middle">value of windows</text>
    <text x="580" y="190" font-family="Arial" font-size="12" font-style="italic" fill="$($Theme.textSecondary)" text-anchor="middle">(e.g. % Contribution)</text>

</svg>
"@

Write-Svg "svg_window_agg_usecases.svg" $svg_window_agg_usecases
