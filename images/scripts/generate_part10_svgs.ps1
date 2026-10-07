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

$svg_cumedist_vs_percentrank_table = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 300">
    <rect width="600" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">CUME_DIST vs PERCENT_RANK</text>
    
    <!-- Table Headers -->
    <rect x="50" y="50" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="90" y="70" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Sales</text>

    <rect x="140" y="50" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="180" y="70" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">DIST</text>

    <rect x="230" y="50" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="270" y="70" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">PER</text>

    <!-- Row 1 (100) -->
    <rect x="50" y="90" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.border)"/>
    <text x="90" y="110" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">100</text>
    <rect x="140" y="90" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)"/>
    <text x="180" y="110" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">0.2</text>
    <rect x="230" y="90" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)"/>
    <text x="270" y="110" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">0</text>

    <!-- Row 2 (80 - Tie) -->
    <rect x="50" y="130" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent5)"/>
    <text x="90" y="150" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">80</text>
    <rect x="140" y="130" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)"/>
    <text x="180" y="150" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">0.6</text>
    <rect x="230" y="130" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)"/>
    <text x="270" y="150" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">0.25</text>

    <!-- Row 3 (80 - Tie) -->
    <rect x="50" y="170" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent5)"/>
    <text x="90" y="190" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">80</text>
    <rect x="140" y="170" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)"/>
    <text x="180" y="190" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">0.6</text>
    <rect x="230" y="170" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)"/>
    <text x="270" y="190" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">0.25</text>

    <!-- Row 4 (50) -->
    <rect x="50" y="210" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.border)"/>
    <text x="90" y="230" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">50</text>
    <rect x="140" y="210" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)"/>
    <text x="180" y="230" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">0.8</text>
    <rect x="230" y="210" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)"/>
    <text x="270" y="230" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">0.75</text>

    <!-- Row 5 (30) -->
    <rect x="50" y="250" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.border)"/>
    <text x="90" y="270" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">30</text>
    <rect x="140" y="250" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)"/>
    <text x="180" y="270" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">1</text>
    <rect x="230" y="250" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)"/>
    <text x="270" y="270" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">1</text>

    <!-- Tie Rule Text -->
    <text x="450" y="100" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">CUME_DIST (Inclusive)</text>
    <text x="450" y="120" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Current row is included</text>
    
    <text x="450" y="180" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">PERCENT_RANK (Exclusive)</text>
    <text x="450" y="200" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Current row is excluded</text>

    <path d="M 320 150 L 350 150" fill="none" stroke="$($Theme.accent5)" stroke-width="2" marker-end="url(#arrow_red)"/>
    <text x="450" y="155" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">TIES share same percentage</text>
    <text x="450" y="250" font-family="Arial" font-size="11" fill="$($Theme.textPrimary)" text-anchor="middle">Both measure contribution to overall distribution</text>

    <defs>
        <marker id="arrow_red" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent5)" />
        </marker>
    </defs>
</svg>
"@

Write-Svg "svg_cumedist_vs_percentrank_table.svg" $svg_cumedist_vs_percentrank_table
