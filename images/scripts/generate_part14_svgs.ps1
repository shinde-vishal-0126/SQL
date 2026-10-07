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

$svg_over_clause = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 250">
    <rect width="700" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="350" y="30" font-family="Arial" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">OVER() Clause Structure</text>
    
    <text x="350" y="60" font-family="Courier New" font-size="18" fill="$($Theme.textPrimary)" text-anchor="middle">
        Function_Name() OVER ( <tspan fill="$($Theme.accent1)">PARTITION BY</tspan> ... <tspan fill="$($Theme.accent2)">ORDER BY</tspan> ... <tspan fill="$($Theme.accent3)">FRAME</tspan> )
    </text>

    <!-- Partition By -->
    <rect x="50" y="100" width="180" height="110" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <rect x="50" y="100" width="180" height="30" fill="$($Theme.accent1)"/>
    <text x="140" y="120" font-family="Arial" font-size="14" font-weight="bold" fill="#000000" text-anchor="middle">PARTITION BY</text>
    <text x="140" y="155" font-family="Arial" font-size="13" fill="$($Theme.textPrimary)" text-anchor="middle">Divides the dataset</text>
    <text x="140" y="175" font-family="Arial" font-size="13" fill="$($Theme.textPrimary)" text-anchor="middle">into windows/groups</text>
    <text x="140" y="195" font-family="Arial" font-size="12" font-style="italic" fill="$($Theme.textSecondary)" text-anchor="middle">(Optional for all)</text>

    <!-- Order By -->
    <rect x="260" y="100" width="180" height="110" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <rect x="260" y="100" width="180" height="30" fill="$($Theme.accent2)"/>
    <text x="350" y="120" font-family="Arial" font-size="14" font-weight="bold" fill="#000000" text-anchor="middle">ORDER BY</text>
    <text x="350" y="155" font-family="Arial" font-size="13" fill="$($Theme.textPrimary)" text-anchor="middle">Sorts the data</text>
    <text x="350" y="175" font-family="Arial" font-size="13" fill="$($Theme.textPrimary)" text-anchor="middle">within a window</text>
    <text x="350" y="195" font-family="Arial" font-size="12" font-style="italic" fill="$($Theme.textSecondary)" text-anchor="middle">(Required for Rank/Value)</text>

    <!-- Frame -->
    <rect x="470" y="100" width="180" height="110" fill="$($Theme.boxBg)" stroke="$($Theme.accent3)" stroke-width="2"/>
    <rect x="470" y="100" width="180" height="30" fill="$($Theme.accent3)"/>
    <text x="560" y="120" font-family="Arial" font-size="14" font-weight="bold" fill="#000000" text-anchor="middle">FRAME CLAUSE</text>
    <text x="560" y="155" font-family="Arial" font-size="13" fill="$($Theme.textPrimary)" text-anchor="middle">Defines a subset of</text>
    <text x="560" y="175" font-family="Arial" font-size="13" fill="$($Theme.textPrimary)" text-anchor="middle">rows inside a window</text>
    <text x="560" y="195" font-family="Arial" font-size="12" font-style="italic" fill="$($Theme.textSecondary)" text-anchor="middle">(e.g. ROWS BETWEEN...)</text>

</svg>
"@

Write-Svg "svg_over_clause.svg" $svg_over_clause
