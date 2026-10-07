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

$svg_running_vs_rolling = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 300">
    <rect width="600" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">RUNNING TOTAL vs ROLLING TOTAL</text>
    <text x="300" y="50" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">ANALYSIS OVER TIME (Tracking sequences)</text>
    
    <!-- Running Total -->
    <rect x="20" y="80" width="270" height="180" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <rect x="20" y="80" width="270" height="30" fill="$($Theme.accent1)"/>
    <text x="155" y="100" font-family="Arial" font-size="16" font-weight="bold" fill="#000000" text-anchor="middle">RUNNING TOTAL</text>
    
    <text x="30" y="130" font-family="Arial" font-size="13" fill="$($Theme.textPrimary)">• From beginning to current point</text>
    <text x="30" y="150" font-family="Arial" font-size="13" fill="$($Theme.textPrimary)">• Without dropping older data</text>
    
    <rect x="30" y="170" width="250" height="40" fill="$($Theme.bg)" stroke="$($Theme.border)"/>
    <text x="155" y="185" font-family="Courier New" font-size="12" fill="$($Theme.accent1)" text-anchor="middle">ORDER BY Month</text>
    <text x="155" y="200" font-family="Courier New" font-size="10" fill="$($Theme.textSecondary)" text-anchor="middle">(UNBOUNDED PRECEDING TO CURRENT)</text>

    <!-- Rolling Total -->
    <rect x="310" y="80" width="270" height="180" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <rect x="310" y="80" width="270" height="30" fill="$($Theme.accent2)"/>
    <text x="445" y="100" font-family="Arial" font-size="16" font-weight="bold" fill="#000000" text-anchor="middle">ROLLING TOTAL</text>
    
    <text x="320" y="130" font-family="Arial" font-size="13" fill="$($Theme.textPrimary)">• Within a fixed time window</text>
    <text x="320" y="150" font-family="Arial" font-size="13" fill="$($Theme.textPrimary)">• Oldest data point is dropped</text>
    
    <rect x="320" y="170" width="250" height="40" fill="$($Theme.bg)" stroke="$($Theme.border)"/>
    <text x="445" y="185" font-family="Courier New" font-size="12" fill="$($Theme.accent2)" text-anchor="middle">ORDER BY Month</text>
    <text x="445" y="200" font-family="Courier New" font-size="11" fill="$($Theme.textSecondary)" text-anchor="middle">ROWS 2 PRECEDING</text>
</svg>
"@

$svg_value_functions = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 350">
    <rect width="600" height="350" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">VALUE FUNCTIONS (Analytics)</text>
    <text x="300" y="50" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Access a value from other Row without JOINs</text>
    
    <!-- Rows -->
    <rect x="50" y="90" width="50" height="40" fill="$($Theme.boxBg)" stroke="$($Theme.border)"/>
    <text x="75" y="115" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">20</text>
    <text x="75" y="85" font-family="Arial" font-size="12" fill="$($Theme.accent1)" text-anchor="middle">FIRST</text>

    <rect x="150" y="90" width="50" height="40" fill="$($Theme.boxBg)" stroke="$($Theme.border)"/>
    <text x="175" y="115" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">10</text>
    <text x="175" y="85" font-family="Arial" font-size="12" fill="$($Theme.accent3)" text-anchor="middle">LAG (Prev)</text>

    <rect x="250" y="90" width="80" height="40" fill="$($Theme.accent2)" stroke="$($Theme.border)"/>
    <text x="290" y="115" font-family="Courier New" font-size="16" font-weight="bold" fill="#000000" text-anchor="middle">30</text>
    <text x="290" y="85" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">CURRENT</text>

    <rect x="380" y="90" width="50" height="40" fill="$($Theme.boxBg)" stroke="$($Theme.border)"/>
    <text x="405" y="115" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">5</text>
    <text x="405" y="85" font-family="Arial" font-size="12" fill="$($Theme.accent3)" text-anchor="middle">LEAD (Next)</text>

    <rect x="480" y="90" width="50" height="40" fill="$($Theme.boxBg)" stroke="$($Theme.border)"/>
    <text x="505" y="115" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">40</text>
    <text x="505" y="85" font-family="Arial" font-size="12" fill="$($Theme.accent1)" text-anchor="middle">LAST</text>

    <!-- Arrows -->
    <!-- LAG -->
    <path d="M 250 110 Q 212 110 200 110" fill="none" stroke="$($Theme.accent3)" stroke-width="2" marker-end="url(#arrow_purple)"/>
    <!-- LEAD -->
    <path d="M 330 110 Q 355 110 380 110" fill="none" stroke="$($Theme.accent3)" stroke-width="2" marker-end="url(#arrow_purple)"/>
    <!-- FIRST -->
    <path d="M 270 90 Q 170 30 75 90" fill="none" stroke="$($Theme.accent1)" stroke-width="2" marker-end="url(#arrow_blue)"/>
    <!-- LAST -->
    <path d="M 310 90 Q 400 30 505 90" fill="none" stroke="$($Theme.accent1)" stroke-width="2" marker-end="url(#arrow_blue)"/>

    <!-- Syntax Rules -->
    <rect x="50" y="170" width="500" height="150" fill="$($Theme.boxBg)" stroke="$($Theme.border)"/>
    <text x="300" y="190" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Syntax Rules for Value Functions</text>
    
    <text x="80" y="220" font-family="Courier New" font-size="14" fill="$($Theme.accent3)">LEAD / LAG :</text>
    <text x="250" y="220" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">FRAME is NOT allowed</text>

    <text x="80" y="250" font-family="Courier New" font-size="14" fill="$($Theme.accent1)">FIRST_VALUE :</text>
    <text x="250" y="250" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">FRAME is Optional</text>

    <text x="80" y="280" font-family="Courier New" font-size="14" fill="$($Theme.accent1)">LAST_VALUE :</text>
    <text x="250" y="280" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)">FRAME Should be used (Default stops at current)</text>

    <text x="300" y="310" font-family="Arial" font-size="14" font-style="italic" fill="$($Theme.accent5)" text-anchor="middle">Note: ORDER BY is REQUIRED for all Value Functions</text>

    <defs>
        <marker id="arrow_purple" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent3)" />
        </marker>
        <marker id="arrow_blue" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent1)" />
        </marker>
    </defs>
</svg>
"@

Write-Svg "svg_running_vs_rolling.svg" $svg_running_vs_rolling
Write-Svg "svg_value_functions.svg" $svg_value_functions
