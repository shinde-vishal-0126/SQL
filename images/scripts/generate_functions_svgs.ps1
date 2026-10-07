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

$svg_functions_intro = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">What is a SQL Function?</text>
    
    <!-- Input -->
    <rect x="50" y="100" width="100" height="50" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="100" y="130" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Input Value</text>
    
    <!-- Arrow 1 -->
    <path d="M 160 125 L 230 125" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    
    <!-- Function Box -->
    <rect x="240" y="90" width="120" height="70" rx="10" fill="$($Theme.accent4)" opacity="0.9"/>
    <text x="300" y="130" font-family="Arial" font-size="18" font-weight="bold" fill="#000000" text-anchor="middle">FUNCTION</text>
    
    <!-- Arrow 2 -->
    <path d="M 370 125 L 440 125" fill="none" stroke="$($Theme.border)" stroke-width="3" marker-end="url(#arrow)"/>
    
    <!-- Output -->
    <rect x="450" y="100" width="100" height="50" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="500" y="130" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Output Value</text>
    
    <!-- Description -->
    <text x="300" y="200" font-family="Arial" font-size="14" fill="$($Theme.textSecondary)" text-anchor="middle">A built-in SQL code that accepts an input, processes it, and returns an output.</text>

    <!-- Def -->
    <defs>
        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
    </defs>
</svg>
"@

$svg_single_vs_multi = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 300">
    <rect width="700" height="300" fill="$($Theme.bg)" rx="10"/>
    <text x="350" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">Single-Row vs Multi-Row Functions</text>
    
    <!-- Single Row -->
    <text x="150" y="90" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">1. Single-Row Functions</text>
    <text x="150" y="110" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">1 Input Row = 1 Output Row</text>
    
    <text x="70" y="150" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)">'MARIA'</text>
    <path d="M 140 145 L 180 145" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <rect x="190" y="125" width="80" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="230" y="150" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">LOWER()</text>
    <path d="M 280 145 L 320 145" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <text x="330" y="150" font-family="Courier New" font-size="16" fill="$($Theme.accent2)">'maria'</text>
    
    <!-- Multi Row -->
    <text x="150" y="210" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">2. Multi-Row Functions (Aggregates)</text>
    <text x="150" y="230" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Multiple Input Rows = 1 Summarized Output</text>
    
    <text x="90" y="250" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">30</text>
    <text x="90" y="265" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">10</text>
    <text x="90" y="280" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">20</text>
    
    <path d="M 120 250 L 180 260" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <path d="M 120 265 L 180 265" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <path d="M 120 280 L 180 270" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    
    <rect x="190" y="245" width="80" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="230" y="270" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">SUM()</text>
    
    <path d="M 280 265 L 320 265" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <text x="330" y="270" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent2)">60</text>

    <!-- Def -->
    <defs>
        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
    </defs>
</svg>
"@

$svg_nested_functions = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200">
    <rect width="600" height="200" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">Nested Functions</text>
    
    <text x="300" y="80" font-family="Courier New" font-size="24" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">
        <tspan fill="$($Theme.accent1)">LENGTH</tspan>( <tspan fill="$($Theme.accent2)">LOWER</tspan>( <tspan fill="$($Theme.accent4)">LEFT</tspan>('Maria', 2) ) )
    </text>
    
    <!-- Explanation brackets -->
    <path d="M 400 100 L 400 120 L 490 120 L 490 100" fill="none" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="445" y="140" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">1. Extracts 'Ma'</text>
    
    <path d="M 280 150 L 280 160 L 510 160 L 510 150" fill="none" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="395" y="175" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">2. Converts to 'ma'</text>
    
    <path d="M 140 180 L 140 190 L 530 190 L 530 180" fill="none" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="335" y="205" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">3. Returns Length: 2</text>
</svg>
"@

$svg_string_functions = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 350">
    <rect width="800" height="350" fill="$($Theme.bg)" rx="10"/>
    <text x="400" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">String Functions Mastery</text>
    
    <!-- Manipulation -->
    <rect x="50" y="80" width="200" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="150" y="105" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">Manipulation</text>
    
    <text x="60" y="140" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">CONCAT()</text>
    <text x="150" y="140" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)">Combines strings</text>
    
    <text x="60" y="170" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">UPPER()</text>
    <text x="150" y="170" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)">To UPPERCASE</text>
    
    <text x="60" y="200" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">LOWER()</text>
    <text x="150" y="200" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)">To lowercase</text>
    
    <text x="60" y="230" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">TRIM()</text>
    <text x="150" y="230" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)">Removes spaces</text>
    
    <text x="60" y="260" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">REPLACE()</text>
    <text x="150" y="260" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)">Swaps characters</text>
    
    <!-- Calculation -->
    <rect x="300" y="80" width="200" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="400" y="105" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">Calculation</text>
    
    <text x="310" y="140" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">LENGTH()</text>
    <text x="400" y="140" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)">Counts characters</text>
    <text x="310" y="170" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">LEN()</text>
    <text x="400" y="170" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)">(SQL Server)</text>
    
    <!-- Extraction -->
    <rect x="550" y="80" width="200" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent3)" stroke-width="2"/>
    <text x="650" y="105" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">Extraction</text>
    
    <text x="560" y="140" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">LEFT(str, N)</text>
    <text x="660" y="140" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)">First N chars</text>
    
    <text x="560" y="170" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">RIGHT(str, N)</text>
    <text x="660" y="170" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)">Last N chars</text>
    
    <text x="560" y="200" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">SUBSTRING()</text>
    <text x="660" y="200" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)">Extract from middle</text>
    
    <text x="560" y="220" font-family="Courier New" font-size="12" fill="$($Theme.textPrimary)">(str, start, length)</text>
</svg>
"@

$svg_numeric_functions = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">Numeric Functions</text>
    
    <!-- ROUND -->
    <rect x="50" y="80" width="220" height="120" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="160" y="110" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">ROUND(val, N)</text>
    
    <text x="70" y="140" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">3.516, 2</text>
    <path d="M 150 135 L 200 135" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <text x="210" y="140" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent2)">3.52</text>
    
    <text x="70" y="170" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">3.516, 0</text>
    <path d="M 150 165 L 200 165" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <text x="210" y="170" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent2)">4</text>
    
    <!-- ABS -->
    <rect x="330" y="80" width="220" height="120" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="440" y="110" font-family="Arial" font-size="18" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">ABS(val)</text>
    
    <text x="360" y="150" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)">-10</text>
    <path d="M 400 145 L 450 145" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    <text x="460" y="150" font-family="Courier New" font-size="16" font-weight="bold" fill="$($Theme.accent4)">10</text>
    
    <text x="440" y="180" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Returns absolute (positive) value</text>

    <!-- Def -->
    <defs>
        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
    </defs>
</svg>
"@

Write-Svg "svg_functions_intro.svg" $svg_functions_intro
Write-Svg "svg_single_vs_multi.svg" $svg_single_vs_multi
Write-Svg "svg_nested_functions.svg" $svg_nested_functions
Write-Svg "svg_string_functions.svg" $svg_string_functions
Write-Svg "svg_numeric_functions.svg" $svg_numeric_functions
