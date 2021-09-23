<#
.SYNOPSIS
Adds a new team member to an existing pulumi team.

.DESCRIPTION
Adds a new team member to an existing pulumi team.

.PARAMETER Name
The Team to add the user(s) to.

.PARAMETER Username
A string array of usernames to add to the team.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Add-PulumiTeamMember -Team DevOps -Username tomjones -pulumi $pulumi

Adds user 'tomjones' to the team 'DevOps'.
#>
function Add-PulumiTeamMember {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [object]$Team,

        [Parameter(Mandatory=$true)]
        [string[]]$Username,

        $Pulumi = $Global:DefaultPulumi
    )

    if($Team -is [string]){
        $TeamName = $Team    
    }
    ElseIf($TeamName.name) {
        $TeamName = $Team.name
    }
    Else {
        Write-Error "Unkown paremeter value specified for Team."
    }

    $Username | ForEach-Object {
        $ThisUsername = $_
        $Body = @{
            memberAction = "add"
            member = $ThisUsername
        } | ConvertTo-Json

        Invoke-PulumiApi -Url "/api/orgs/$($Pulumi.org)/teams/$TeamName" -Pulumi $Pulumi -Method "PATCH" -Body $Body
    }
    
}
