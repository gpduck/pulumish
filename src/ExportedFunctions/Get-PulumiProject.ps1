function Get-PulumiProject {
    param(
        $Name,

        $Pulumi = $Global:DefaultPulumi
    )
    
    Invoke-PulumiApi -Url /api/console/orgs/$($Pulumi.Org)/repos -Pulumi $Pulumi | % repositories  | ForEach-Object {
        $_.Projects | Where-Object {
            if($Name) {
                $_.Name -like $Name
            } else {
                $True
            }
        }
    }

}
