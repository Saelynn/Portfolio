
$files = @("D5 Bracket 1.jpg","D5 Bracket 2.jpg","D5 Bracket 3.jpg","D5 Bracket 4.jpg","D5 Bracket 5.jpg")
$imgs = @()
foreach ($f in $files) {
    $b64 = "data:image/jpeg;base64," + [Convert]::ToBase64String([System.IO.File]::ReadAllBytes($f))
    $imgs += $b64
    Write-Host "Encoded: $f ($([math]::Round($b64.Length/1KB,1)) KB)"
}

$html = [System.IO.File]::ReadAllText("index.html")

# Find the D5 gallery section
$d5Start = $html.IndexOf('id="d5-row"')
$d5End   = $html.IndexOf('id="gpu-support-row"')
$d5Section = $html.Substring($d5Start, $d5End - $d5Start)

# Get current thumb count to determine starting index
$thumbMatches = [regex]::Matches($d5Section, '<img class="proj-thumb')
$startIdx = $thumbMatches.Count
Write-Host "Existing thumbs: $startIdx — new ones start at index $startIdx"

# Find the thumbstrip closing </div> in the d5 section
$stripStart = $html.IndexOf('<div class="proj-thumbstrip">', $d5Start)
$stripClose = $html.IndexOf('</div>', $stripStart + 100)

# Build new thumb tags
$newThumbs = ""
for ($i = 0; $i -lt $imgs.Count; $i++) {
    $idx = $startIdx + $i
    $newThumbs += "`n        <img class=`"proj-thumb`" onclick=`"swap('d',$idx)`" src=`"$($imgs[$i])`" alt=`"D5 Bracket $($i+1)`">"
}

# Insert before closing </div>
$html = $html.Substring(0, $stripClose) + $newThumbs + "`n      " + $html.Substring($stripClose)

# Update dots — find current dot count then rebuild
$dotsStart = $html.IndexOf('id="d-dots"')
$dotsEnd   = $html.IndexOf('</div>', $dotsStart) + 6
$totalThumbs = $startIdx + $imgs.Count

$newDots = '<div class="gallery-dots" id="d-dots">'
for ($i = 0; $i -lt $totalThumbs; $i++) {
    $active = if ($i -eq 0) { ' active' } else { '' }
    $newDots += "<div class=`"gallery-dot$active`" onclick=`"swap('d',$i)`"></div>"
}
$newDots += '</div>'

$oldDots = $html.Substring($dotsStart, $dotsEnd - $dotsStart)
$html = $html.Replace($oldDots, $newDots)

[System.IO.File]::WriteAllBytes("index.html", [System.Text.Encoding]::UTF8.GetBytes($html))
Write-Host "Done. File: $([math]::Round($html.Length/1MB,2)) MB"

# Verify
$check = [System.Text.Encoding]::UTF8.GetString([System.IO.File]::ReadAllBytes("index.html"))
$d5S = $check.IndexOf('id="d5-row"')
$d5E = $check.IndexOf('id="gpu-support-row"')
$sec = $check.Substring($d5S, $d5E - $d5S)
$tc = ([regex]::Matches($sec, 'proj-thumb')).Count
$dc = ([regex]::Matches($sec, 'gallery-dot')).Count
Write-Host "Thumbs: $tc | Dots: $dc"
