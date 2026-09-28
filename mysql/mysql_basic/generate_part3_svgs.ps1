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

$svg_func_comparison_datatype = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200">
    <rect width="600" height="200" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial, sans-serif" font-size="18" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Function Return Types</text>
    
    <text x="200" y="70" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="end">DATEPART</text>
    <path d="M 220 65 L 280 65" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow_gray)"/>
    <text x="320" y="70" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="start">INT</text>

    <text x="200" y="100" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="end">DATENAME</text>
    <path d="M 220 95 L 280 95" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow_gray)"/>
    <text x="320" y="100" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="start">STRING</text>

    <text x="200" y="130" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="end">DATETRUNC</text>
    <path d="M 220 125 L 280 125" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow_gray)"/>
    <text x="320" y="130" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="start">DATETIME</text>

    <text x="200" y="160" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="end">EOMONTH</text>
    <path d="M 220 155 L 280 155" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow_gray)"/>
    <text x="320" y="160" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="start">DATE</text>

    <defs>
        <marker id="arrow_gray" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
    </defs>
</svg>
"@

$svg_cast_vs_format = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200">
    <rect width="600" height="200" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial, sans-serif" font-size="18" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">CAST &amp; CONVERT vs FORMAT</text>
    
    <text x="200" y="70" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">CASTING</text>
    <text x="400" y="70" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">FORMATTING</text>

    <text x="80" y="110" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">CAST</text>
    <text x="200" y="110" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Any Type $\rightarrow$ Any Type</text>
    <text x="400" y="110" font-family="Arial" font-size="14" fill="$($Theme.accent5)" text-anchor="middle">X No Formatting</text>

    <text x="80" y="150" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">FORMAT</text>
    <text x="200" y="150" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Any Type $\rightarrow$ Only String</text>
    <text x="400" y="150" font-family="Arial" font-size="14" fill="$($Theme.accent2)" text-anchor="middle">Formats Date, Time, Numbers</text>

    <!-- Grid lines -->
    <path d="M 140 50 L 140 180" fill="none" stroke="$($Theme.border)" stroke-width="1"/>
    <path d="M 300 50 L 300 180" fill="none" stroke="$($Theme.border)" stroke-width="1"/>
    <path d="M 50 130 L 550 130" fill="none" stroke="$($Theme.border)" stroke-width="1"/>
</svg>
"@

$svg_isdate = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 150">
    <rect width="600" height="150" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="40" font-family="Courier New" font-size="24" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">ISDATE()</text>
    
    <text x="300" y="80" font-family="Arial" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">Checks if a value is a valid date.</text>
    
    <rect x="250" y="100" width="100" height="30" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="300" y="120" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">Returns 1</text>
    <text x="360" y="120" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="start">if the string value is a valid date.</text>
</svg>
"@

$svg_null_overview = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial, sans-serif" font-size="18" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">NULL Functions Overview</text>
    
    <!-- Replace Values -->
    <text x="100" y="80" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Replace Values</text>
    
    <rect x="180" y="55" width="60" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent5)" stroke-width="2"/>
    <text x="210" y="75" font-family="Courier New" font-size="14" fill="$($Theme.accent5)" text-anchor="middle">NULL</text>
    <path d="M 250 70 L 350 70" fill="none" stroke="$($Theme.accent1)" stroke-width="2" marker-end="url(#arrow_blue)"/>
    <text x="300" y="65" font-family="Arial" font-size="10" fill="$($Theme.accent1)" text-anchor="middle">ISNULL / COALESCE</text>
    <rect x="360" y="55" width="60" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="390" y="75" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">40</text>

    <!-- Check for Nulls -->
    <text x="100" y="160" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Check for Nulls</text>
    
    <rect x="180" y="145" width="60" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent5)" stroke-width="2"/>
    <text x="210" y="165" font-family="Courier New" font-size="14" fill="$($Theme.accent5)" text-anchor="middle">NULL</text>
    
    <path d="M 250 160 L 350 130" fill="none" stroke="$($Theme.accent1)" stroke-width="2" marker-end="url(#arrow_blue)"/>
    <text x="300" y="140" font-family="Arial" font-size="12" fill="$($Theme.accent1)" text-anchor="middle">IS NULL</text>
    <rect x="360" y="115" width="60" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="390" y="135" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">TRUE</text>
    
    <path d="M 250 160 L 350 190" fill="none" stroke="$($Theme.accent1)" stroke-width="2" marker-end="url(#arrow_blue)"/>
    <text x="300" y="195" font-family="Arial" font-size="12" fill="$($Theme.accent1)" text-anchor="middle">IS NOT NULL</text>
    <rect x="360" y="175" width="60" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent5)" stroke-width="2"/>
    <text x="390" y="195" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">FALSE</text>

    <defs>
        <marker id="arrow_blue" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent1)" />
        </marker>
    </defs>
</svg>
"@

$svg_isnull_vs_coalesce = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200">
    <rect width="600" height="200" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial, sans-serif" font-size="18" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">ISNULL vs COALESCE</text>
    
    <text x="200" y="70" font-family="Courier New" font-size="18" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">ISNULL</text>
    <text x="400" y="70" font-family="Courier New" font-size="18" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">COALESCE</text>

    <text x="200" y="100" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Limited to two values</text>
    <text x="400" y="100" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Unlimited expressions</text>

    <text x="200" y="130" font-family="Arial" font-size="14" fill="$($Theme.accent2)" text-anchor="middle">Fast</text>
    <text x="400" y="130" font-family="Arial" font-size="14" fill="$($Theme.accent5)" text-anchor="middle">Slow (ANSI Standard)</text>

    <text x="200" y="160" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">SQL Server ONLY</text>
    <text x="400" y="160" font-family="Arial" font-size="14" fill="$($Theme.accent2)" text-anchor="middle">Available in All Databases</text>

    <!-- Grid lines -->
    <path d="M 300 50 L 300 180" fill="none" stroke="$($Theme.border)" stroke-width="1"/>
</svg>
"@

$svg_coalesce_join = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200">
    <rect width="600" height="200" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial, sans-serif" font-size="18" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">COALESCE / ISNULL in JOIN Condition</text>
    
    <text x="300" y="60" font-family="Courier New" font-size="14" fill="$($Theme.accent1)" text-anchor="middle">Handling NULLs before joining tables ensures matches aren't missed.</text>
    
    <rect x="100" y="90" width="400" height="80" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="120" y="115" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="start">SELECT a.type, b.sales FROM Table1 a</text>
    <text x="120" y="135" font-family="Courier New" font-size="14" fill="$($Theme.accent1)" text-anchor="start">JOIN Table2 b ON a.year = b.year </text>
    <text x="120" y="155" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.accent4)" text-anchor="start">AND IFNULL(a.type, '') = IFNULL(b.type, '')</text>
</svg>
"@

$svg_is_not_null = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 150">
    <rect width="600" height="150" fill="$($Theme.bg)" rx="10"/>
    <text x="150" y="50" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">IS NOT NULL</text>
    <text x="150" y="80" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Returns TRUE if value is NOT NULL</text>
    
    <text x="400" y="50" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Price: 10</text>
    <path d="M 400 55 L 400 75" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow_gray)"/>
    <text x="400" y="90" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">TRUE</text>
    
    <text x="500" y="50" font-family="Courier New" font-size="14" fill="$($Theme.accent5)" text-anchor="middle">Price: NULL</text>
    <path d="M 500 55 L 500 75" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow_gray)"/>
    <text x="500" y="90" font-family="Courier New" font-size="14" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">FALSE</text>

    <defs>
        <marker id="arrow_gray" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
    </defs>
</svg>
"@

Write-Svg "svg_func_comparison_datatype.svg" $svg_func_comparison_datatype
Write-Svg "svg_cast_vs_format.svg" $svg_cast_vs_format
Write-Svg "svg_isdate.svg" $svg_isdate
Write-Svg "svg_null_overview.svg" $svg_null_overview
Write-Svg "svg_isnull_vs_coalesce.svg" $svg_isnull_vs_coalesce
Write-Svg "svg_coalesce_join.svg" $svg_coalesce_join
Write-Svg "svg_is_not_null.svg" $svg_is_not_null
