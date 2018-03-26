# azure-u-sql-data-lake-analytics

Submitting a U-SQL Job to Azure Data Lake Analytics

![Environment Diagram](https://user-images.githubusercontent.com/3911650/37886542-3c7993be-3079-11e8-8199-897b2607dd4a.png)


## Getting Started

An Azure RM template is included in `infrastructure/` to create the environment:

<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Flrakai%2Fazure-u-sql-data-lake-analytics%2Fmaster%2Finfrastructure%2Farm-template.json">
    <img src="https://camo.githubusercontent.com/536ab4f9bc823c2e0ce72fb610aafda57d8c6c12/687474703a2f2f61726d76697a2e696f2f76697375616c697a65627574746f6e2e706e67" data-canonical-src="http://armviz.io/visualizebutton.png" style="max-width:100%;">
</a> 

Using Azure PowerShell, do the following to provision the resources:

```ps1
.\startup.ps1
```

Alternatively, you can perform a one-click deploy with the following button:

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flrakai%2Fazure-u-sql-data-lake-analytics%2Fmaster%2Finfrastructure%2Farm-template.json">
    <img src="https://camo.githubusercontent.com/9285dd3998997a0835869065bb15e5d500475034/687474703a2f2f617a7572656465706c6f792e6e65742f6465706c6f79627574746f6e2e706e67" data-canonical-src="http://azuredeploy.net/deploybutton.png" style="max-width:100%;">
</a>

## Following Along

1. Upload `data/searchLog.tsv` to the Data Lake Store created by the template.
1. Create a Data Lake Analytics job and use the following U-SQL query:

    ```sql
    @searchlog =
        EXTRACT UserId   int,
            TimeStamp    DateTime,
            Language     string,
            Query        string,
            Duration     int,
            Urls         string,
            ClickedUrls  string
        FROM "/searchLog.tsv"
        USING Extractors.Tsv();

    @out =
        SELECT TimeStamp, Query, Duration
        FROM @searchlog
        WHERE Duration > 800;

    OUTPUT @out
        TO "/output.tsv"
        USING Outputters.Tsv();
    ```

1. Inspect the `output.tsv` file in the Data Lake Store.

## Tearing Down

When finished, remove the Azure resources with:

```ps1
.\teardown.ps1
```

## Acknowledgments

Thanks to Microsoft for the [sample search log data](https://github.com/Azure/Azure-DataFactory/tree/master/Samples/U-SQL%20Sample%20Input%20File).