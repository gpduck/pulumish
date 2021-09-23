<#
.SYNOPSIS
Sets the active org.

.DESCRIPTION
Sets the active org in the Pulumi connection object.

.PARAMETER Name
The name of the org to select.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.
#>
function Select-PulumiOrg {
    param(
        $Name,

        $Pulumi = $Global:DefaultPulumi
    )
    
    $Pulumi.Org = $Name

}
