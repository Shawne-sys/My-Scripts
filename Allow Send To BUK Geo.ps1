Param (
    # Which user do you want to have send permissions on BUK Geo groups
    [Parameter(Mandatory=$true)]
    $User
)

# Confirm the User
$User


# Set the user on BUK_BG_BR_GeoShepherdsBush
Get-DistributionGroup 'BUK_BG_BR_GeoShepherdsBush@banijayuk.com' | Set-DistributionGroup -AcceptMessagesOnlyFromSendersOrMembers @{add=$User}
"$user added to BUK_BG_BR_Geo Shepherds Bush"
"$user added to BUK_BG_BR_Geo Shepherds Bush" | Out-File 'BUK Geo.txt' -Append

# Get all the dynamic groups that are members of BUK Brand All
$Groups = Get-DynamicDistributionGroup | Where-Object {$_.Name -like 'BUK Geo*'} | select DisplayName

# And Set the perms
Foreach ($G in $Groups) {
    $NewG = $G.DisplayName
    Set-DynamicDistributionGroup -Identity $NewG -AcceptMessagesOnlyFromSendersOrMembers @{add=$User}
    "$user added to $NewG"
    "$user added to $NewG" | Out-File 'BUK Geo.txt' -Append
}

Write-Warning "Review the log to make sure this has set on the groups you expect"

