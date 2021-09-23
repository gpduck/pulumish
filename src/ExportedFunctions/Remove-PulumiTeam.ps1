<#
.SYNOPSIS
Removes pulumi team(s).

.DESCRIPTION
Removes pulumi team(s).

.PARAMETER Team
The team to filter by.

This can be either the name or team object returned from Get-PulumiTeam.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Remove-PulumiTeam -Team DevOps

Removes the team 'DevOps'.

.EXAMPLE
Remove-PulumiTeam -Name DevOps,Security

Removes the teams 'DevOps' and 'Security'.
#>
function Remove-PulumiTeam {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [object[]]$Team,

        $Pulumi = $Global:DefaultPulumi
    )
    
    $Team | ForEach-Object {
        $ThisTeam = $_
        
        if($ThisTeam -is [string]){
            $TeamName = $ThisTeam    
        }
        elseif($TeamName.name) {
            $TeamName = $ThisTeam.name
        }
        else {
            Write-Error "Unkown paremeter value specified for Team."
        }

        Invoke-PulumiApi -Url "/api/orgs/$($Pulumi.org)/teams/$TeamName" -Pulumi $Pulumi -Method "DELETE"
    }
     
}
