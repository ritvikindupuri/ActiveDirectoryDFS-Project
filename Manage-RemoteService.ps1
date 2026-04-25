# Manage-RemoteService.ps1
# Purpose: Remotely manage critical Windows services using WinRM. Specifically targets Print Spooler management
# Author: Ritvik Indupuri

$TargetServer = "SRV-PRT-01" # Replace with your server name
$ServiceName = "Spooler"

Write-Host "Initiating remote session to $TargetServer..." -ForegroundColor Cyan

Invoke-Command -ComputerName $TargetServer -ScriptBlock {
    param($Svc)
    $Status = Get-Service -Name $Svc
    Write-Host "Current Status of $Svc: $($Status.Status)"
    
    if ($Status.Status -eq 'Stopped') {
        Write-Host "Restarting $Svc..."
        Start-Service -Name $Svc
    }
} -ArgumentList $ServiceName
