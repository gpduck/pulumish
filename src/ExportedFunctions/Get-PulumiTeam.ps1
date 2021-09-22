function Get-PulumiTeam {
    param(
        [string[]]$Name,
        $Pulumi = $Global:DefaultPulumi
    )
    
    If(!$Name){
        $Name = Invoke-PulumiApi -Url /api/orgs/$($Pulumi.Org)/teams -Pulumi $Pulumi | % teams | % name
    }

    $Name | ForEach-Object {
        Invoke-PulumiApi -Url /api/orgs/$($Pulumi.Org)/teams/$_ -Pulumi $Pulumi
    }

}
