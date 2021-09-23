<#
.SYNOPSIS
Removes a pulumi stack from a team.

.DESCRIPTION
Removes a pulumi stack from a team.

.PARAMETER Team
The team to filter by.

This can be either the name or team object returned from Get-PulumiTeam.

.PARAMETER Stack
The name(s) of stack(s) to remove from the specified Team.

.PARAMETER Project
The project the stacks belong to.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Remove-PulumiTeamStack -Team DevOps -Stack dev -Project HelloWorldApp -pulumi $pulumi

Removes the stack 'dev' of project 'HelloWorldApp' from the team 'DevOps'.
#>
function Remove-PulumiTeamStack {
    [cmdletbinding()]
    param(
        $Team,
        [string[]]$Stack,
        $Project,
        $Pulumi = $Global:DefaultPulumi
    )
    
    $Stack | ForEach-Object {
        $ThisStack = $_
        $Body = @{   
            removeStack = @{
                projectName = $Project;
                stackName = $ThisStack;
            }
        } | convertto-json -Depth 3 -Compress
    
        Invoke-PulumiApi -Url "/api/orgs/$($Pulumi.org)/teams/$Team" -Pulumi $Pulumi -Method "PATCH" -Body $Body
    }

}
