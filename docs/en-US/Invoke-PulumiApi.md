---
external help file: PulumiSH-help.xml
Module Name: PulumiSH
online version:
schema: 2.0.0
---

# Invoke-PulumiApi

## SYNOPSIS
A helper function to make calls to the Pulumi API.

## SYNTAX

```
Invoke-PulumiApi [-Url] <Object> [[-Method] <Object>] [[-Pulumi] <Object>] [<CommonParameters>]
```

## DESCRIPTION
A helper function to make calls to the Pulumi API.  This function adds the required headers for authorization and unwraps the top-level array from the returned objects.

## EXAMPLES

### Example 1
```powershell
PS C:\> Invoke-PulumiApi -Url api/console/orgs/demoOrg/repos
```

Returns the repo objects from the Pulumi API.

## PARAMETERS

### -Method
Specifies the HTTP method used for the request.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: GET, DELETE

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Pulumi
A Pulumi connection object (from Connect-Pulumi).

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Url
The path part of the url, starting with a leading /.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
