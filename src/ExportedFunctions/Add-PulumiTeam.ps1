<#
.SYNOPSIS
Adds a new team to a pulumi organization.

.DESCRIPTION
Adds a new team to a pulumi organization.

.PARAMETER Name
The name of the new team.

.PARAMETER DisplayName
A display name for the new team. This will be visible in the teams list.

.PARAMETER Description
A description for the new team.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Add-PulumiTeam -Name DevOps -DisplayName "Dev Ops" -Description "Dev Ops pulumi team" -TeamType Pulumi -pulumi $pulumi

Adds a new pulumi team 'DevOps' of type 'pulumi' to the org in the $pulumi connection.
#>
function Add-PulumiTeam {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name,

        [string]$DisplayName,

        [string]$Description,

        [ValidateSet("Pulumi","Github")]
        [string]$TeamType="Pulumi",

        $Pulumi = $Global:DefaultPulumi
    )
    $Body = @{   
        name = $Name;
    }

    if($Description){
        $Body["description"] = $Description;
    }
    
    if($DisplayName){
        $Body["displayName"] = $DisplayName;
    } 

    $Body = $Body | ConvertTo-Json

    Invoke-PulumiApi -Url "/api/orgs/$($Pulumi.org)/teams/$($TeamType.toLower())" -Pulumi $Pulumi -Method "POST" -Body $Body
    
}
