<#
.SYNOPSIS
Removes a user from a pulumi organization.

.DESCRIPTION
Removes a user from a pulumi organization.

.PARAMETER Username
The username(s) of the user(s) to remove to the organization.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Remove-PulumiOrgMember -username tomjones -pulumi $pulumi

Removes user 'tomjones' from the org in the $pulumi connection.
#>
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
