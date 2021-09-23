<#
.SYNOPSIS
Gets pulumi stacks.

.DESCRIPTION
Gets pulumi stacks. Stacks can be filtered using the Project parameter.

.PARAMETER Project
The name or names of projects to get stacks from.

If not specified all stacks are returned.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Get-PulumiStack

Returns all projects.

.EXAMPLE
Get-PulumiStack -Project DevOps

Returns the pulumi stacks from project 'DevOps'.
#>
function Get-PulumiStack {
    [cmdletbinding()]
    param(
        [string[]]$Project,
        $Pulumi = $Global:DefaultPulumi
    )
    
    # Lists all stacks available to the user
    $BaseURI = "/api/user/stacks?organization=$($Pulumi.Org)"

    $RequestUris = [System.Collections.ArrayList]@()
    
    if($Project){
        $Project | ForEach-Object {
            $ThisProject = $_
            $RequestUris.add($BaseURI + "&project=$ThisProject") > $null
        }
    }
    else{
        Write-Verbose "No Project specified. Retrieving all projects."
        $RequestUris.add($BaseURI) > $null
    }

    $RequestUris | ForEach-Object {
        Invoke-PulumiApi -Url $_
    }
}
