# Audit-ADGroups.ps1
# Purpose: Audit group membership to ensure Least Privilege compliance. Specifically 
# audits the Print Operators group to ensure only authorized "Printer Admin" accounts have delegated access.

$SecurityGroup = "Print Operators"
$ExpectedAdmins = @("SVC_PrinterAdmin") # Your delegated account

$CurrentMembers = Get-ADGroupMember -Identity $SecurityGroup | Select-Object -ExpandProperty SamAccountName

Write-Host "Checking $SecurityGroup membership against compliance list..." -ForegroundColor Yellow

foreach ($Member in $CurrentMembers) {
    if ($ExpectedAdmins -notcontains $Member) {
        Write-Warning "UNAUTHORIZED USER DETECTED: $Member"
    } else {
        Write-Host "Authorized: $Member" -ForegroundColor Green
    }
}
