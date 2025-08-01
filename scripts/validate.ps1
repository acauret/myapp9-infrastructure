# validate.ps1
# Validates project configuration

Write-Host "Validating project..." -ForegroundColor Blue

# Check required files
$requiredFiles = @(
    "azure.yaml",
    "infra/main.bicep",
    "infra/main.parameters.json",
    ".github/workflows/azure-deploy.yml"
)

$allValid = $true
foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "[OK] Found: $file" -ForegroundColor Green
    } else {
        Write-Host "[MISSING] $file" -ForegroundColor Yellow
        $allValid = $false
    }
}

# Validate Bicep files
Write-Host ""
Write-Host "Validating Bicep templates..." -ForegroundColor Blue
Get-ChildItem -Path ./infra -Filter *.bicep -Recurse | ForEach-Object {
    Write-Host "Checking: $($_.FullName)"
    $result = az bicep build --file $_.FullName 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Valid" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] Invalid: $result" -ForegroundColor Red
        $allValid = $false
    }
}

if ($allValid) {
    Write-Host ""
    Write-Host "Validation complete!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Validation failed!" -ForegroundColor Red
    exit 1
}
