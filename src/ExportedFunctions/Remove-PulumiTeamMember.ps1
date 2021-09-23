<#
.SYNOPSIS
Removes a new team member from a pulumi team.

.DESCRIPTION
Removes a new team member from a pulumi team.

.PARAMETER Team
The team to filter by.

This can be either the name or team object returned from Get-PulumiTeam.

.PARAMETER Username
A string array of usernames to remove to the team.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Remove-PulumiTeamMember -Team DevOps -Username tomjones -pulumi $pulumi

Removes user 'tomjones' from the team 'DevOps'.
#>
function Remove-PulumiTeamMember {
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
    elseif($TeamName.name) {
        $TeamName = $Team.name
    }
    else {
        Write-Error "Unkown paremeter value specified for Team."
    }

    $Username | ForEach-Object {
        $ThisUsername = $_
        $Body = @{
            memberAction = "remove"
            member = $ThisUsername
        } | ConvertTo-Json

        Invoke-PulumiApi -Url "/api/orgs/$($Pulumi.org)/teams/$TeamName" -Pulumi $Pulumi -Method "PATCH" -Body $Body
    }

}
