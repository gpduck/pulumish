<#
.SYNOPSIS
Adds a user with a role to a pulumi organization.

.DESCRIPTION
Adds a user with a role to a pulumi organization.

.PARAMETER Username
The username of the user to add to the organization.

.PARAMETER Role
The role of the user for the organization.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Add-PulumiOrgMember -username tomjones -role Admin -pulumi $pulumi

Adds user 'tomjones' with role 'admin' to the org in the $pulumi connection.
#>
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
