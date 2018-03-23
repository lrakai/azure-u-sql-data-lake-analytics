$Region = "WestUS2"
$ResourceGroup = "data-lake-lab"
Login-AzureRmAccount
New-AzureRmResourceGroup -Name $ResourceGroup -Location $Region
