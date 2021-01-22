function Get-PulumiUser {
    param(
        [string[]]$Username,
        $Pulumi = $Global:DefaultPulumi
    )
    
    $Users = Invoke-PulumiApi -Url /api/orgs/$($Pulumi.Org)/members?type="backend" -Pulumi $Pulumi | % members

    If($Username){
        return $Users | Where-Object {$_.user.name -like "$Username*"}
    } 
    Else {
        return $Users
    }
}