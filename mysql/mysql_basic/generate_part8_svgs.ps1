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

$svg_window_syntax = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Window Rank Functions | Syntax</text>
    
    <text x="300" y="80" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">RANK() OVER (PARTITION BY col1 ORDER BY col2)</text>
    
    <!-- Arrows and Labels -->
    <path d="M 180 95 L 180 120" fill="none" stroke="$($Theme.accent5)" stroke-width="2" marker-end="url(#arrow_red)"/>
    <text x="180" y="140" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Expression</text>
    <text x="180" y="160" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">must be empty</text>

    <path d="M 330 95 L 330 120" fill="none" stroke="$($Theme.accent1)" stroke-width="2" marker-end="url(#arrow_blue)"/>
    <text x="330" y="140" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Partition By</text>
    <text x="330" y="160" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">is Optional</text>

    <path d="M 470 95 L 470 120" fill="none" stroke="$($Theme.accent4)" stroke-width="2" marker-end="url(#arrow_yellow)"/>
    <text x="470" y="140" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Order By</text>
    <text x="470" y="160" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">is Required</text>

    <defs>
        <marker id="arrow_red" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent5)" />
        </marker>
        <marker id="arrow_blue" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent1)" />
        </marker>
        <marker id="arrow_yellow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent4)" />
        </marker>
    </defs>
</svg>
"@

$svg_percentage_vs_integer = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Integer-based vs Percentage-based Ranking</text>
    
    <!-- Integer Based -->
    <rect x="50" y="60" width="220" height="160" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="160" y="90" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Integer-Based Ranking</text>
    <text x="160" y="110" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">(ROW_NUMBER, RANK)</text>
    <text x="160" y="140" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">1, 2, 3, 4, 5</text>
    <text x="160" y="180" font-family="Arial" font-size="12" fill="$($Theme.accent1)" text-anchor="middle">Discrete Values</text>
    <text x="160" y="200" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">Top / Bottom N Analysis</text>

    <!-- Percentage Based -->
    <rect x="330" y="60" width="220" height="160" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="440" y="90" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">Percentage-Based Ranking</text>
    <text x="440" y="110" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">(PERCENT_RANK, CUME_DIST)</text>
    <text x="440" y="140" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">0, 0.25, 0.5, 0.75, 1</text>
    <text x="440" y="180" font-family="Arial" font-size="12" fill="$($Theme.accent1)" text-anchor="middle">Continuous Values (0 to 1)</text>
    <text x="440" y="200" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">Distribution Analysis</text>
</svg>
"@

Write-Svg "svg_window_syntax.svg" $svg_window_syntax
Write-Svg "svg_percentage_vs_integer.svg" $svg_percentage_vs_integer
