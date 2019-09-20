---
external help file: PulumiSH-help.xml
Module Name: PulumiSH
online version:
schema: 2.0.0
---

# Connect-Pulumi

## SYNOPSIS
Imports your Pulumi api token from ~/.pulumi/credentials.json for the specified Pulumi URL.

## SYNTAX

```
Connect-Pulumi [-Org] <Object> [[-Url] <Object>] [-NotDefault] [<CommonParameters>]
```

## DESCRIPTION
Imports your Pulumi api token from ~/.pulumi/credentials.json for the specified Pulumi URL.

## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-Pulumi -Org pulumi-demo

PulumiUrl              Token                    Org
---------              -----                    ---
https://api.pulumi.com pul-XXXXXXXXXXXXXXXXXXXX pulumi-demo
```

Searches ~/.pulumi/credentials.json for an API key for the default Pulumi console URL and saves the connection object to $Global:DefaultPulumi for default usage in all API calls.

## PARAMETERS

### -NotDefault
When specified, the Pulumi connection object is not saved as $Global:DefaultPulumi so explicit connections must be used when calling all Pulumi commands.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Org
The organization to log in to initially. This can be changed later using Select-PulumiOrg.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Url
The full URL to the Pulumi API (without a trailing slash). Defaults to https://api.pulumi.com

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
