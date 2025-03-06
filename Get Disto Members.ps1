#Exports a list of all members in the selceted dynamic distrobusion group.
$DistroGroup = Read-Host "Enter the dynamic group name you wish to export members of"
$FileName = Read-Host "Enter the name you wish to name the text file."
$TextFile = $FileName + ".csv"
$DannyArlidge = Get-DistributionGroupMember $DistroGroup | select PrimarySMTPAddress | Sort-Object Name | out-file $TextFile
#Get-Recipient -RecipientPreviewFilter $DannyArlidge.RecipientFilter | select Name | Sort-Object Name | out-file $TextFile