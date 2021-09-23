<#
.SYNOPSIS
Gets pulumi team(s) by name.

.DESCRIPTION
Gets pulumi team(s) by name.

.PARAMETER Name
A name to filter teams by. Supports wildcard filters.

If not specified all teams are returned.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Get-PulumiTeam

Returns all teams.

.EXAMPLE
Get-PulumiTeam -Name DevOps

Returns the team 'DevOps'.

.EXAMPLE
Get-PulumiTeam -Name DevOps,Security

Returns the teams 'DevOps' and 'Security'.
#>
function Get-PulumiTeam {
    param(
        [string[]]$Name,
        $Pulumi = $Global:DefaultPulumi
    )
    
    If(!$Name){
        $Name = Invoke-PulumiApi -Url /api/orgs/$($Pulumi.Org)/teams -Pulumi $Pulumi | % teams | % name
    }

    $Name | ForEach-Object {
        Invoke-PulumiApi -Url /api/orgs/$($Pulumi.Org)/teams/$_ -Pulumi $Pulumi
    }

}
