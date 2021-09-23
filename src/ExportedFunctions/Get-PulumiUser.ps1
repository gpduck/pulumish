<#
.SYNOPSIS
Gets pulumi user(s) by username.

.DESCRIPTION
Gets pulumi user(s) by username.

.PARAMETER Username
A name to filter user by. Supports wildcard filters.

If not specified all users are returned.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Get-PulumiUser

Returns all users.

.EXAMPLE
Get-PulumiUser -Username tomjones

Returns the user with username 'tomjones'.

.EXAMPLE
Get-PulumiUser -Username tomjones,billbob

Returns the users with usernames 'tomjones' and 'billbob'.
#>
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
