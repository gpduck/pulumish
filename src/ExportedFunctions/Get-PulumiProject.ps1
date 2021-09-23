<#
.SYNOPSIS
Gets pulumi projects or a project by name.

.DESCRIPTION
Gets pulumi projects or a project by name.

.PARAMETER Name
A name to filter projects by. Supports wildcard filters.

If not specified all projects are returned.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Get-PulumiProject

Returns all projects.

.EXAMPLE
Get-PulumiProject -Name DevOps

Returns the project 'DevOps'.
#>
function Get-PulumiProject {
    param(
        $Name,

        $Pulumi = $Global:DefaultPulumi
    )
    
    Invoke-PulumiApi -Url /api/console/orgs/$($Pulumi.Org)/repos -Pulumi $Pulumi | % repositories  | ForEach-Object {
        $_.Projects | Where-Object {
            if($Name) {
                $_.Name -like $Name
            } else {
                $True
            }
        }
    }

}
