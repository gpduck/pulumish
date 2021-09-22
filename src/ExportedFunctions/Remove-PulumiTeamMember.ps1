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
