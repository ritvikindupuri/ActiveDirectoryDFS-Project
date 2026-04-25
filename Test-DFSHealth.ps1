# Test-DFSHealth.ps1
# Purpose: Checks the health of the DFS Namespace and ensures replication is active across targets.

$Namespace = "\\CORP.LOCAL\PublicData" # Replace with your domain

Write-Host "Auditing DFS Namespace: $Namespace" -ForegroundColor Cyan

# Test Namespace Accessibility
if (Test-Path $Namespace) {
    Write-Host "DFS Namespace is reachable." -ForegroundColor Green
} else {
    Write-Error "DFS Namespace is OFFLINE."
}

# Verify Replication Health (Requires DFS Management Tools)
Get-DfsrBacklog -GroupName "PublicReplication" -SourceComputerName "DC01" -DestinationComputerName "SRV-FILE-02"
