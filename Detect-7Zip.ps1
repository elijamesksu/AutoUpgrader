# Step 1: Get latest version from 7-Zip.org
try {
    $html = Invoke-WebRequest "https://www.7-zip.org/download.html" -UseBasicParsing
    if ($html.Content -match 'Download 7-Zip ([\d\.]+)') {
        $latest = $matches[1]
    } else {
        Write-Host "Could not extract version from HTML."
        exit 1
    }
} catch {
    Write-Host "Failed to fetch latest version."
    exit 1
}

# Step 2: Check installed version from registry
$regPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)

$found = $false

foreach ($path in $regPaths) {
    $installed = Get-ItemProperty -Path "$path\*" -ErrorAction SilentlyContinue | Where-Object {
        $_.DisplayName -like "7-Zip*" -and $_.DisplayVersion -like "$latest*"
    }

    if ($installed) {
        Write-Host "7-Zip $latest is installed."
        $found = $true
        break
    }
}

# Step 3: Exit codes for Intune
if ($found) {
    exit 0  # App is present and up to date
} else {
    Write-Host "7-Zip is missing or outdated."
    exit 1  # Trigger install
}
