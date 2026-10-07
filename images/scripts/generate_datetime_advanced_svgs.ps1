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

$svg_datediff_concept = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 220">
    <rect width="600" height="220" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">DATEDIFF() Concept</text>
    
    <text x="150" y="80" font-family="Courier New" font-size="16" fill="$($Theme.textSecondary)" text-anchor="middle">Order Date</text>
    <text x="150" y="100" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">2025-08-20</text>
    
    <text x="450" y="80" font-family="Courier New" font-size="16" fill="$($Theme.textSecondary)" text-anchor="middle">Shipping Date</text>
    <text x="450" y="100" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">2026-02-01</text>
    
    <rect x="250" y="75" width="100" height="30" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="300" y="95" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">DATEDIFF</text>
    
    <!-- Lines to results -->
    <path d="M 300 105 L 200 135" fill="none" stroke="$($Theme.border)" stroke-width="2"/>
    <path d="M 300 105 L 300 135" fill="none" stroke="$($Theme.border)" stroke-width="2"/>
    <path d="M 300 105 L 400 135" fill="none" stroke="$($Theme.border)" stroke-width="2"/>
    
    <circle cx="200" cy="150" r="25" fill="$($Theme.bg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="200" y="155" font-family="Arial" font-size="12" fill="$($Theme.accent2)" text-anchor="middle">YEAR</text>
    <rect x="180" y="180" width="40" height="25" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="1"/>
    <text x="200" y="197" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">0</text>

    <circle cx="300" cy="150" r="25" fill="$($Theme.bg)" stroke="$($Theme.accent3)" stroke-width="2"/>
    <text x="300" y="155" font-family="Arial" font-size="12" fill="$($Theme.accent3)" text-anchor="middle">MONTH</text>
    <rect x="280" y="180" width="40" height="25" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="1"/>
    <text x="300" y="197" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">5</text>

    <circle cx="400" cy="150" r="25" fill="$($Theme.bg)" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="400" y="155" font-family="Arial" font-size="12" fill="$($Theme.accent4)" text-anchor="middle">DAY</text>
    <rect x="380" y="180" width="40" height="25" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="1"/>
    <text x="400" y="197" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">165</text>
</svg>
"@

$svg_datetrunc_concept = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200">
    <rect width="600" height="200" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">DATETRUNC() / DATE_TRUNC()</text>
    
    <text x="300" y="80" font-family="Courier New" font-size="20" fill="$($Theme.textSecondary)" text-anchor="middle">2025-01-15 14:30:45</text>
    
    <!-- Truncating to YEAR -->
    <path d="M 300 90 L 300 110" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    
    <text x="150" y="120" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">Keep (Year)</text>
    <text x="450" y="120" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">Reset (Month, Day, Time)</text>
    
    <rect x="100" y="130" width="100" height="40" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="150" y="155" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">2025-</text>
    
    <rect x="200" y="130" width="300" height="40" fill="$($Theme.boxBg)" stroke="$($Theme.accent5)" stroke-width="2"/>
    <text x="350" y="155" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">01-01 00:00:00</text>
    
    <text x="300" y="190" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Truncates date to a specific part, resetting the rest to lowest value.</text>

    <!-- Def -->
    <defs>
        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
    </defs>
</svg>
"@

$svg_formatting_concept = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Formatting Concept (Value to String)</text>
    
    <!-- Date Format -->
    <text x="150" y="90" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">Internal Date</text>
    <text x="150" y="115" font-family="Courier New" font-size="18" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">2025-08-20</text>
    
    <path d="M 230 105 L 280 105" fill="none" stroke="$($Theme.accent4)" stroke-width="2" marker-end="url(#arrow_yellow)"/>
    <rect x="290" y="90" width="80" height="30" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="330" y="110" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">FORMAT()</text>
    <path d="M 380 105 L 430 105" fill="none" stroke="$($Theme.accent4)" stroke-width="2" marker-end="url(#arrow_yellow)"/>
    
    <text x="500" y="90" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">String Output</text>
    <text x="500" y="115" font-family="Courier New" font-size="16" fill="$($Theme.accent2)" text-anchor="middle">"August 20, 2025"</text>

    <!-- Number Format -->
    <text x="150" y="170" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">Internal Number</text>
    <text x="150" y="195" font-family="Courier New" font-size="18" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">1234567.89</text>
    
    <path d="M 230 185 L 280 185" fill="none" stroke="$($Theme.accent4)" stroke-width="2" marker-end="url(#arrow_yellow)"/>
    <rect x="290" y="170" width="80" height="30" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="330" y="190" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">FORMAT()</text>
    <path d="M 380 185 L 430 185" fill="none" stroke="$($Theme.accent4)" stroke-width="2" marker-end="url(#arrow_yellow)"/>
    
    <text x="500" y="170" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">String Output</text>
    <text x="500" y="195" font-family="Courier New" font-size="16" fill="$($Theme.accent2)" text-anchor="middle">"$1,234,567.89"</text>

    <defs>
        <marker id="arrow_yellow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent4)" />
        </marker>
    </defs>
</svg>
"@

Write-Svg "svg_datediff_concept.svg" $svg_datediff_concept
Write-Svg "svg_datetrunc_concept.svg" $svg_datetrunc_concept
Write-Svg "svg_formatting_concept.svg" $svg_formatting_concept
