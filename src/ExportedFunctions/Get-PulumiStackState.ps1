<#
.SYNOPSIS
Gets the state of a stack or stacks for a given project or projects.

.DESCRIPTION
Gets the state of a stack or stacks for a given project or projects.

.PARAMETER Project
The name or names of projects to get stacks from.

.PARAMETER StackName
The name or names of stacks to get the state of.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Get-PulumiStackState -Project DevOps -StackName Dev

Returns the stack state for 'Dev' from  project 'DevOps'.

.EXAMPLE
Get-PulumiStackSate -Project DevOps -StackName Dev,Test,Stage

Returns the stack states for 'Dev', 'Test', 'Stage' from  project 'DevOps'.
#>
function Get-PulumiStackState {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string[]]$Project,
        
        [Parameter(Mandatory=$true)]
        [string[]]$StackName,

        $Pulumi = $Global:DefaultPulumi
    )
    
    # Lists all stacks available to the user
    $BaseURI = "/api/stacks/$($Pulumi.Org)"

    $RequestUris = [System.Collections.ArrayList]@()
    
    $Project | ForEach-Object {
        $ThisProject = $_
        $StackName | ForEach-Object {
            $ThisStackName = $_
            $RequestUris.add($BaseURI + "/$ThisProject/$ThisStackName/export") > $null
        }
    }

    $RequestUris | ForEach-Object {
        Invoke-PulumiApi -Url $_
    }
    
}
