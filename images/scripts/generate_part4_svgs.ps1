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

$svg_anti_join_recap = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 300">
    <rect width="600" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial, sans-serif" font-size="18" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">Joins &amp; Anti-Joins Recap</text>
    
    <!-- Left Join -->
    <text x="150" y="80" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">LEFT JOIN</text>
    <circle cx="130" cy="120" r="30" fill="$($Theme.accent1)" opacity="0.6"/>
    <circle cx="170" cy="120" r="30" fill="none" stroke="$($Theme.border)" stroke-width="2"/>
    <path d="M 150 97 A 30 30 0 0 1 150 143 A 30 30 0 0 1 150 97" fill="$($Theme.accent1)" opacity="0.6"/>
    <text x="150" y="170" font-family="Arial" font-size="10" fill="$($Theme.textSecondary)" text-anchor="middle">All Left + Intersect</text>

    <!-- Left Anti Join -->
    <text x="450" y="80" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">LEFT ANTI JOIN</text>
    <circle cx="430" cy="120" r="30" fill="$($Theme.accent1)" opacity="0.6"/>
    <circle cx="470" cy="120" r="30" fill="none" stroke="$($Theme.border)" stroke-width="2"/>
    <path d="M 450 97 A 30 30 0 0 1 450 143 A 30 30 0 0 1 450 97" fill="$($Theme.bg)"/>
    <text x="450" y="170" font-family="Arial" font-size="10" fill="$($Theme.textSecondary)" text-anchor="middle">Left Join + IS NULL</text>
    <text x="450" y="185" font-family="Arial" font-size="10" fill="$($Theme.textSecondary)" text-anchor="middle">(Unmatching Rows Only)</text>

    <!-- Right Join -->
    <text x="150" y="220" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">RIGHT JOIN</text>
    <circle cx="130" cy="260" r="30" fill="none" stroke="$($Theme.border)" stroke-width="2"/>
    <circle cx="170" cy="260" r="30" fill="$($Theme.accent2)" opacity="0.6"/>
    <path d="M 150 237 A 30 30 0 0 1 150 283 A 30 30 0 0 1 150 237" fill="$($Theme.accent2)" opacity="0.6"/>

    <!-- Right Anti Join -->
    <text x="450" y="220" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">RIGHT ANTI JOIN</text>
    <circle cx="430" cy="260" r="30" fill="none" stroke="$($Theme.border)" stroke-width="2"/>
    <circle cx="470" cy="260" r="30" fill="$($Theme.accent2)" opacity="0.6"/>
    <path d="M 450 237 A 30 30 0 0 1 450 283 A 30 30 0 0 1 450 237" fill="$($Theme.bg)"/>
</svg>
"@

$svg_nullif_flowchart = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200">
    <rect width="600" height="200" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Courier New" font-size="18" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">NULLIF(Value1, Value2)</text>
    
    <polygon points="300,60 360,90 300,120 240,90" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="300" y="95" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">Are they equal?</text>

    <!-- YES -->
    <path d="M 360 90 L 450 90 L 450 140" fill="none" stroke="$($Theme.accent2)" stroke-width="2" marker-end="url(#arrow_green)"/>
    <text x="405" y="80" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">Yes</text>
    <rect x="420" y="140" width="60" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent5)" stroke-width="2"/>
    <text x="450" y="160" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">NULL</text>

    <!-- NO -->
    <path d="M 240 90 L 150 90 L 150 140" fill="none" stroke="$($Theme.accent5)" stroke-width="2" marker-end="url(#arrow_red)"/>
    <text x="195" y="80" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">No</text>
    <rect x="120" y="140" width="60" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="150" y="160" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Value1</text>

    <defs>
        <marker id="arrow_green" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent2)" />
        </marker>
        <marker id="arrow_red" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent5)" />
        </marker>
    </defs>
</svg>
"@

$svg_null_vs_empty = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial, sans-serif" font-size="18" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">NULL vs Empty String vs Blank Space</text>
    
    <!-- Headers -->
    <text x="150" y="70" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">NULL</text>
    <text x="300" y="70" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">'' (Empty)</text>
    <text x="450" y="70" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">' ' (Space)</text>

    <!-- Meaning -->
    <text x="150" y="110" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Unknown</text>
    <text x="300" y="110" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Known (Empty)</text>
    <text x="450" y="110" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Known (Space)</text>

    <!-- DataType -->
    <text x="150" y="140" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">Special Marker</text>
    <text x="300" y="140" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">String (0)</text>
    <text x="450" y="140" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">String (1+)</text>

    <!-- Storage / Perf -->
    <text x="150" y="170" font-family="Arial" font-size="14" fill="$($Theme.accent2)" text-anchor="middle">Minimal / Best</text>
    <text x="300" y="170" font-family="Arial" font-size="14" fill="$($Theme.accent4)" text-anchor="middle">Occupies Mem / Fast</text>
    <text x="450" y="170" font-family="Arial" font-size="14" fill="$($Theme.accent5)" text-anchor="middle">Occupies Mem / Slow</text>

    <!-- Comparison -->
    <text x="150" y="200" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">IS NULL</text>
    <text x="300" y="200" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">=''</text>
    <text x="450" y="200" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">=' '</text>

    <!-- Grid lines -->
    <path d="M 225 50 L 225 210" fill="none" stroke="$($Theme.border)" stroke-width="1"/>
    <path d="M 375 50 L 375 210" fill="none" stroke="$($Theme.border)" stroke-width="1"/>
</svg>
"@

$svg_null_usecases = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200">
    <rect width="600" height="200" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial, sans-serif" font-size="18" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">NULL Functions Use Cases</text>
    
    <rect x="50" y="50" width="500" height="130" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    
    <text x="70" y="75" font-family="Courier New" font-size="14" fill="$($Theme.accent1)" text-anchor="start">1. Data Aggregation (SUM, AVG)</text>
    <text x="70" y="95" font-family="Courier New" font-size="14" fill="$($Theme.accent2)" text-anchor="start">2. Mathematical Operations</text>
    <text x="70" y="115" font-family="Courier New" font-size="14" fill="$($Theme.accent3)" text-anchor="start">3. Joining Tables</text>
    <text x="70" y="135" font-family="Courier New" font-size="14" fill="$($Theme.accent4)" text-anchor="start">4. Sorting Data (NULLs first/last)</text>
    <text x="70" y="155" font-family="Courier New" font-size="14" fill="$($Theme.accent5)" text-anchor="start">5. Finding Unmatched Data (Anti-Joins)</text>
</svg>
"@

Write-Svg "svg_anti_join_recap.svg" $svg_anti_join_recap
Write-Svg "svg_nullif_flowchart.svg" $svg_nullif_flowchart
Write-Svg "svg_null_vs_empty.svg" $svg_null_vs_empty
Write-Svg "svg_null_usecases.svg" $svg_null_usecases
