# setup-checklist.ps1
# Checks prerequisites and setup status

Write-Host "Azure Infrastructure Setup Checklist" -ForegroundColor Blue
Write-Host "====================================" -ForegroundColor Blue
Write-Host ""

Write-Host "Prerequisites:" -ForegroundColor Yellow
Write-Host "-------------" -ForegroundColor Yellow

# Check Azure CLI
try {
    $azVersion = az --version 2>$null | Select-String "azure-cli" | Select-Object -First 1
    Write-Host "[OK] Azure CLI installed: $azVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Azure CLI not found" -ForegroundColor Red
}

# Check Azure Developer CLI
try {
    $azdVersion = azd version 2>$null
    Write-Host "[OK] Azure Developer CLI installed: $azdVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Azure Developer CLI not found" -ForegroundColor Red
}

# Check Git
try {
    $gitVersion = git --version 2>$null
    Write-Host "[OK] Git installed: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Git not found" -ForegroundColor Red
}

# Check GitHub CLI
try {
    $ghVersion = gh --version 2>$null | Select-Object -First 1
    Write-Host "[OK] GitHub CLI installed: $ghVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] GitHub CLI not found" -ForegroundColor Red
}

Write-Host ""
Write-Host "Azure Setup:" -ForegroundColor Yellow
Write-Host "-----------" -ForegroundColor Yellow

# Check Azure login
try {
    $account = az account show 2>$null | ConvertFrom-Json
    Write-Host "[OK] Logged into Azure" -ForegroundColor Green
    Write-Host "     Subscription: $($account.name)" -ForegroundColor Gray
} catch {
    Write-Host "[ERROR] Not logged into Azure (run: az login)" -ForegroundColor Red
}

Write-Host ""
Write-Host "GitHub Setup:" -ForegroundColor Yellow
Write-Host "------------" -ForegroundColor Yellow

# Check GitHub login
try {
    gh auth status 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Logged into GitHub" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] Not logged into GitHub (run: gh auth login)" -ForegroundColor Red
    }
} catch {
    Write-Host "[ERROR] GitHub CLI not available" -ForegroundColor Red
}

Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "----------" -ForegroundColor Yellow
Write-Host "1. Create Service Principal (see README.md)" -ForegroundColor White
Write-Host "2. Configure GitHub Secrets" -ForegroundColor White
Write-Host "3. Push to GitHub repository" -ForegroundColor White
Write-Host "4. Create infrastructure issues" -ForegroundColor White
Write-Host "5. Start deploying!" -ForegroundColor White
