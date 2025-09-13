# SafeMate Disable Unused CloudFront Distributions
# This script disables unused CloudFront distributions to save costs

Write-Host "🌐 SafeMate CloudFront Cleanup" -ForegroundColor Cyan
Write-Host "===============================" -ForegroundColor Cyan
Write-Host ""

# Keep the active distribution (E5BZANX3APBRF - d1f6ux6bexgm7o.cloudfront.net)
$activeDistribution = "E5BZANX3APBRF"
$distributionsToDisable = @("E1VFEQUX7Z5VC3", "E2AHA6GLI806XF", "EUOZQHWBERBOR")

Write-Host "✅ Keeping active distribution: $activeDistribution" -ForegroundColor Green
Write-Host "🗑️  Disabling unused distributions: $($distributionsToDisable -join ', ')" -ForegroundColor Yellow
Write-Host ""

foreach ($distId in $distributionsToDisable) {
    try {
        Write-Host "📋 Processing distribution: $distId" -ForegroundColor Yellow
        
        # Get current configuration
        $config = aws cloudfront get-distribution-config --id $distId --output json 2>$null
        if (-not $config) {
            Write-Host "  ⚠️  Could not retrieve config for $distId" -ForegroundColor Yellow
            continue
        }
        
        $configObj = $config | ConvertFrom-Json
        $etag = $configObj.ETag
        
        # Disable the distribution
        $configObj.DistributionConfig.Enabled = $false
        $configJson = $configObj.DistributionConfig | ConvertTo-Json -Depth 10
        
        # Update the distribution
        aws cloudfront update-distribution --id $distId --distribution-config $configJson --if-match $etag 2>$null
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  ✅ Disabled distribution: $distId" -ForegroundColor Green
        } else {
            Write-Host "  ❌ Failed to disable distribution: $distId" -ForegroundColor Red
        }
        
    } catch {
        Write-Host "  ❌ Error processing $distId : $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "💰 CLOUDFRONT CLEANUP SUMMARY:" -ForegroundColor Cyan
Write-Host "===============================" -ForegroundColor Cyan
Write-Host "  ✅ Active distribution preserved: $activeDistribution" -ForegroundColor Green
Write-Host "  🗑️  Unused distributions disabled: $($distributionsToDisable.Count)" -ForegroundColor Yellow
Write-Host "  💰 Estimated monthly savings: ~$3-5 (variable based on traffic)" -ForegroundColor Green
Write-Host ""
Write-Host "⚠️  Note: CloudFront changes may take 15-20 minutes to propagate globally" -ForegroundColor Yellow
Write-Host "📅 Cleanup completed: $(Get-Date)" -ForegroundColor Gray
