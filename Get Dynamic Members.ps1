#Exports a list of all members in the selceted dynamic distrobusion group.
$DynamicGroup = Read-Host "Enter the dynamic group name you wish to export members of"
$FileName = Read-Host "Enter the name you wish to name the text file."
$TextFile = $FileName + ".csv"
$DannyArlidge = Get-DynamicDistributionGroup $DynamicGroup 
Get-Recipient -RecipientPreviewFilter $DannyArlidge.RecipientFilter | select PrimarySMTPAddress | Sort-Object Name | out-file $TextFile