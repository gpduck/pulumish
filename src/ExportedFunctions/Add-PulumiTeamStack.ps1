<#
.SYNOPSIS
Adds an existing pulumi stack to a team.

.DESCRIPTION
Adds an existing pulumi stack to a team.

.PARAMETER Name
The Team to add the stack(s) to.

.PARAMETER Project
The project the stacks belong to.

.PARAMETER Permission
The permission the team should have towards the stack.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Add-PulumiTeamStack -Team DevOps -Stack dev -Project HelloWorldApp -pulumi $pulumi

Adds the stack 'dev' from project 'HelloWorldApp' to the team 'DevOps'.
#>
function Add-PulumiTeamStack {
    [cmdletbinding()]
    param(
        $Team,
        [string[]]$Stack,
        $Project,
        [validateSet("READ","WRITE","ADMIN")]
        $Permission="READ",
        $Pulumi = $Global:DefaultPulumi
    )
    
    $Permissions = @{
        "READ" = 101;
        "WRITE" = 102;
        "ADMIN" = 103;
    }

    $Stack | ForEach-Object {
        $ThisStack = $_
        $Body = @{   
            addStackPermission = @{
                projectName = $Project;
                stackName = $ThisStack;
                permission = $Permissions[$Permission];
            }
        } | convertto-json -Depth 3 -Compress
    
        Invoke-PulumiApi -Url "/api/orgs/$($Pulumi.org)/teams/$Team" -Pulumi $Pulumi -Method "PATCH" -Body $Body
    }

}
