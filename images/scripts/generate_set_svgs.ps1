$TargetDir = "d:\IMP\SQL\images"

# Helper function to write SVG
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

$svg_set_types = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 400">
    <rect width="800" height="400" fill="$($Theme.bg)" rx="10"/>
    <text x="400" y="50" font-family="Arial, sans-serif" font-size="24" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Types of SET Operators</text>
    
    <!-- Central Node -->
    <rect x="320" y="170" width="160" height="60" rx="30" fill="$($Theme.accent3)" opacity="0.2"/>
    <rect x="320" y="170" width="160" height="60" rx="30" fill="none" stroke="$($Theme.accent3)" stroke-width="2"/>
    <text x="400" y="205" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">SET Operators</text>
    
    <!-- Branches -->
    <path d="M 320 200 C 250 200, 250 100, 180 100" fill="none" stroke="$($Theme.border)" stroke-width="3"/>
    <path d="M 320 200 C 250 200, 250 170, 180 170" fill="none" stroke="$($Theme.border)" stroke-width="3"/>
    <path d="M 480 200 C 550 200, 550 130, 620 130" fill="none" stroke="$($Theme.border)" stroke-width="3"/>
    <path d="M 480 200 C 550 200, 550 270, 620 270" fill="none" stroke="$($Theme.border)" stroke-width="3"/>
    
    <!-- Nodes -->
    <rect x="40" y="75" width="140" height="50" rx="10" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="110" y="105" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">UNION</text>
    
    <rect x="40" y="145" width="140" height="50" rx="10" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="110" y="175" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">UNION ALL</text>
    
    <rect x="620" y="105" width="140" height="50" rx="10" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="690" y="135" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">INTERSECT</text>
    
    <rect x="620" y="245" width="140" height="50" rx="10" fill="$($Theme.boxBg)" stroke="$($Theme.accent5)" stroke-width="2"/>
    <text x="690" y="275" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">EXCEPT (MINUS)</text>
    
    <!-- Subtexts -->
    <text x="110" y="135" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Unique Rows</text>
    <text x="110" y="205" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">All Rows (with Dupes)</text>
    <text x="690" y="165" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Common Rows</text>
    <text x="690" y="305" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Only in First Query</text>
</svg>
"@

$svg_set_execution = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 300">
    <rect width="800" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="400" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">SET Operator Execution Flow</text>
    
    <!-- Query 1 -->
    <rect x="50" y="70" width="220" height="80" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="160" y="90" font-family="Courier New, monospace" font-size="14" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">SELECT FirstName</text>
    <text x="160" y="110" font-family="Courier New, monospace" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">FROM Customers</text>
    
    <!-- Query 2 -->
    <rect x="50" y="180" width="220" height="80" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="160" y="200" font-family="Courier New, monospace" font-size="14" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">SELECT FirstName</text>
    <text x="160" y="220" font-family="Courier New, monospace" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">FROM Employees</text>
    
    <!-- Arrows -->
    <path d="M 270 110 L 330 110 L 330 160 L 370 160" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    <path d="M 270 220 L 330 220 L 330 170 L 370 170" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    
    <!-- SET Operator -->
    <rect x="370" y="145" width="100" height="40" rx="20" fill="$($Theme.accent3)" opacity="0.2"/>
    <rect x="370" y="145" width="100" height="40" rx="20" fill="none" stroke="$($Theme.accent3)" stroke-width="2"/>
    <text x="420" y="170" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">UNION</text>
    
    <!-- Arrow to Result -->
    <path d="M 470 165 L 530 165" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    
    <!-- Result Set -->
    <rect x="530" y="100" width="220" height="130" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="640" y="125" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Combined Result Set</text>
    <line x1="530" y1="135" x2="750" y2="135" stroke="$($Theme.border)" stroke-width="1"/>
    <text x="640" y="155" font-family="Courier New, monospace" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Alice</text>
    <text x="640" y="175" font-family="Courier New, monospace" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Bob</text>
    <text x="640" y="195" font-family="Courier New, monospace" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">Charlie</text>
    <text x="640" y="215" font-family="Courier New, monospace" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">...</text>
    
    <!-- Def -->
    <defs>
        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
    </defs>
</svg>
"@

$svg_set_rules = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 400">
    <rect width="800" height="400" fill="$($Theme.bg)" rx="10"/>
    <text x="400" y="40" font-family="Arial, sans-serif" font-size="24" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">6 Golden Rules of SET Operators</text>
    
    <g transform="translate(50, 80)">
        <rect x="0" y="0" width="330" height="70" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="1"/>
        <text x="15" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent1)">1. SQL Clauses</text>
        <text x="15" y="45" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)">Can use WHERE, GROUP BY, etc.</text>
        <text x="15" y="60" font-family="Arial" font-size="12" fill="$($Theme.accent5)">ORDER BY only once at the end!</text>
        
        <rect x="0" y="90" width="330" height="70" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="1"/>
        <text x="15" y="115" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent1)">2. Same Number of Columns</text>
        <text x="15" y="135" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)">Query 1: 3 Columns</text>
        <text x="15" y="150" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)">Query 2: 3 Columns (Must Match!)</text>

        <rect x="0" y="180" width="330" height="70" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="1"/>
        <text x="15" y="205" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent1)">3. Compatible Data Types</text>
        <text x="15" y="225" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)">Col 1 in Q1 must be compatible</text>
        <text x="15" y="240" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)">with Col 1 in Q2 (e.g. INT with BIGINT).</text>
        
        <rect x="370" y="0" width="330" height="70" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="1"/>
        <text x="385" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent1)">4. Same Order of Columns</text>
        <text x="385" y="45" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)">Col 1: Name | Col 2: Age</text>
        <text x="385" y="60" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)">Must be the exact same order in both queries.</text>
        
        <rect x="370" y="90" width="330" height="70" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="1"/>
        <text x="385" y="115" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent1)">5. First Query Controls Aliases</text>
        <text x="385" y="135" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)">The column names in the final result</text>
        <text x="385" y="150" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)">are entirely taken from Query 1.</text>

        <rect x="370" y="180" width="330" height="70" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="1"/>
        <text x="385" y="205" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent1)">6. Mapping Correct Columns</text>
        <text x="385" y="225" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)">Even if rules pass, logically mapping Name</text>
        <text x="385" y="240" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)">to Name (not Age to Name) is vital!</text>
    </g>
</svg>
"@

$svg_union = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300">
    <rect width="500" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="250" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">UNION (Unique Rows)</text>
    
    <circle cx="200" cy="160" r="80" fill="$($Theme.accent1)" opacity="0.3" stroke="$($Theme.accent1)" stroke-width="3"/>
    <circle cx="300" cy="160" r="80" fill="$($Theme.accent2)" opacity="0.3" stroke="$($Theme.accent2)" stroke-width="3"/>
    
    <text x="160" y="165" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)">Table A</text>
    <text x="340" y="165" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)">Table B</text>
    <text x="250" y="165" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Common</text>
    
    <text x="250" y="270" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">Combines everything, but REMOVES duplicates</text>
</svg>
"@

$svg_intersect = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300">
    <rect width="500" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="250" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">INTERSECT (Common Rows)</text>
    
    <!-- Clip path to show only intersection -->
    <defs>
        <clipPath id="intersectClip">
            <circle cx="300" cy="160" r="80"/>
        </clipPath>
    </defs>
    
    <circle cx="200" cy="160" r="80" fill="none" stroke="$($Theme.accent1)" stroke-width="3"/>
    <circle cx="300" cy="160" r="80" fill="none" stroke="$($Theme.accent2)" stroke-width="3"/>
    
    <circle cx="200" cy="160" r="80" fill="$($Theme.accent3)" opacity="0.6" clip-path="url(#intersectClip)"/>
    
    <text x="150" y="165" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textSecondary)">Table A</text>
    <text x="350" y="165" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textSecondary)">Table B</text>
    <text x="250" y="165" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Match</text>
    
    <text x="250" y="270" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">Returns ONLY the rows that exist in BOTH queries</text>
</svg>
"@

$svg_except = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300">
    <rect width="500" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="250" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">EXCEPT / MINUS (Difference)</text>
    
    <!-- Clip path to subtract intersection -->
    <defs>
        <mask id="exceptMask">
            <rect width="500" height="300" fill="white"/>
            <circle cx="300" cy="160" r="80" fill="black"/>
        </mask>
    </defs>
    
    <circle cx="200" cy="160" r="80" fill="$($Theme.accent5)" opacity="0.6" mask="url(#exceptMask)"/>
    
    <circle cx="200" cy="160" r="80" fill="none" stroke="$($Theme.accent1)" stroke-width="3"/>
    <circle cx="300" cy="160" r="80" fill="none" stroke="$($Theme.textSecondary)" stroke-width="3" stroke-dasharray="5,5"/>
    
    <text x="160" y="165" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)">Query A</text>
    <text x="340" y="165" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.textSecondary)">Query B</text>
    
    <text x="250" y="270" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">Returns rows from Query A that are NOT in Query B</text>
</svg>
"@

Write-Svg "svg_set_types.svg" $svg_set_types
Write-Svg "svg_set_execution.svg" $svg_set_execution
Write-Svg "svg_set_rules.svg" $svg_set_rules
Write-Svg "svg_union.svg" $svg_union
Write-Svg "svg_intersect.svg" $svg_intersect
Write-Svg "svg_except.svg" $svg_except
