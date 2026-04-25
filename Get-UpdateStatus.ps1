# Get-UpdateStatus.ps1
# Purpose: Pulls a report from WSUS to identify machines that are missing critical security patches.

[void][reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
$WSUS = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer()

$ComputerScope = New-Object Microsoft.UpdateServices.Administration.ComputerTargetScope
$UpdateScope = New-Object Microsoft.UpdateServices.Administration.UpdateScope

Write-Host "Querying WSUS for non-compliant machines..." -ForegroundColor Yellow

$WSUS.GetSummariesPerComputerTarget($UpdateScope, $ComputerScope) | Select-Object -Property `
    @{L='Computer';E={($WSUS.GetComputerTarget($_.ComputerTargetId)).FullDomainName}},
    @{L='NeededUpdates';E={$_.NeededCount}} | Where-Object {$_.NeededUpdates -gt 0}
