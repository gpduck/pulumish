---
external help file: PulumiSH-help.xml
Module Name: PulumiSH
online version:
schema: 2.0.0
---

# Select-PulumiOrg

## SYNOPSIS
Change to the specified org.

## SYNTAX

```
Select-PulumiOrg [[-Name] <Object>] [[-Pulumi] <Object>]
```

## DESCRIPTION
Change to the specified org.

## EXAMPLES

### Example 1
```powershell
PS C:\> Select-PulumiOrg -Name pulumi-demo
```

Sets the organziation for the module to operate against on $Global:DefaultPulumi.

## PARAMETERS

### -Name
The name of the organization for the module to operate against.

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
A Pulumi connection object (from Connect-Pulumi) that should be modified to use the new org.

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

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
