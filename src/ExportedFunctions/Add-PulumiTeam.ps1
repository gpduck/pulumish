function Add-PulumiTeam {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name,

        [string]$DisplayName,

        [string]$Description,

        [ValidateSet("Pulumi","Github")]
        [string]$TeamType="Pulumi",

        $Pulumi = $Global:DefaultPulumi
    )
        $Body = @{   
            name = $Name;
        }

        if($Description){
            $Body["description"] = $Description;
        }
        
        if($DisplayName){
            $Body["displayName"] = $DisplayName;
        } 

        $Body = $Body | ConvertTo-Json

        Invoke-PulumiApi -Url "/api/orgs/$($Pulumi.org)/teams/$($TeamType.toLower())" -Pulumi $Pulumi -Method "POST" -Body $Body
}