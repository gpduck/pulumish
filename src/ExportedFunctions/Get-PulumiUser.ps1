function Get-PulumiUser {
    param(
        [string[]]$Username,
        $Pulumi = $Global:DefaultPulumi
    )
    
    $Users = Invoke-PulumiApi -Url /api/orgs/$($Pulumi.Org)/members?type="backend" -Pulumi $Pulumi | % members
    
    If($Username){
        $Username | ForEach-Object {
            $U = $_
            return $Users | Where-Object {$_.user.name -like "$U*"}
        }    
    } 
    Else {
        return $Users
    }
}
