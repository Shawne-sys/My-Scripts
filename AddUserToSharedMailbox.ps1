Param (
    # User to be added
    [Parameter(Mandatory=$true)]
    $User,

    # Shared Mailbox
    [Parameter(Mandatory=$true)]
    $SharedMailbox,

    # Access Type
    [Parameter(Mandatory=$true)]
    [ValidateSet("FullAccess", "SendAs", "Both")]
    $AccessType
)

# Confirm inputs
Write-Host "User: $User"
Write-Host "Shared Mailbox: $SharedMailbox"
Write-Host "Access Type: $AccessType"

# Check if the shared mailbox exists
$Mailbox = Get-Mailbox -Identity $SharedMailbox -ErrorAction SilentlyContinue

if ($Mailbox) {
    $logMessage = ""

    if ($AccessType -eq "FullAccess" -or $AccessType -eq "Both") {
        # Grant Full Access
        Add-MailboxPermission -Identity $SharedMailbox -User $User -AccessRights FullAccess -InheritanceType All
        $logMessage += "$User granted Full Access on $SharedMailbox`n"
    }

    if ($AccessType -eq "SendAs" -or $AccessType -eq "Both") {
        # Grant Send As permission
        Add-RecipientPermission -Identity $SharedMailbox -Trustee $User -AccessRights SendAs -Confirm:$false
        $logMessage += "$User granted Send As on $SharedMailbox`n"
    }

    # Log the changes
    Write-Host $logMessage
    $logMessage | Out-File 'MailboxPermissionsLog.txt' -Append

    Write-Warning "Review the log to ensure permissions are set correctly."
} else {
    Write-Error "The shared mailbox '$SharedMailbox' was not found. Please check the mailbox name and try again."
}
