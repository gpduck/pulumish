function Add-PulumiTeam {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [object[]]$Team,

        [ValidateSet("Pulumi","Github")]
        [string]$TeamType="Pulumi",

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
