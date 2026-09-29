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

$svg_index_syntax = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 350">
    <rect width="800" height="350" fill="$($Theme.bg)" rx="10"/>
    
    <!-- Title -->
    <rect x="300" y="20" width="200" height="40" fill="$($Theme.accent4)" rx="5"/>
    <text x="400" y="45" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="#000000" text-anchor="middle">Index Syntax</text>
    
    <!-- Syntax Box -->
    <rect x="50" y="100" width="700" height="70" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2" rx="5"/>
    <text x="70" y="130" font-family="Courier New, monospace" font-size="16" fill="$($Theme.accent1)" font-weight="bold">CREATE <tspan fill="$($Theme.textPrimary)">[UNIQUE]</tspan> [CLUSTERED | NONCLUSTERED] [COLUMNSTORE] INDEX index_name</text>
    <text x="145" y="155" font-family="Courier New, monospace" font-size="16" fill="$($Theme.accent1)" font-weight="bold">ON <tspan fill="$($Theme.textPrimary)">table_name (column1, column2, ...)</tspan></text>
    
    <!-- Default Pointer -->
    <path d="M 270 70 L 270 95" fill="none" stroke="$($Theme.accent5)" stroke-width="2" stroke-dasharray="4,4" marker-end="url(#arrow-red)"/>
    <text x="270" y="55" font-family="Arial, sans-serif" font-size="14" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Default is</text>
    <text x="270" y="70" font-family="Arial, sans-serif" font-size="14" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">NOT Unique</text>
    
    <!-- Duplicate Examples -->
    <text x="50" y="210" font-family="Arial, sans-serif" font-size="14" fill="$($Theme.textSecondary)">Index Allows Duplicates:</text>
    <path d="M 210 205 L 240 205" fill="none" stroke="$($Theme.accent5)" stroke-width="2" marker-end="url(#arrow-red)"/>
    <text x="250" y="210" font-family="Courier New, monospace" font-size="16" fill="$($Theme.accent1)" font-weight="bold">CREATE INDEX <tspan fill="$($Theme.textPrimary)">IX_Customers_Email</tspan> ON <tspan fill="$($Theme.textPrimary)">Customers (Email)</tspan></text>
    
    <text x="50" y="270" font-family="Arial, sans-serif" font-size="14" fill="$($Theme.textSecondary)">Duplicates are not allowed:</text>
    <path d="M 230 265 L 260 265" fill="none" stroke="$($Theme.accent5)" stroke-width="2" marker-end="url(#arrow-red)"/>
    <text x="270" y="270" font-family="Courier New, monospace" font-size="16" fill="$($Theme.accent1)" font-weight="bold">CREATE UNIQUE INDEX <tspan fill="$($Theme.textPrimary)">IX_Customers_Email</tspan> ON <tspan fill="$($Theme.textPrimary)">Customers (Email)</tspan></text>
    
    <defs>
        <marker id="arrow-red" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
            <path d="M0,0 L0,6 L9,3 z" fill="$($Theme.accent5)" />
        </marker>
    </defs>
</svg>
"@

$svg_filtered_index = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 500">
    <rect width="800" height="500" fill="$($Theme.bg)" rx="10"/>
    
    <rect x="300" y="20" width="200" height="30" fill="$($Theme.accent4)" rx="5"/>
    <text x="400" y="40" font-family="Arial, sans-serif" font-size="16" font-weight="bold" fill="#000000" text-anchor="middle">Filtered Index Syntax</text>
    
    <rect x="50" y="70" width="700" height="80" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2" rx="5"/>
    <text x="70" y="100" font-family="Courier New, monospace" font-size="14" fill="$($Theme.accent1)" font-weight="bold">CREATE [UNIQUE] [NONCLUSTERED] INDEX <tspan fill="$($Theme.textPrimary)">index_name</tspan></text>
    <text x="70" y="120" font-family="Courier New, monospace" font-size="14" fill="$($Theme.accent1)" font-weight="bold">ON <tspan fill="$($Theme.textPrimary)">table_name (column1, column2, ...)</tspan></text>
    <text x="70" y="140" font-family="Courier New, monospace" font-size="14" fill="$($Theme.accent1)" font-weight="bold">WHERE <tspan fill="$($Theme.textPrimary)">[Condition]</tspan></text>
    
    <!-- Rules Box -->
    <rect x="250" y="170" width="400" height="60" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="1" rx="5"/>
    <rect x="260" y="185" width="50" height="25" fill="#E8E8E8" rx="3"/>
    <text x="285" y="202" font-family="Arial, sans-serif" font-size="12" font-weight="bold" fill="$($Theme.accent5)" text-anchor="middle">Rules</text>
    <text x="325" y="195" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">You <tspan fill="$($Theme.accent5)" font-weight="bold">cannot</tspan> create a filtered index on a <tspan fill="$($Theme.accent5)" font-weight="bold">clustered index.</tspan></text>
    <text x="325" y="215" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">You <tspan fill="$($Theme.accent5)" font-weight="bold">cannot</tspan> create a filtered index on a <tspan fill="$($Theme.accent5)" font-weight="bold">columnstore index.</tspan></text>
    
    <!-- Flowchart -->
    <rect x="330" y="260" width="140" height="30" fill="$($Theme.accent4)" rx="5"/>
    <text x="400" y="280" font-family="Arial, sans-serif" font-size="16" font-weight="bold" fill="#000000" text-anchor="middle">When To Use</text>
    
    <path d="M 400 290 L 400 320" fill="none" stroke="$($Theme.textPrimary)" stroke-width="2"/>
    <path d="M 180 320 L 620 320" fill="none" stroke="$($Theme.textPrimary)" stroke-width="2"/>
    <path d="M 180 320 L 180 340" fill="none" stroke="$($Theme.textPrimary)" stroke-width="2"/>
    <path d="M 400 320 L 400 340" fill="none" stroke="$($Theme.textPrimary)" stroke-width="2"/>
    <path d="M 620 320 L 620 340" fill="none" stroke="$($Theme.textPrimary)" stroke-width="2"/>
    
    <!-- Heap -->
    <rect x="100" y="340" width="160" height="50" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="3" rx="5"/>
    <rect x="100" y="340" width="160" height="20" fill="$($Theme.accent4)" rx="5" stroke="$($Theme.accent4)"/>
    <text x="180" y="355" font-family="Arial, sans-serif" font-size="14" font-weight="bold" fill="#000000" text-anchor="middle">HEAP</text>
    <text x="180" y="375" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">Fast Inserts</text>
    
    <!-- Clustered -->
    <rect x="320" y="340" width="160" height="50" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="3" rx="5"/>
    <rect x="320" y="340" width="160" height="20" fill="$($Theme.accent4)" rx="5" stroke="$($Theme.accent4)"/>
    <text x="400" y="355" font-family="Arial, sans-serif" font-size="14" font-weight="bold" fill="#000000" text-anchor="middle">Clustered Index</text>
    <text x="400" y="375" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">For Primary Keys (OLTP)</text>
    
    <!-- Columnstore -->
    <rect x="540" y="340" width="160" height="50" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="3" rx="5"/>
    <rect x="540" y="340" width="160" height="20" fill="$($Theme.accent4)" rx="5" stroke="$($Theme.accent4)"/>
    <text x="620" y="355" font-family="Arial, sans-serif" font-size="14" font-weight="bold" fill="#000000" text-anchor="middle">Columnstore Index</text>
    <text x="620" y="375" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">For Analytics (OLAP)</text>
    
    <!-- Non-Clustered -->
    <path d="M 400 390 L 400 410" fill="none" stroke="$($Theme.textPrimary)" stroke-width="2"/>
    <rect x="320" y="410" width="160" height="50" fill="$($Theme.boxBg)" stroke="$($Theme.accent4)" stroke-width="3" rx="5"/>
    <rect x="320" y="410" width="160" height="20" fill="$($Theme.accent4)" rx="5" stroke="$($Theme.accent4)"/>
    <text x="400" y="425" font-family="Arial, sans-serif" font-size="14" font-weight="bold" fill="#000000" text-anchor="middle">Non-Clustered Index</text>
    <text x="400" y="445" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">FKs, Joins, Filters</text>
</svg>
"@

$svg_indexing_strategy = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 450">
    <rect width="800" height="450" fill="$($Theme.bg)" rx="10"/>
    
    <rect x="300" y="20" width="200" height="30" fill="$($Theme.accent4)" rx="5"/>
    <text x="400" y="40" font-family="Arial, sans-serif" font-size="16" font-weight="bold" fill="#000000" text-anchor="middle">Indexing Strategy</text>
    
    <!-- Strategy 1 -->
    <rect x="50" y="80" width="300" height="150" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2" rx="5"/>
    <rect x="50" y="70" width="200" height="20" fill="#E8EFF5" stroke="$($Theme.accent1)" stroke-width="2" rx="3"/>
    <text x="150" y="85" font-family="Arial, sans-serif" font-size="12" font-weight="bold" fill="#000000" text-anchor="middle">#1 Initial Indexing Strategy</text>
    
    <rect x="70" y="110" width="100" height="25" fill="#000000" rx="3"/>
    <text x="120" y="127" font-family="Arial, sans-serif" font-size="14" font-weight="bold" fill="#FFFFFF" text-anchor="middle">OLAP</text>
    <text x="120" y="150" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">Optimize READ</text>
    <text x="120" y="180" font-family="Arial, sans-serif" font-size="12" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">ColumnStore</text>
    
    <rect x="220" y="110" width="100" height="25" fill="#000000" rx="3"/>
    <text x="270" y="127" font-family="Arial, sans-serif" font-size="14" font-weight="bold" fill="#FFFFFF" text-anchor="middle">OLTP</text>
    <text x="270" y="150" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)" text-anchor="middle">Optimize WRITE</text>
    <text x="270" y="180" font-family="Arial, sans-serif" font-size="12" font-weight="bold" fill="$($Theme.textPrimary)" text-anchor="middle">Clustered (PK)</text>
    
    <!-- Strategy 2 -->
    <rect x="450" y="80" width="300" height="150" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2" rx="5"/>
    <rect x="450" y="70" width="200" height="20" fill="#E8EFF5" stroke="$($Theme.accent2)" stroke-width="2" rx="3"/>
    <text x="550" y="85" font-family="Arial, sans-serif" font-size="12" font-weight="bold" fill="#000000" text-anchor="middle">#2 Usage Patterns Indexing</text>
    <rect x="470" y="110" width="20" height="20" fill="#666666" rx="3"/><text x="480" y="125" font-family="Arial" font-size="12" fill="#FFF" text-anchor="middle">1</text>
    <text x="500" y="125" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">Identify frequently used tables/cols</text>
    <rect x="470" y="140" width="20" height="20" fill="#666666" rx="3"/><text x="480" y="155" font-family="Arial" font-size="12" fill="#FFF" text-anchor="middle">2</text>
    <text x="500" y="155" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">Choose Right Index</text>
    <rect x="470" y="170" width="20" height="20" fill="#666666" rx="3"/><text x="480" y="185" font-family="Arial" font-size="12" fill="#FFF" text-anchor="middle">3</text>
    <text x="500" y="185" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">Test Index Performance</text>
    
    <!-- Strategy 3 -->
    <rect x="50" y="270" width="300" height="150" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2" rx="5"/>
    <rect x="50" y="260" width="200" height="20" fill="#E8EFF5" stroke="$($Theme.accent3)" stroke-width="2" rx="3"/>
    <text x="150" y="275" font-family="Arial, sans-serif" font-size="12" font-weight="bold" fill="#000000" text-anchor="middle">#3 Scenario-Based Indexing</text>
    <rect x="70" y="295" width="20" height="20" fill="#666666" rx="3"/><text x="80" y="310" font-family="Arial" font-size="12" fill="#FFF" text-anchor="middle">1</text>
    <text x="100" y="310" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">Identify Slow Queries</text>
    <rect x="70" y="325" width="20" height="20" fill="#666666" rx="3"/><text x="80" y="340" font-family="Arial" font-size="12" fill="#FFF" text-anchor="middle">2</text>
    <text x="100" y="340" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">Check Execution Plan</text>
    <rect x="70" y="355" width="20" height="20" fill="#666666" rx="3"/><text x="80" y="370" font-family="Arial" font-size="12" fill="#FFF" text-anchor="middle">3</text>
    <text x="100" y="370" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">Choose Right Index</text>
    <rect x="70" y="385" width="20" height="20" fill="#666666" rx="3"/><text x="80" y="400" font-family="Arial" font-size="12" fill="#FFF" text-anchor="middle">4</text>
    <text x="100" y="400" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">Compare Execution Plans</text>
    
    <!-- Strategy 4 -->
    <rect x="450" y="270" width="300" height="150" fill="$($Theme.boxBg)" stroke="$($Theme.border)" stroke-width="2" rx="5"/>
    <rect x="450" y="260" width="200" height="20" fill="#E8EFF5" stroke="$($Theme.accent4)" stroke-width="2" rx="3"/>
    <text x="550" y="275" font-family="Arial, sans-serif" font-size="12" font-weight="bold" fill="#000000" text-anchor="middle">#4 Monitoring &amp; Maintenance</text>
    <rect x="470" y="290" width="20" height="18" fill="#666666" rx="3"/><text x="480" y="303" font-family="Arial" font-size="11" fill="#FFF" text-anchor="middle">1</text>
    <text x="500" y="303" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">Monitor Index Usage</text>
    <rect x="470" y="315" width="20" height="18" fill="#666666" rx="3"/><text x="480" y="328" font-family="Arial" font-size="11" fill="#FFF" text-anchor="middle">2</text>
    <text x="500" y="328" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">Monitor Missing Indexes</text>
    <rect x="470" y="340" width="20" height="18" fill="#666666" rx="3"/><text x="480" y="353" font-family="Arial" font-size="11" fill="#FFF" text-anchor="middle">3</text>
    <text x="500" y="353" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">Monitor Duplicate Indexes</text>
    <rect x="470" y="365" width="20" height="18" fill="#666666" rx="3"/><text x="480" y="378" font-family="Arial" font-size="11" fill="#FFF" text-anchor="middle">4</text>
    <text x="500" y="378" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">Update Statistics</text>
    <rect x="470" y="390" width="20" height="18" fill="#666666" rx="3"/><text x="480" y="403" font-family="Arial" font-size="11" fill="#FFF" text-anchor="middle">5</text>
    <text x="500" y="403" font-family="Arial, sans-serif" font-size="12" fill="$($Theme.textPrimary)">Monitor Fragmentation</text>

</svg>
"@

Write-Svg "svg_index_syntax.svg" $svg_index_syntax
Write-Svg "svg_filtered_index.svg" $svg_filtered_index
Write-Svg "svg_indexing_strategy.svg" $svg_indexing_strategy
