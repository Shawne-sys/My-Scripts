Param (
    # Which user do you want to have send permissions on Distro group
    [Parameter(Mandatory=$true)]
    $User
)

# Confirm the User 
$User


$Groups = Get-DynamicDistributionGroup | Where-Object {$_.Name -like 'BUK Brand tyrddraig'} | select DisplayName

# And Set the perms
Foreach ($G in $Groups) {
    $NewG = $G.DisplayName
    Set-DynamicDistributionGroup -Identity $NewG -AcceptMessagesOnlyFromSendersOrMembers @{add=$User}
    "$user added to $NewG"
    "$user added to $NewG" | Out-File 'test1.txt' -Append
}

Write-Warning "Review the log to make sure this has set on the groups you expect"	