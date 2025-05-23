﻿Param (
    # Which user do you want to have send permissions on ESUK Brand All and all sub groups
    [Parameter(Mandatory=$true)]
    $User
)

# Confirm the User 
$User


#Set the user on BUK_BG_BR Everyone UK
Get-DistributionGroup 'BUK_BG_BR Everyone UK' | Set-DistributionGroup -AcceptMessagesOnlyFromSendersOrMembers @{add=$User}
"$user added to BUK_BG_BR Everyone UK"
"$user added to BUK_BG_BR Everyone UK" | Out-File 'BUK Brand All.txt' -Append


#Set the user on BUK Brand All
Get-DistributionGroup 'BUK Brand All' | Set-DistributionGroup -AcceptMessagesOnlyFromSendersOrMembers @{add=$User}
"$user added to BUK Brand All"
"$user added to BUK Brand All" | Out-File 'BUK Brand All.txt' -Append


#Get all the dynamic groups that are members of BUK Brand All
$Groups = Get-DynamicDistributionGroup | Where-Object {$_.Name -like 'BUK Brand*'} | select DisplayName

# And Set the perms
Foreach ($G in $Groups) {
    $NewG = $G.DisplayName
    Set-DynamicDistributionGroup -Identity $NewG -AcceptMessagesOnlyFromSendersOrMembers @{add=$User}
    "$user added to $NewG"
    "$user added to $NewG" | Out-File 'BUK Brand All.txt' -Append
}

Write-Warning "Review the log to make sure this has set on the groups you expect"

