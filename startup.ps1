$Region = "WestUS2"
$ResourceGroup = "data-lake-lab"
Login-AzureRmAccount
New-AzureRmResourceGroup -Name $ResourceGroup -Location $Region
New-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroup -TemplateFile .\infrastructure\arm-template.json -Name "data-lake-lab"