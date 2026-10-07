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

$svg_datetime_anatomy = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250">
    <rect width="600" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Anatomy of Date &amp; Time</text>
    
    <!-- Date Section -->
    <rect x="50" y="80" width="220" height="80" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="160" y="70" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">DATE</text>
    <text x="160" y="115" font-family="Courier New" font-size="24" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">2025-08-20</text>
    
    <path d="M 90 135 L 90 145 L 140 145 L 140 135" fill="none" stroke="$($Theme.textSecondary)" stroke-width="2"/>
    <text x="115" y="160" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Year</text>
    
    <path d="M 150 135 L 150 145 L 180 145 L 180 135" fill="none" stroke="$($Theme.textSecondary)" stroke-width="2"/>
    <text x="165" y="160" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Month</text>
    
    <path d="M 190 135 L 190 145 L 220 145 L 220 135" fill="none" stroke="$($Theme.textSecondary)" stroke-width="2"/>
    <text x="205" y="160" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Day</text>

    <!-- Time Section -->
    <rect x="330" y="80" width="220" height="80" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="440" y="70" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">TIME</text>
    <text x="440" y="115" font-family="Courier New" font-size="24" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">18:55:45</text>

    <path d="M 390 135 L 390 145 L 420 145 L 420 135" fill="none" stroke="$($Theme.textSecondary)" stroke-width="2"/>
    <text x="405" y="160" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Hour</text>
    
    <path d="M 430 135 L 430 145 L 460 145 L 460 135" fill="none" stroke="$($Theme.textSecondary)" stroke-width="2"/>
    <text x="445" y="160" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Min</text>
    
    <path d="M 470 135 L 470 145 L 500 145 L 500 135" fill="none" stroke="$($Theme.textSecondary)" stroke-width="2"/>
    <text x="485" y="160" font-family="Arial" font-size="12" fill="$($Theme.textSecondary)" text-anchor="middle">Sec</text>

    <!-- Timestamp Combined -->
    <rect x="190" y="190" width="220" height="40" rx="5" fill="$($Theme.bg)" stroke="$($Theme.accent3)" stroke-width="2" stroke-dasharray="4,4"/>
    <text x="300" y="215" font-family="Arial" font-size="14" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">TIMESTAMP / DATETIME</text>
</svg>
"@

$svg_datetime_overview = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 250">
    <rect width="800" height="250" fill="$($Theme.bg)" rx="10"/>
    <text x="400" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Date &amp; Time Functions Overview</text>
    
    <!-- Part Extraction -->
    <rect x="50" y="80" width="160" height="130" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="130" y="105" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">Part Extraction</text>
    <text x="130" y="130" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">YEAR(), MONTH()</text>
    <text x="130" y="150" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">DAY(), HOUR()</text>
    <text x="130" y="170" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">DATEPART()</text>

    <!-- Formatting & Casting -->
    <rect x="230" y="80" width="160" height="130" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="310" y="105" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">Formatting</text>
    <text x="310" y="130" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">DATE_FORMAT()</text>
    <text x="310" y="150" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">STR_TO_DATE()</text>
    <text x="310" y="170" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">CAST()</text>

    <!-- Calculations -->
    <rect x="410" y="80" width="160" height="130" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent3)" stroke-width="2"/>
    <text x="490" y="105" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">Calculations</text>
    <text x="490" y="130" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">DATE_ADD()</text>
    <text x="490" y="150" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">DATE_SUB()</text>
    <text x="490" y="170" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">DATEDIFF()</text>

    <!-- Validation -->
    <rect x="590" y="80" width="160" height="130" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.accent5)" stroke-width="2"/>
    <text x="670" y="105" font-family="Arial" font-size="16" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">Validation/Source</text>
    <text x="670" y="130" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">NOW()</text>
    <text x="670" y="150" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">CURDATE()</text>
    <text x="670" y="170" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">ISDATE() [SQL Server]</text>
</svg>
"@

$svg_date_extraction = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200">
    <rect width="600" height="200" fill="$($Theme.bg)" rx="10"/>
    <text x="300" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">Extracting Date Parts</text>
    
    <rect x="220" y="70" width="160" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="300" y="95" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">2025-08-20</text>
    
    <!-- YEAR -->
    <path d="M 250 110 L 150 130" fill="none" stroke="$($Theme.border)" stroke-width="2"/>
    <rect x="100" y="130" width="80" height="30" rx="5" fill="$($Theme.accent1)" opacity="0.2" stroke="$($Theme.accent1)" stroke-width="2"/>
    <text x="140" y="150" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent1)" text-anchor="middle">YEAR()</text>
    <text x="140" y="180" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">2025</text>
    
    <!-- MONTH -->
    <path d="M 300 110 L 300 130" fill="none" stroke="$($Theme.border)" stroke-width="2"/>
    <rect x="260" y="130" width="80" height="30" rx="5" fill="$($Theme.accent2)" opacity="0.2" stroke="$($Theme.accent2)" stroke-width="2"/>
    <text x="300" y="150" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">MONTH()</text>
    <text x="300" y="180" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">08</text>
    
    <!-- DAY -->
    <path d="M 350 110 L 450 130" fill="none" stroke="$($Theme.border)" stroke-width="2"/>
    <rect x="420" y="130" width="80" height="30" rx="5" fill="$($Theme.accent3)" opacity="0.2" stroke="$($Theme.accent3)" stroke-width="2"/>
    <text x="460" y="150" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent3)" text-anchor="middle">DAY()</text>
    <text x="460" y="180" font-family="Courier New" font-size="16" fill="$($Theme.textPrimary)" text-anchor="middle">20</text>
</svg>
"@

$svg_date_manipulation = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 220">
    <rect width="700" height="220" fill="$($Theme.bg)" rx="10"/>
    <text x="350" y="40" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="$($Theme.accent4)" text-anchor="middle">Date Manipulation (Adding &amp; Subtracting)</text>
    
    <rect x="270" y="80" width="160" height="40" rx="5" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2"/>
    <text x="350" y="105" font-family="Courier New" font-size="20" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">2025-08-20</text>
    
    <!-- SUBTRACT 3 MONTHS -->
    <path d="M 270 100 Q 150 50 150 120" fill="none" stroke="$($Theme.accent5)" stroke-width="2" marker-end="url(#arrow_red)"/>
    <text x="150" y="80" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">- 3 Months</text>
    <rect x="90" y="120" width="120" height="30" rx="5" fill="$($Theme.bg)" stroke="$($Theme.border)" stroke-width="1"/>
    <text x="150" y="140" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">2025-05-20</text>
    <text x="150" y="170" font-family="Arial" font-size="10" fill="$($Theme.textSecondary)" text-anchor="middle">DATE_SUB(.., INTERVAL 3 MONTH)</text>
    
    <!-- ADD 5 DAYS -->
    <path d="M 430 100 Q 550 50 550 120" fill="none" stroke="$($Theme.accent2)" stroke-width="2" marker-end="url(#arrow_green)"/>
    <text x="550" y="80" font-family="Arial" font-size="12" font-weight="bold" fill="$($Theme.accent2)" text-anchor="middle">+ 5 Days</text>
    <rect x="490" y="120" width="120" height="30" rx="5" fill="$($Theme.bg)" stroke="$($Theme.border)" stroke-width="1"/>
    <text x="550" y="140" font-family="Courier New" font-size="14" fill="$($Theme.textPrimary)" text-anchor="middle">2025-08-25</text>
    <text x="550" y="170" font-family="Arial" font-size="10" fill="$($Theme.textSecondary)" text-anchor="middle">DATE_ADD(.., INTERVAL 5 DAY)</text>

    <!-- Defs -->
    <defs>
        <marker id="arrow_red" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent5)" />
        </marker>
        <marker id="arrow_green" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent2)" />
        </marker>
    </defs>
</svg>
"@

Write-Svg "svg_datetime_anatomy.svg" $svg_datetime_anatomy
Write-Svg "svg_datetime_overview.svg" $svg_datetime_overview
Write-Svg "svg_date_extraction.svg" $svg_date_extraction
Write-Svg "svg_date_manipulation.svg" $svg_date_manipulation
