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

$svg_case_execution = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Courier New" font-size="18" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">How CASE Works (Execution Flow)</text>
    <text x="300" y="55" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">SQL stops execution once the FIRST condition is met.</text>
    
    <!-- Flowchart -->
    <text x="100" y="100" font-family="Courier New" font-size="14" fill="$($Theme.accent1)" text-anchor="middle">CASE</text>
    <path d="M 100 110 L 100 130" fill="none" stroke="$($Theme.border)" stroke-width="2" marker-end="url(#arrow)"/>
    
    <polygon points="100,130 160,160 100,190 40,160" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="100" y="165" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">Sales > 50?</text>

    <!-- True Branch 1 -->
    <path d="M 100 190 L 100 210 L 150 210" fill="none" stroke="$($Theme.accent2)" stroke-width="2" marker-end="url(#arrow_green)"/>
    <text x="120" y="205" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">True</text>
    <rect x="150" y="195" width="60" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="180" y="215" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">'High'</text>

    <!-- False Branch 1 -->
    <path d="M 160 160 L 250 160" fill="none" stroke="$($Theme.accent5)" stroke-width="2" marker-end="url(#arrow_red)"/>
    <text x="205" y="155" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">False</text>

    <!-- Condition 2 -->
    <polygon points="310,130 370,160 310,190 250,160" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="2"/>
    <text x="310" y="165" font-family="Arial" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">Sales > 20?</text>

    <!-- True Branch 2 -->
    <path d="M 310 190 L 310 210 L 360 210" fill="none" stroke="$($Theme.accent2)" stroke-width="2" marker-end="url(#arrow_green)"/>
    <text x="330" y="205" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">True</text>
    <rect x="360" y="195" width="80" height="30" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="400" y="215" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">'Medium'</text>

    <!-- End Node -->
    <path d="M 210 210 L 280 210 L 280 230" fill="none" stroke="$($Theme.border)" stroke-width="2"/>
    <path d="M 440 210 L 500 210 L 500 230 L 280 230" fill="none" stroke="$($Theme.border)" stroke-width="2"/>
    <circle cx="280" cy="235" r="5" fill="$($Theme.border)"/>
    <text x="280" y="250" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">END</text>

    <defs>
        <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.border)" />
        </marker>
        <marker id="arrow_green" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent2)" />
        </marker>
        <marker id="arrow_red" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent5)" />
        </marker>
    </defs>
</svg>
"@

$svg_case_full_vs_quick = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Courier New" font-size="18" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">CASE: Full Form vs Quick Form</text>
    
    <!-- Full Form -->
    <rect x="50" y="60" width="220" height="130" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="160" y="50" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Full Form (Searched)</text>
    <text x="60" y="80" font-family="Courier New" font-size="12" fill="$($Theme.accent1)" text-anchor="start">CASE</text>
    <text x="70" y="100" font-family="Courier New" font-size="12" fill="$($Theme.textPrimary)" text-anchor="start">WHEN Country = 'Germany'</text>
    <text x="70" y="120" font-family="Courier New" font-size="12" fill="$($Theme.textPrimary)" text-anchor="start">WHEN Country = 'India'</text>
    <text x="70" y="140" font-family="Courier New" font-size="12" fill="$($Theme.textPrimary)" text-anchor="start">ELSE 'N/A'</text>
    <text x="60" y="160" font-family="Courier New" font-size="12" fill="$($Theme.accent1)" text-anchor="start">END</text>
    <text x="160" y="180" font-family="Arial" font-size="10" fill="$($Theme.textSecondary)" text-anchor="middle">Allows multiple complex conditions</text>

    <!-- Quick Form -->
    <rect x="330" y="60" width="220" height="130" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="440" y="50" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">Quick Form (Simple)</text>
    <text x="340" y="80" font-family="Courier New" font-size="12" fill="$($Theme.accent1)" text-anchor="start">CASE Country</text>
    <text x="350" y="100" font-family="Courier New" font-size="12" fill="$($Theme.textPrimary)" text-anchor="start">WHEN 'Germany' THEN 'GE'</text>
    <text x="350" y="120" font-family="Courier New" font-size="12" fill="$($Theme.textPrimary)" text-anchor="start">WHEN 'India' THEN 'IN'</text>
    <text x="350" y="140" font-family="Courier New" font-size="12" fill="$($Theme.textPrimary)" text-anchor="start">ELSE 'N/A'</text>
    <text x="340" y="160" font-family="Courier New" font-size="12" fill="$($Theme.accent1)" text-anchor="start">END</text>
    <text x="440" y="180" font-family="Arial" font-size="10" fill="$($Theme.textSecondary)" text-anchor="middle">Column name evaluated only once</text>
</svg>
"@

$svg_case_summary = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="30" font-family="Arial, sans-serif" font-size="18" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">CASE Statement Summary</text>
    
    <text x="50" y="60" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="start">Evaluates a list of conditions and returns a value when the FIRST condition is met.</text>
    
    <rect x="50" y="80" width="60" height="20" fill="$($Theme.accent5)" rx="3"/>
    <text x="80" y="94" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.bg)" text-anchor="middle">RULES</text>
    <text x="120" y="94" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="start">The data type of the results must be matching.</text>
    <text x="120" y="114" font-family="Arial" font-size="14" fill="$($Theme.textPrimary)" text-anchor="start">Can be used anywhere in the query (SELECT, ORDER BY).</text>

    <rect x="50" y="130" width="90" height="20" fill="$($Theme.accent2)" rx="3"/>
    <text x="95" y="144" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.bg)" text-anchor="middle">USE CASES</text>
    
    <circle cx="160" cy="160" r="5" fill="$($Theme.accent1)"/>
    <text x="175" y="165" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="start">1. Categorizing Data (High/Med/Low)</text>
    
    <circle cx="160" cy="180" r="5" fill="$($Theme.accent1)"/>
    <text x="175" y="185" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="start">2. Mapping Values (f -> Female)</text>
    
    <circle cx="160" cy="200" r="5" fill="$($Theme.accent1)"/>
    <text x="175" y="205" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="start">3. Handling NULLs</text>
    
    <circle cx="160" cy="220" r="5" fill="$($Theme.accent1)"/>
    <text x="175" y="225" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="start">4. Conditional Aggregations</text>
</svg>
"@

Write-Svg "svg_case_execution.svg" $svg_case_execution
Write-Svg "svg_case_full_vs_quick.svg" $svg_case_full_vs_quick
Write-Svg "svg_case_summary.svg" $svg_case_summary
