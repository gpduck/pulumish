function Add-PulumiOrgMember {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string[]]$Username,
        [ValidateSet("Admin","Member")]
        $Role,
        $Pulumi = $Global:DefaultPulumi
    )

    $Username | ForEach-Object {
        $ThisUsername = $_
        $Body = @{
            role = $Role.ToLower()
        } | ConvertTo-Json

        Invoke-PulumiApi -Url "/api/orgs/$($Pulumi.org)/members/$ThisUsername" -Pulumi $Pulumi -Method "POST" -Body $Body
    }
}