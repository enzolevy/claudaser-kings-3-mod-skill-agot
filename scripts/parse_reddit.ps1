param(
    [string]$JsonPath,
    [string]$Mode = "--brief",
    [string]$SkillDir = ""
)

$json = Get-Content -Path $JsonPath -Raw | ConvertFrom-Json
$posts = $json.data.children | Where-Object {
    $_.data.title -match "(?i)\[(Release|Compatch)\].*Build"
} | Select-Object -First 10

if (-not $posts) {
    Write-Host "No [Release] or [Compatch] posts found on r/CK3AGOT." -ForegroundColor Yellow
    exit
}

# If --check, show installed version
if ($Mode -eq "--check") {
    $agotPath = "C:\Program Files (x86)\Steam\steamapps\workshop\content\1158310\2962333032\descriptor.mod"
    if (Test-Path $agotPath) {
        $ver = (Get-Content $agotPath | Select-String 'version="([^"]+)"').Matches.Groups[1].Value
        Write-Host "Installed AGOT version: $ver" -ForegroundColor Green
    } else {
        Write-Host "Installed AGOT version: unknown (descriptor.mod not found)" -ForegroundColor Yellow
    }
    Write-Host ""
}

foreach ($post in $posts) {
    $d = $post.data
    $date = (Get-Date "1970-01-01T00:00:00Z").AddSeconds($d.created_utc).ToString("yyyy-MM-dd")

    Write-Host $d.title -ForegroundColor Yellow
    Write-Host "  Date: $date | Author: u/$($d.author) | Score: $($d.score)" -ForegroundColor Cyan
    Write-Host "  URL: https://reddit.com$($d.permalink)" -ForegroundColor DarkGray
    Write-Host ""

    if ($Mode -eq "--changelog") {
        $body = $d.selftext
        if (-not $body) { continue }

        $sections = @("***Additions***", "***Changes***", "***Fixes***", "***Removals***")
        foreach ($section in $sections) {
            $idx = $body.IndexOf($section)
            if ($idx -lt 0) { continue }

            # Find end of section (next section or end of text)
            $endIdx = $body.Length
            foreach ($nextSec in $sections) {
                if ($nextSec -eq $section) { continue }
                $nextIdx = $body.IndexOf($nextSec)
                if ($nextIdx -gt $idx -and $nextIdx -lt $endIdx) {
                    $endIdx = $nextIdx
                }
            }

            $content = $body.Substring($idx, $endIdx - $idx).Trim()
            $lines = $content -split "`n"

            # Section header
            $header = $section -replace '\*', ''
            Write-Host "  $header" -ForegroundColor Magenta

            # Content lines (limit to 25)
            $count = 0
            foreach ($line in $lines[1..($lines.Length-1)]) {
                $line = $line.Trim()
                if (-not $line) { continue }
                if ($line.StartsWith("* ")) {
                    Write-Host "    - $($line.Substring(2))"
                } else {
                    Write-Host "    $line"
                }
                $count++
                if ($count -ge 25) {
                    Write-Host "    ... (truncated, see Reddit for full list)" -ForegroundColor DarkGray
                    break
                }
            }
            Write-Host ""
        }
    }

    # In brief mode, only show the latest
    if ($Mode -eq "--brief") { break }
}

if ($Mode -eq "--check") {
    Write-Host ""
    Write-Host "If your installed version is behind, update AGOT via Steam Workshop." -ForegroundColor Yellow
    Write-Host "Then review the changelog for changes that may affect skill documentation." -ForegroundColor Yellow
}
