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

$svg_percent_formulas = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200">
    <rect width="600" height="200" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Percentage-Based Rank Formulas</text>
    
    <!-- CUME_DIST -->
    <rect x="50" y="60" width="220" height="100" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <rect x="110" y="50" width="100" height="20" fill="$($Theme.accent1)"/>
    <text x="160" y="64" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.bg)" text-anchor="middle">CUME_DIST</text>
    
    <text x="160" y="100" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">Position Nr</text>
    <path d="M 90 115 L 230 115" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="160" y="140" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">Number of Rows</text>

    <!-- PERCENT_RANK -->
    <rect x="330" y="60" width="220" height="100" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <rect x="380" y="50" width="120" height="20" fill="$($Theme.accent2)"/>
    <text x="440" y="64" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.bg)" text-anchor="middle">PERCENT_RANK</text>
    
    <text x="440" y="100" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">Position Nr - 1</text>
    <path d="M 370 115 L 510 115" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="440" y="140" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">Number of Rows - 1</text>

</svg>
"@

Write-Svg "svg_percent_formulas.svg" $svg_percent_formulas
