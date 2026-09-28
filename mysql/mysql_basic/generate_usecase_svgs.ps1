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

$svg_delta_detection = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 300">
    <rect width="800" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="400" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">EXCEPT Use Case: Delta Detection (Changes)</text>
    
    <!-- Source System Day 1 -->
    <rect x="50" y="70" width="200" height="60" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="150" y="95" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Source System (Day 1)</text>
    <text x="150" y="115" font-family="Courier New, monospace" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">2 Rows</text>
    
    <!-- Source System Day 2 -->
    <rect x="50" y="180" width="200" height="60" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="150" y="205" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Source System (Day 2)</text>
    <text x="150" y="225" font-family="Courier New, monospace" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">3 Rows (1 New Row Added)</text>
    
    <!-- Arrow to EXCEPT -->
    <path d="M 250 210 L 330 210 L 330 160 L 370 160" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    <path d="M 250 100 L 330 100 L 330 150 L 370 150" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    
    <!-- EXCEPT Bubble -->
    <rect x="370" y="135" width="100" height="40" rx="20" fill="$($Theme.accent5)" opacity="0.2"/>
    <rect x="370" y="135" width="100" height="40" rx="20" fill="none" stroke="$($Theme.accent5)" stroke-width="2"/>
    <text x="420" y="160" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">EXCEPT</text>
    <text x="420" y="195" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">(Day 2 - Day 1)</text>
    
    <!-- Arrow to Delta -->
    <path d="M 470 155 L 530 155" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    
    <!-- Delta Result (Data Warehouse) -->
    <rect x="530" y="110" width="220" height="90" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent3)" stroke-width="2"/>
    <text x="640" y="140" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">The "Delta" (Changes)</text>
    <text x="640" y="160" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">Only 1 New Row is Returned</text>
    <text x="640" y="180" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">Insert into Data Warehouse</text>

    <!-- Def -->
    <defs>
        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
    </defs>
</svg>
"@

$svg_data_completeness = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 300">
    <rect width="800" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="400" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">EXCEPT Use Case: Data Completeness Check</text>
    
    <!-- DB A -->
    <path d="M 100 80 C 100 70, 200 70, 200 80 L 200 130 C 200 140, 100 140, 100 130 Z" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <path d="M 100 80 C 100 90, 200 90, 200 80" fill="none" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="150" y="115" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Database A</text>
    
    <!-- DB B -->
    <path d="M 100 180 C 100 170, 200 170, 200 180 L 200 230 C 200 240, 100 240, 100 230 Z" fill="$($Theme.boxBg)" stroke="$($Theme.accent3)" stroke-width="2"/>
    <path d="M 100 180 C 100 190, 200 190, 200 180" fill="none" stroke="$($Theme.accent3)" stroke-width="2"/>
    <text x="150" y="215" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Database B</text>
    
    <!-- Arrows to EXCEPT -->
    <path d="M 210 105 L 270 105 L 270 150 L 310 150" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    <path d="M 210 205 L 270 205 L 270 160 L 310 160" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    
    <!-- EXCEPT Bubble -->
    <rect x="310" y="135" width="100" height="40" rx="20" fill="$($Theme.accent5)" opacity="0.2"/>
    <rect x="310" y="135" width="100" height="40" rx="20" fill="none" stroke="$($Theme.accent5)" stroke-width="2"/>
    <text x="360" y="160" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">EXCEPT</text>
    <text x="360" y="195" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">(DB A - DB B)</text>
    
    <!-- Arrow to Result -->
    <path d="M 410 155 L 470 155" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    
    <!-- Completeness Result -->
    <rect x="470" y="125" width="160" height="60" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="550" y="150" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">Empty Result</text>
    <text x="550" y="170" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">(100% In Sync)</text>
    
    <text x="550" y="210" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">If DB B is missing data,</text>
    <text x="550" y="225" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">EXCEPT will show exactly</text>
    <text x="550" y="240" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">which rows are missing!</text>

    <!-- Def -->
    <defs>
        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
    </defs>
</svg>
"@

Write-Svg "svg_delta_detection.svg" $svg_delta_detection
Write-Svg "svg_data_completeness.svg" $svg_data_completeness
