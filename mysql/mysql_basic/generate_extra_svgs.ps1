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

$svg_union_all = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300">
    <rect width="500" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="250" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">UNION ALL (All Rows)</text>
    
    <circle cx="200" cy="160" r="80" fill="$($Theme.accent1)" opacity="0.4" stroke="$($Theme.accent1)" stroke-width="3"/>
    <circle cx="300" cy="160" r="80" fill="$($Theme.accent2)" opacity="0.4" stroke="$($Theme.accent2)" stroke-width="3"/>
    
    <!-- Representing duplicates with extra overlapping circles or lines -->
    <circle cx="200" cy="160" r="70" fill="none" stroke="$($Theme.textPrimary)" stroke-width="1" stroke-dasharray="4,4"/>
    <circle cx="300" cy="160" r="70" fill="none" stroke="$($Theme.textPrimary)" stroke-width="1" stroke-dasharray="4,4"/>
    
    <text x="160" y="165" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)">Table A</text>
    <text x="340" y="165" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)">Table B</text>
    
    <!-- Text for duplicates -->
    <rect x="180" y="100" width="140" height="30" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="250" y="120" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">KEEPS DUPLICATES</text>
    
    <text x="250" y="270" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">Combines everything as-is. Faster because no filtering.</text>
</svg>
"@

$svg_combine_similar = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 300">
    <rect width="800" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="400" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Combine Similar Information Before Analysis (UNION)</text>
    
    <!-- 4 Source Tables -->
    <rect x="50" y="70" width="120" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="110" y="95" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Orders 2021</text>
    
    <rect x="50" y="120" width="120" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="110" y="145" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Orders 2022</text>
    
    <rect x="50" y="170" width="120" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="110" y="195" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Orders 2023</text>
    
    <rect x="50" y="220" width="120" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="110" y="245" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Orders 2024</text>
    
    <!-- Arrows to UNION -->
    <path d="M 170 90 L 250 145" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <path d="M 170 140 L 250 155" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <path d="M 170 190 L 250 165" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <path d="M 170 240 L 250 175" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    
    <!-- UNION Bubble -->
    <circle cx="280" cy="160" r="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent3)" stroke-width="3"/>
    <text x="280" y="165" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">UNION</text>
    
    <!-- Arrow to Combined Table -->
    <path d="M 310 160 L 370 160" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    
    <!-- Combined Table -->
    <rect x="370" y="120" width="160" height="80" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="450" y="145" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">All_Orders</text>
    <text x="450" y="165" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">(Single Master Table)</text>
    
    <!-- Arrow to Query -->
    <path d="M 530 160 L 580 160" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    
    <!-- Final SQL Query/Analysis -->
    <rect x="580" y="120" width="160" height="80" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="660" y="150" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Data Analysis</text>
    <text x="660" y="170" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">(PowerBI / Reports)</text>

    <!-- Def -->
    <defs>
        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
    </defs>
</svg>
"@

Write-Svg "svg_union_all.svg" $svg_union_all
Write-Svg "svg_combine_similar.svg" $svg_combine_similar
