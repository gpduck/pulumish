---
external help file: PulumiSH-help.xml
Module Name: PulumiSH
online version:
schema: 2.0.0
---

# Get-PulumiProject

## SYNOPSIS
Gets the projects from the Pulumi console.

## SYNTAX

```
Get-PulumiProject [[-Name] <Object>] [[-Pulumi] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Gets the projects from the Pulumi console.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-PulumiProject

orgName     : pulumiDemo
repoName    :
name        : pulumi-demo
runtime     : nodejs
description : Pulumi Demo Project
stacks      : {@{name=dev; lastUpdate=; ...}}
```

Returns all the projects the logged in user has access to from the Pulumi console.

## PARAMETERS

### -Name
The name of a project to filter on.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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
