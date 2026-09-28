$svg_header = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 300">
    <rect width="600" height="300" fill="#1e1e2e" rx="15"/>
    <defs>
        <linearGradient id="left" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="#00ffcc" stop-opacity="0.8"/><stop offset="100%" stop-color="#0066ff" stop-opacity="0.8"/></linearGradient>
        <linearGradient id="right" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="#ff00cc" stop-opacity="0.8"/><stop offset="100%" stop-color="#ff6600" stop-opacity="0.8"/></linearGradient>
        <linearGradient id="inter" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="#ffff00" stop-opacity="0.9"/><stop offset="100%" stop-color="#ff9900" stop-opacity="0.9"/></linearGradient>
    </defs>
"@

function Write-SVG {
    param($File, $Title, $Body)
    $content = $svg_header + "<text x='300' y='40' font-family='Arial' font-size='24' font-weight='bold' fill='#00ffcc' text-anchor='middle'>$Title</text><g transform='translate(0, 50)'>$Body</g></svg>"
    Set-Content -Path $File -Value $content -Encoding UTF8
    Write-Host "Generated $File"
}

# 1. Combine Rows vs Columns
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_rows_vs_cols.svg" "Rows vs Columns (SET vs JOIN)" "<rect x='150' y='20' width='80' height='50' fill='url(#left)'/><rect x='150' y='75' width='80' height='50' fill='url(#right)'/><text x='190' y='150' fill='#fff' text-anchor='middle'>SET (Longer)</text><rect x='350' y='40' width='80' height='80' fill='url(#left)'/><rect x='435' y='40' width='80' height='80' fill='url(#right)'/><text x='425' y='150' fill='#fff' text-anchor='middle'>JOIN (Wider)</text>"

# 2. Types of Joins
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_joins_types.svg" "Types of Joins Overview" "<circle cx='150' cy='100' r='40' fill='url(#left)'/><circle cx='210' cy='100' r='40' fill='url(#right)'/><circle cx='270' cy='100' r='40' fill='url(#inter)'/><circle cx='390' cy='100' r='40' fill='url(#left)'/><circle cx='450' cy='100' r='40' fill='url(#right)'/><text x='300' y='180' fill='#a6accd' text-anchor='middle'>Inner | Left | Right | Full | Anti | Cross</text>"

# 3. Inner Join
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_inner_join.svg" "INNER JOIN Concept" "<circle cx='250' cy='100' r='70' fill='none' stroke='#00ffcc' stroke-width='3'/><circle cx='350' cy='100' r='70' fill='none' stroke='#ff00cc' stroke-width='3'/><path d='M 300,50 A 70,70 0 0,0 300,150 A 70,70 0 0,0 300,50' fill='url(#inter)'/><text x='300' y='200' fill='#fff' text-anchor='middle'>Only Matching Data</text>"

# 4. Left Join
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_left_join.svg" "LEFT JOIN Concept" "<circle cx='250' cy='100' r='70' fill='url(#left)'/><circle cx='350' cy='100' r='70' fill='none' stroke='#ff00cc' stroke-width='3'/><path d='M 300,50 A 70,70 0 0,0 300,150 A 70,70 0 0,0 300,50' fill='url(#inter)'/><text x='300' y='200' fill='#fff' text-anchor='middle'>All Left + Matching Right</text>"

# 5. Right Join
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_right_join.svg" "RIGHT JOIN Concept" "<circle cx='250' cy='100' r='70' fill='none' stroke='#00ffcc' stroke-width='3'/><circle cx='350' cy='100' r='70' fill='url(#right)'/><path d='M 300,50 A 70,70 0 0,0 300,150 A 70,70 0 0,0 300,50' fill='url(#inter)'/><text x='300' y='200' fill='#fff' text-anchor='middle'>All Right + Matching Left</text>"

# 6. Alternative to Right Join
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_right_alt.svg" "Alternative to Right Join" "<text x='300' y='100' font-size='18' fill='#ff9900' text-anchor='middle'>Pro Tip: Just swap tables and use LEFT JOIN</text><text x='300' y='140' font-size='16' fill='#a6accd' text-anchor='middle'>FROM TableB LEFT JOIN TableA</text>"

# 7. Full Join
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_full_join.svg" "FULL OUTER JOIN Concept" "<circle cx='250' cy='100' r='70' fill='url(#left)'/><circle cx='350' cy='100' r='70' fill='url(#right)'/><path d='M 300,50 A 70,70 0 0,0 300,150 A 70,70 0 0,0 300,50' fill='url(#inter)'/><text x='300' y='200' fill='#fff' text-anchor='middle'>Everything (Match + Unmatch)</text>"

# 8. Data Enrichment
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_data_enrich.svg" "Data Enrichment" "<rect x='200' y='50' width='80' height='100' fill='url(#left)'/><path d='M 290,100 L 330,100' stroke='#a6accd' stroke-width='3'/><rect x='340' y='50' width='80' height='100' fill='url(#right)'/><text x='300' y='180' fill='#fff' text-anchor='middle'>Joining external Reference Tables</text>"

# 9. Left Anti Join
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_left_anti.svg" "LEFT ANTI JOIN Concept" "<path d='M 250,30 A 70,70 0 1,0 250,170 A 70,70 0 0,1 300,150 A 70,70 0 0,1 300,50 A 70,70 0 0,1 250,30' fill='url(#left)'/><circle cx='250' cy='100' r='70' fill='none' stroke='#00ffcc' stroke-width='3'/><circle cx='350' cy='100' r='70' fill='none' stroke='#ff00cc' stroke-width='3'/><text x='300' y='200' fill='#fff' text-anchor='middle'>Exclusive Left Data</text>"

# 10. Left Anti Execution
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_left_anti_exec.svg" "LEFT ANTI Execution" "<text x='300' y='100' font-size='20' fill='#ff9900' text-anchor='middle'>LEFT JOIN ... WHERE RightTable.id IS NULL</text>"

# 11. Right Anti Join
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_right_anti.svg" "RIGHT ANTI JOIN Concept" "<circle cx='250' cy='100' r='70' fill='none' stroke='#00ffcc' stroke-width='3'/><circle cx='350' cy='100' r='70' fill='none' stroke='#ff00cc' stroke-width='3'/><path d='M 350,30 A 70,70 0 0,0 300,50 A 70,70 0 0,0 300,150 A 70,70 0 0,0 350,170 A 70,70 0 1,0 350,30' fill='url(#right)'/><text x='300' y='200' fill='#fff' text-anchor='middle'>Exclusive Right Data</text>"

# 12. Full Anti Join
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_full_anti.svg" "FULL ANTI JOIN Concept" "<path d='M 250,30 A 70,70 0 1,0 250,170 A 70,70 0 0,1 300,150 A 70,70 0 0,1 300,50 A 70,70 0 0,1 250,30' fill='url(#left)'/><path d='M 350,30 A 70,70 0 0,0 300,50 A 70,70 0 0,0 300,150 A 70,70 0 0,0 350,170 A 70,70 0 1,0 350,30' fill='url(#right)'/><circle cx='250' cy='100' r='70' fill='none' stroke='#00ffcc' stroke-width='3'/><circle cx='350' cy='100' r='70' fill='none' stroke='#ff00cc' stroke-width='3'/><text x='300' y='200' fill='#fff' text-anchor='middle'>Excludes Intersection (Outer Only)</text>"

# 13. Cross Join
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_cross_join.svg" "CROSS JOIN Concept" "<rect x='150' y='50' width='50' height='100' fill='none' stroke='#00ffcc'/><rect x='400' y='50' width='50' height='100' fill='none' stroke='#ff00cc'/><line x1='200' y1='75' x2='400' y2='75' stroke='#ffff00' opacity='0.5'/><line x1='200' y1='75' x2='400' y2='125' stroke='#ffff00' opacity='0.5'/><line x1='200' y1='125' x2='400' y2='75' stroke='#ffff00' opacity='0.5'/><line x1='200' y1='125' x2='400' y2='125' stroke='#ffff00' opacity='0.5'/><text x='300' y='200' fill='#fff' text-anchor='middle'>Cartesian Product (Every Row * Every Row)</text>"

# 14. Decision Tree
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_decision_tree.svg" "Decision Tree (How to Choose)" "<text x='300' y='60' fill='#00ffcc' font-size='18' text-anchor='middle'>Matching Only = INNER</text><text x='300' y='100' fill='#ff9900' font-size='18' text-anchor='middle'>Everything = FULL</text><text x='300' y='140' fill='#ff00cc' font-size='18' text-anchor='middle'>All Left = LEFT</text><text x='300' y='180' fill='#fff' font-size='18' text-anchor='middle'>Unmatched Left = LEFT ANTI</text>"

# 15. Multi-Table Concept
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_multi_table.svg" "Multi-Table Architecture" "<rect x='100' y='80' width='80' height='80' fill='url(#left)'/><path d='M 180,120 L 250,70' stroke='#a6accd'/><rect x='250' y='40' width='80' height='40' fill='url(#right)'/><path d='M 180,120 L 250,120' stroke='#a6accd'/><rect x='250' y='100' width='80' height='40' fill='url(#right)'/><path d='M 180,120 L 250,170' stroke='#a6accd'/><rect x='250' y='160' width='80' height='40' fill='url(#right)'/><text x='300' y='230' fill='#fff' text-anchor='middle'>Master Table connects to Tables B, C, D</text>"

# 16. Multi-Table Schema
Write-SVG "d:\IMP\SQL\mysql\mysql_basic\svg_schema.svg" "SalesDB Schema" "<rect x='150' y='50' width='80' height='100' fill='#1e1e2e' stroke='#00ffcc'/><text x='190' y='70' fill='#fff' font-size='12' text-anchor='middle'>ORDERS</text><rect x='350' y='20' width='80' height='50' fill='#1e1e2e' stroke='#ff00cc'/><text x='390' y='40' fill='#fff' font-size='12' text-anchor='middle'>CUSTOMERS</text><rect x='350' y='80' width='80' height='50' fill='#1e1e2e' stroke='#ffff00'/><text x='390' y='100' fill='#fff' font-size='12' text-anchor='middle'>PRODUCTS</text><path d='M 230,100 L 350,45' stroke='#a6accd'/><path d='M 230,100 L 350,105' stroke='#a6accd'/>"
