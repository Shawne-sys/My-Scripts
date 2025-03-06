Param (
    # Which user do you want to have send permissions on ESUK Brand All and all sub groups
    [Parameter(Mandatory=$true)]
    $User
)

# Confirm the User 
$User


#Set the user on ESUK_ESG_ESI Everyone UK
Get-DistributionGroup 'ESUK_ESG_ESI Everyone UK' | Remove-DistributionGroup @{add=$User}
"$user added to ESUK_ESG_ESI Everyone UK"
"$user added to ESUK_ESG_ESI Everyone UK" | Out-File 'ESUK Brand All.txt' -Append


#Set the user on ESUK Brand All
Get-DistributionGroup 'ESUK Brand All' | Remove-DistributionGroup @{add=$User}
"$user added to ESUK Brand All"
"$user added to ESUK Brand All" | Out-File 'ESUK Brand All.txt' -Append

#Set the user on ESG UK Staff Shepherds Building
Get-DistributionGroup 'ESG UK Staff Shepherds Building' | Remove-DistributionGroup @{add=$User}
"$user added to ESG UK Staff Shepherds Building"
"$user added to ESG UK Staff Shepherds Building" | Out-File 'ESUK Brand All.txt' -Append


#Get all the dynamic groups that are members of ESUK Brand All
$Groups = Get-DynamicDistributionGroup | Where-Object {$_.Name -like 'ESUK Brand*'} | select DisplayName

# And Set the perms
Foreach ($G in $Groups) {
    $NewG = $G.DisplayName
    Remove-DynamicDistributionGroup -Identity $NewG @{add=$User}
    "$user added to $NewG"
    "$user added to $NewG" | Out-File 'ESUK Brand All.txt' -Append
}

Write-Warning "Review the log to make sure this has set on the groups you expect"

