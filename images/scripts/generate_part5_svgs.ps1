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

$svg_locate = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 150">
    <rect width="600" height="150" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">LOCATE() / CHARINDEX()</text>
    
    <text x="300" y="60" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Finds the starting position of a substring.</text>

    <!-- Example -->
    <rect x="50" y="80" width="500" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="70" y="105" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="start">LOCATE('@', 'vishal@gmail.com')</text>
    <path d="M 370 100 L 410 100" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow_gray)"/>
    <text x="430" y="105" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.accent2)" text-anchor="start">7</text>

    <defs>
        <marker id="arrow_gray" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
    </defs>
</svg>
"@

$svg_mod_even_odd = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200">
    <rect width="600" height="200" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">MOD(x, y) - Find Remainders</text>
    <text x="300" y="55" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">Interview Favorite: Finding Even / Odd rows</text>
    
    <!-- Even -->
    <rect x="100" y="80" width="180" height="80" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="190" y="105" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">EVEN Numbers</text>
    <text x="190" y="140" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">MOD(id, 2) = 0</text>

    <!-- Odd -->
    <rect x="320" y="80" width="180" height="80" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="410" y="105" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">ODD Numbers</text>
    <text x="410" y="140" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">MOD(id, 2) = 1</text>
</svg>
"@

$svg_if_function = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 150">
    <rect width="600" height="150" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">IF() Function (MySQL)</text>
    <text x="300" y="60" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">Shorthand for simple CASE statements.</text>
    
    <rect x="20" y="80" width="560" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="30" y="105" font-family="Courier New" font-size="16" fill="$($Theme.accent1)" text-anchor="start">IF(</text>
    <text x="70" y="105" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="start">score > 50,</text>
    <text x="200" y="105" font-family="Courier New" font-size="16" fill="$($Theme.accent2)" text-anchor="start">'Pass',</text>
    <text x="280" y="105" font-family="Courier New" font-size="16" fill="$($Theme.accent5)" text-anchor="start">'Fail'</text>
    <text x="350" y="105" font-family="Courier New" font-size="16" fill="$($Theme.accent1)" text-anchor="start">)</text>
    
    <text x="70" y="135" font-family="Arial" font-size="10" fill="$($Theme.textSecondary)" text-anchor="start">Condition</text>
    <text x="200" y="135" font-family="Arial" font-size="10" fill="$($Theme.textSecondary)" text-anchor="start">If TRUE</text>
    <text x="280" y="135" font-family="Arial" font-size="10" fill="$($Theme.textSecondary)" text-anchor="start">If FALSE</text>
</svg>
"@


Write-Svg "svg_locate.svg" $svg_locate
Write-Svg "svg_mod_even_odd.svg" $svg_mod_even_odd
Write-Svg "svg_if_function.svg" $svg_if_function

