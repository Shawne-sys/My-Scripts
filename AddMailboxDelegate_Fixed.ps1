Param (
    # Mailbox owner
    [Parameter(Mandatory=$true)]
    $MailboxOwner,

    # Delegate user
    [Parameter(Mandatory=$true)]
    $DelegateUser
)

# Prompt for access level
Write-Host "Select the permission level for the delegate:"
Write-Host "1. Reviewer - Read-only access"
Write-Host "2. Author - Read and create items"
Write-Host "3. Editor - Full access (Read, create, modify)"
Write-Host "4. None - Remove access"

$AccessLevelChoice = Read-Host "Enter the number corresponding to the access level (1-4)"

# Map choice to permission type
switch ($AccessLevelChoice) {
    1 { $AccessLevel = "Reviewer" }
    2 { $AccessLevel = "Author" }
    3 { $AccessLevel = "Editor" }
    4 { $AccessLevel = "None" }
    default { Write-Host "Invalid selection. Exiting..."; exit }
}

# Construct log entry
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$LogFile = "MailboxDelegateLog.txt"
$LogEntry = "$Timestamp - Granting '$AccessLevel' access to '$DelegateUser' on '$MailboxOwner' mailbox."

# Calendar Identity
$CalendarIdentity = "${MailboxOwner}:\Calendar"

# Check if the delegate already has an entry
$ExistingPermission = Get-MailboxFolderPermission -Identity $CalendarIdentity -User $DelegateUser -ErrorAction SilentlyContinue

# Apply permissions
if ($AccessLevel -eq "None") {
    if ($ExistingPermission) {
        Remove-MailboxFolderPermission -Identity $CalendarIdentity -User $DelegateUser -Confirm:$false
        Write-Host "$DelegateUser removed from $MailboxOwner's mailbox."
        $LogEntry = "$Timestamp - Removed access for '$DelegateUser' from '$MailboxOwner' mailbox."
    } else {
        Write-Host "No existing permission entry found for $DelegateUser. No action taken."
    }
} else {
    if ($ExistingPermission) {
        # Modify existing permission
        Set-MailboxFolderPermission -Identity $CalendarIdentity -User $DelegateUser -AccessRights $AccessLevel
        Write-Host "Updated $DelegateUser's access to '$AccessLevel' on $MailboxOwner's mailbox."
    } else {
        # Add new permission entry
        Add-MailboxFolderPermission -Identity $CalendarIdentity -User $DelegateUser -AccessRights $AccessLevel
        Write-Host "Granted '$AccessLevel' access to $DelegateUser on $MailboxOwner's mailbox."
    }
}

# Log the change
$LogEntry | Out-File $LogFile -Append
Write-Host "Changes logged in $LogFile."

Write-Warning "Review the log file to confirm permissions were set correctly."
