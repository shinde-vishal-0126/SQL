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

$svg_datename = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">DATENAME() / DAYNAME()</text>
    
    <rect x="220" y="70" width="160" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="300" y="95" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">2025-08-20</text>
    
    <!-- WEEKDAY -->
    <path d="M 300 70 L 300 130" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <rect x="250" y="130" width="100" height="30" rx="5" fill="$($Theme.accent1)" opacity="0.2" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="300" y="150" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">DAYNAME()</text>
    <text x="300" y="185" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">"Wednesday"</text>
    
    <!-- MONTHNAME -->
    <path d="M 380 90 L 450 130" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <rect x="400" y="130" width="100" height="30" rx="5" fill="$($Theme.accent2)" opacity="0.2" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="450" y="150" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">MONTHNAME()</text>
    <text x="450" y="185" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">"August"</text>

    <!-- Def -->
    <defs>
        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
    </defs>
</svg>
"@

$svg_eomonth = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200">
    <rect width="600" height="200" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">EOMONTH() / LAST_DAY()</text>
    
    <text x="150" y="90" font-family="Courier New" font-size="20" fill="$($Theme.textPrimary)" text-anchor="middle">2025-08-15</text>
    <path d="M 230 85 L 370 85" fill="none" stroke="$($Theme.accent4)" stroke-width="3" marker-end="url(#arrow)"/>
    <text x="300" y="75" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">LAST_DAY()</text>
    
    <text x="450" y="90" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">2025-08-31</text>
    
    <text x="300" y="140" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">Returns the last valid date of the given month.</text>

    <!-- Def -->
    <defs>
        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent4)" />
        </marker>
    </defs>
</svg>
"@

$svg_cast_convert = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">CAST() &amp; CONVERT()</text>
    <text x="300" y="65" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">Changing the data type from one to another</text>
    
    <!-- String to Int -->
    <text x="120" y="110" font-family="Courier New" font-size="16" fill="$($Theme.accent4)" text-anchor="middle">String</text>
    <text x="200" y="110" font-family="Courier New" font-size="18" fill="$($Theme.textPrimary)" text-anchor="middle">'123'</text>
    
    <path d="M 250 105 L 350 105" fill="none" stroke="$($Theme.accent5)" stroke-width="4" marker-end="url(#arrow_red)"/>
    
    <text x="400" y="110" font-family="Courier New" font-size="18" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">123</text>
    <text x="480" y="110" font-family="Courier New" font-size="16" fill="$($Theme.accent2)" text-anchor="middle">Number</text>

    <!-- Date to String -->
    <text x="120" y="160" font-family="Courier New" font-size="16" fill="$($Theme.accent2)" text-anchor="middle">Date</text>
    <text x="200" y="160" font-family="Courier New" font-size="18" fill="$($Theme.textPrimary)" text-anchor="middle">2025-08-20</text>
    
    <path d="M 250 155 L 350 155" fill="none" stroke="$($Theme.accent5)" stroke-width="4" marker-end="url(#arrow_red)"/>
    
    <text x="420" y="160" font-family="Courier New" font-size="18" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">'2025-08-20'</text>
    <text x="520" y="160" font-family="Courier New" font-size="16" fill="$($Theme.accent4)" text-anchor="middle">String</text>
    
    <text x="300" y="220" font-family="Courier New" font-size="16" fill="$($Theme.accent1)" text-anchor="middle">CAST(value AS target_type)</text>

    <!-- Def -->
    <defs>
        <marker id="arrow_red" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent5)" />
        </marker>
    </defs>
</svg>
"@

Write-Svg "svg_datename.svg" $svg_datename
Write-Svg "svg_eomonth.svg" $svg_eomonth
Write-Svg "svg_cast_convert.svg" $svg_cast_convert
