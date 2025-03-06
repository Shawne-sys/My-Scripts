# Define source and destination mailboxes and folders
$sourceMailbox = "tish.fergus@banijayuk.com"
$destinationMailbox = "Tish&test@endemolshineuk.com"
$sourceFolder = "Overnights"
$destinationFolder = "Inbox/Overnights"


# Perform the copy
Search-Mailbox -Identity $sourceMailbox -SearchQuery "folder:$sourceFolder" -TargetMailbox $destinationMailbox -TargetFolder $destinationFolder -LogLevel Full