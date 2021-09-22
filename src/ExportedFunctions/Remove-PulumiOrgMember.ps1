function Remove-PulumiOrgMember {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string[]]$Username,

        $Pulumi = $Global:DefaultPulumi
    )

    $Username | ForEach-Object {
        $ThisUsername = $_

        Invoke-PulumiApi -Url "/api/orgs/$($Pulumi.org)/members/$ThisUsername" -Pulumi $Pulumi -Method "DELETE" 
    }
}