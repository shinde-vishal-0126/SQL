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

$svg_join_vs_set = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 400">
    <rect width="800" height="400" fill="$($Theme.bg)" rx="10"/>
    <text x="400" y="40" font-family="Arial, sans-serif" font-size="24" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">JOINs vs SET Operators</text>
    
    <!-- JOIN SIDE (Left) -->
    <rect x="50" y="70" width="300" height="300" rx="10" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="200" y="100" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">JOIN (Horizontal Merging)</text>
    <text x="200" y="125" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Combines Columns side-by-side</text>
    
    <!-- Table A -->
    <rect x="90" y="150" width="60" height="80" fill="$($Theme.bg)" stroke="$($Theme.border)" stroke-width="2"/>
    <rect x="90" y="150" width="60" height="20" fill="$($Theme.accent1)" opacity="0.3"/>
    
    <!-- Table B -->
    <rect x="170" y="150" width="60" height="80" fill="$($Theme.bg)" stroke="$($Theme.border)" stroke-width="2"/>
    <rect x="170" y="150" width="60" height="20" fill="$($Theme.accent2)" opacity="0.3"/>
    
    <!-- Plus and Equals -->
    <text x="160" y="195" font-family="Arial" font-size="20" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">+</text>
    <text x="250" y="195" font-family="Arial" font-size="20" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">=</text>
    
    <!-- Result JOIN -->
    <rect x="270" y="150" width="60" height="80" fill="$($Theme.bg)" stroke="$($Theme.border)" stroke-width="2"/>
    <rect x="270" y="150" width="30" height="80" fill="$($Theme.accent1)" opacity="0.3"/>
    <rect x="300" y="150" width="30" height="80" fill="$($Theme.accent2)" opacity="0.3"/>
    
    <text x="200" y="270" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Requires PK/FK Relationship</text>
    <text x="200" y="295" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Table becomes WIDER</text>

    <!-- SET SIDE (Right) -->
    <rect x="450" y="70" width="300" height="300" rx="10" fill="$($Theme.boxBg)" stroke="$($Theme.accent3)" stroke-width="2"/>
    <text x="600" y="100" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">SET (Vertical Stacking)</text>
    <text x="600" y="125" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Combines Rows top-to-bottom</text>

    <!-- Query A -->
    <rect x="490" y="150" width="80" height="40" fill="$($Theme.bg)" stroke="$($Theme.border)" stroke-width="2"/>
    <rect x="490" y="150" width="80" height="15" fill="$($Theme.accent3)" opacity="0.3"/>
    
    <!-- Query B -->
    <rect x="490" y="210" width="80" height="40" fill="$($Theme.bg)" stroke="$($Theme.border)" stroke-width="2"/>
    <rect x="490" y="210" width="80" height="15" fill="$($Theme.accent4)" opacity="0.3"/>
    
    <!-- Plus and Equals -->
    <text x="530" y="205" font-family="Arial" font-size="20" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">+</text>
    <text x="600" y="195" font-family="Arial" font-size="20" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">=</text>
    
    <!-- Result SET -->
    <rect x="630" y="150" width="80" height="80" fill="$($Theme.bg)" stroke="$($Theme.border)" stroke-width="2"/>
    <rect x="630" y="150" width="80" height="40" fill="$($Theme.accent3)" opacity="0.3"/>
    <rect x="630" y="190" width="80" height="40" fill="$($Theme.accent4)" opacity="0.3"/>

    <text x="600" y="270" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">NO Relationship Required</text>
    <text x="600" y="295" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Table becomes LONGER</text>
</svg>
"@

Write-Svg "svg_join_vs_set.svg" $svg_join_vs_set
