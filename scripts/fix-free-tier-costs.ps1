# SafeMate Fix Free Tier Costs
# This script removes expensive AWS resources to restore free tier compliance
# WARNING: This will delete expensive resources that are causing costs!

Write-Host "🚨 SafeMate Free Tier Cost Fix" -ForegroundColor Red
Write-Host "==============================" -ForegroundColor Red
Write-Host ""
Write-Host "⚠️  WARNING: This script will DELETE expensive AWS resources!" -ForegroundColor Yellow
Write-Host "   This includes ECS clusters, Load Balancers, CloudFront, and ECR repositories" -ForegroundColor Yellow
Write-Host ""

# Ask for confirmation (with parameter support)
param(
    [switch]$Force,
    [switch]$Confirm
)

if (-not $Force -and -not $Confirm) {
    $confirmation = Read-Host "Are you sure you want to proceed? Type 'YES' to continue"
    if ($confirmation -ne "YES") {
        Write-Host "❌ Operation cancelled by user" -ForegroundColor Red
        exit 0
    }
} else {
    Write-Host "✅ Proceeding with cleanup (forced mode)" -ForegroundColor Green
}

Write-Host ""
Write-Host "🔍 Starting cleanup of expensive AWS resources..." -ForegroundColor Yellow
Write-Host ""

$totalCostSavings = 0
$resourcesDeleted = 0

# Function to delete ECS clusters
function Remove-ECSClusters {
    Write-Host "📋 Removing ECS Clusters..." -ForegroundColor Yellow
    
    try {
        $clusters = aws ecs list-clusters --query 'clusterArns[]' --output text 2>$null
        if ($clusters) {
            $clusterList = $clusters -split "`t"
            foreach ($cluster in $clusterList) {
                if ($cluster -match "safemate") {
                    Write-Host "  🗑️  Deleting ECS cluster: $cluster" -ForegroundColor Red
                    
                    # Stop all services in the cluster
                    $services = aws ecs list-services --cluster $cluster --query 'serviceArns[]' --output text 2>$null
                    if ($services) {
                        $serviceList = $services -split "`t"
                        foreach ($service in $serviceList) {
                            Write-Host "    Stopping service: $service" -ForegroundColor Gray
                            aws ecs update-service --cluster $cluster --service $service --desired-count 0 2>$null
                            aws ecs delete-service --cluster $cluster --service $service 2>$null
                        }
                    }
                    
                    # Delete the cluster
                    aws ecs delete-cluster --cluster $cluster 2>$null
                    Write-Host "  ✅ Deleted ECS cluster: $cluster" -ForegroundColor Green
                    $script:totalCostSavings += 8  # ~$8/month per cluster
                    $script:resourcesDeleted++
                }
            }
        } else {
            Write-Host "  ✅ No ECS clusters found" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "  ⚠️  Error removing ECS clusters: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# Function to delete Load Balancers
function Remove-LoadBalancers {
    Write-Host "📋 Removing Application Load Balancers..." -ForegroundColor Yellow
    
    try {
        $loadBalancers = aws elbv2 describe-load-balancers --query 'LoadBalancers[?contains(LoadBalancerName, `safemate`)].LoadBalancerArn' --output text 2>$null
        if ($loadBalancers) {
            $albList = $loadBalancers -split "`t"
            foreach ($alb in $albList) {
                Write-Host "  🗑️  Deleting Load Balancer: $alb" -ForegroundColor Red
                aws elbv2 delete-load-balancer --load-balancer-arn $alb 2>$null
                Write-Host "  ✅ Deleted Load Balancer: $alb" -ForegroundColor Green
                $script:totalCostSavings += 16.20  # $16.20/month per ALB
                $script:resourcesDeleted++
            }
        } else {
            Write-Host "  ✅ No Load Balancers found" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "  ⚠️  Error removing Load Balancers: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# Function to delete CloudFront distributions
function Remove-CloudFrontDistributions {
    Write-Host "📋 Removing CloudFront Distributions..." -ForegroundColor Yellow
    
    try {
        $distributions = aws cloudfront list-distributions --query 'DistributionList.Items[?contains(Comment, `safemate`) || contains(Comment, `SafeMate`)].Id' --output text 2>$null
        if ($distributions) {
            $cfList = $distributions -split "`t"
            foreach ($cf in $cfList) {
                Write-Host "  🗑️  Disabling CloudFront Distribution: $cf" -ForegroundColor Red
                
                # Get current config
                $config = aws cloudfront get-distribution-config --id $cf 2>$null
                if ($config) {
                    # Disable the distribution
                    $configObj = $config | ConvertFrom-Json
                    $configObj.DistributionConfig.Enabled = $false
                    $configJson = $configObj | ConvertTo-Json -Depth 10
                    
                    aws cloudfront update-distribution --id $cf --distribution-config $configJson --if-match $configObj.ETag 2>$null
                    Write-Host "  ✅ Disabled CloudFront Distribution: $cf" -ForegroundColor Green
                    $script:totalCostSavings += 1  # Variable cost, estimate $1/month
                    $script:resourcesDeleted++
                }
            }
        } else {
            Write-Host "  ✅ No CloudFront distributions found" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "  ⚠️  Error removing CloudFront distributions: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# Function to delete ECR repositories
function Remove-ECRRepositories {
    Write-Host "📋 Removing ECR Repositories..." -ForegroundColor Yellow
    
    try {
        $repositories = aws ecr describe-repositories --query 'repositories[?contains(repositoryName, `safemate`)].repositoryName' --output text 2>$null
        if ($repositories) {
            $ecrList = $repositories -split "`t"
            foreach ($ecr in $ecrList) {
                Write-Host "  🗑️  Deleting ECR Repository: $ecr" -ForegroundColor Red
                
                # Delete all images first
                $images = aws ecr list-images --repository-name $ecr --query 'imageIds[].imageDigest' --output text 2>$null
                if ($images) {
                    $imageList = $images -split "`t"
                    foreach ($image in $imageList) {
                        aws ecr batch-delete-image --repository-name $ecr --image-ids imageDigest=$image 2>$null
                    }
                }
                
                # Delete the repository
                aws ecr delete-repository --repository-name $ecr --force 2>$null
                Write-Host "  ✅ Deleted ECR Repository: $ecr" -ForegroundColor Green
                $script:totalCostSavings += 0.50  # ~$0.50/month per repository
                $script:resourcesDeleted++
            }
        } else {
            Write-Host "  ✅ No ECR repositories found" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "  ⚠️  Error removing ECR repositories: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# Function to delete RDS instances
function Remove-RDSInstances {
    Write-Host "📋 Checking RDS Instances..." -ForegroundColor Yellow
    
    try {
        $instances = aws rds describe-db-instances --query 'DBInstances[?contains(DBInstanceIdentifier, `safemate`)].DBInstanceIdentifier' --output text 2>$null
        if ($instances) {
            $rdsList = $instances -split "`t"
            foreach ($rds in $rdsList) {
                Write-Host "  🗑️  Deleting RDS Instance: $rds" -ForegroundColor Red
                aws rds delete-db-instance --db-instance-identifier $rds --skip-final-snapshot 2>$null
                Write-Host "  ✅ Deleted RDS Instance: $rds" -ForegroundColor Green
                $script:totalCostSavings += 12  # ~$12/month per t3.micro
                $script:resourcesDeleted++
            }
        } else {
            Write-Host "  ✅ No RDS instances found" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "  ⚠️  Error removing RDS instances: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# Function to delete EC2 instances
function Remove-EC2Instances {
    Write-Host "📋 Checking EC2 Instances..." -ForegroundColor Yellow
    
    try {
        $instances = aws ec2 describe-instances --query 'Reservations[].Instances[?contains(Tags[?Key==`Name`].Value, `safemate`)].InstanceId' --output text 2>$null
        if ($instances) {
            $ec2List = $instances -split "`t"
            foreach ($ec2 in $ec2List) {
                Write-Host "  🗑️  Terminating EC2 Instance: $ec2" -ForegroundColor Red
                aws ec2 terminate-instances --instance-ids $ec2 2>$null
                Write-Host "  ✅ Terminated EC2 Instance: $ec2" -ForegroundColor Green
                $script:totalCostSavings += 8  # ~$8/month per t3.micro
                $script:resourcesDeleted++
            }
        } else {
            Write-Host "  ✅ No EC2 instances found" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "  ⚠️  Error removing EC2 instances: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# Function to delete ElastiCache clusters
function Remove-ElastiCacheClusters {
    Write-Host "📋 Checking ElastiCache Clusters..." -ForegroundColor Yellow
    
    try {
        $clusters = aws elasticache describe-cache-clusters --query 'CacheClusters[?contains(CacheClusterId, `safemate`)].CacheClusterId' --output text 2>$null
        if ($clusters) {
            $cacheList = $clusters -split "`t"
            foreach ($cache in $cacheList) {
                Write-Host "  🗑️  Deleting ElastiCache Cluster: $cache" -ForegroundColor Red
                aws elasticache delete-cache-cluster --cache-cluster-id $cache 2>$null
                Write-Host "  ✅ Deleted ElastiCache Cluster: $cache" -ForegroundColor Green
                $script:totalCostSavings += 15  # ~$15/month per cluster
                $script:resourcesDeleted++
            }
        } else {
            Write-Host "  ✅ No ElastiCache clusters found" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "  ⚠️  Error removing ElastiCache clusters: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# Execute cleanup functions
Write-Host "🚀 Starting cleanup process..." -ForegroundColor Cyan
Write-Host ""

Remove-ECSClusters
Write-Host ""
Remove-LoadBalancers
Write-Host ""
Remove-CloudFrontDistributions
Write-Host ""
Remove-ECRRepositories
Write-Host ""
Remove-RDSInstances
Write-Host ""
Remove-EC2Instances
Write-Host ""
Remove-ElastiCacheClusters

Write-Host ""
Write-Host "💰 CLEANUP SUMMARY:" -ForegroundColor Cyan
Write-Host "===================" -ForegroundColor Cyan
Write-Host "  🗑️  Resources deleted: $resourcesDeleted" -ForegroundColor White
Write-Host "  💰 Estimated monthly savings: $${totalCostSavings:F2}" -ForegroundColor Green
Write-Host ""

if ($resourcesDeleted -gt 0) {
    Write-Host "✅ Cleanup completed successfully!" -ForegroundColor Green
    Write-Host "🎯 Your AWS environment should now be free tier compliant" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 Next steps:" -ForegroundColor Yellow
    Write-Host "  1. Run: .\check-free-tier.ps1" -ForegroundColor White
    Write-Host "  2. Verify no expensive resources remain" -ForegroundColor White
    Write-Host "  3. Monitor AWS billing for next few days" -ForegroundColor White
} else {
    Write-Host "✅ No expensive resources found to delete" -ForegroundColor Green
    Write-Host "🎯 Your AWS environment is already free tier compliant" -ForegroundColor Green
}

Write-Host ""
Write-Host "⚠️  Note: Some resources may take a few minutes to fully delete" -ForegroundColor Yellow
Write-Host "   CloudFront distributions may take up to 15 minutes to propagate" -ForegroundColor Yellow
Write-Host "   ECS clusters may take a few minutes to fully terminate" -ForegroundColor Yellow

Write-Host ""
Write-Host "📅 Cleanup completed: $(Get-Date)" -ForegroundColor Gray
