function Select-PulumiOrg {
    param(
        $Name,

        $Pulumi = $Global:DefaultPulumi
    )
    
    $Pulumi.Org = $Name

}