<#
.SYNOPSIS
Invokes a request to the pulumi API.

.DESCRIPTION
Invokes a request to the pulumi API.

Handles the authentication and header formatting of requests to the API.

.PARAMETER  Url
The path of the API request to invoke.

.PARAMETER Method
The http method of the request.

.PARAMETER Body
The body of the request.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Invoke-PulumiApi -Url /api/orgs/$($Pulumi.Org)/teams

Invokes the get teams endpoint with the default GET method and Pulumi connection.

.EXAMPLE
Invoke-PulumiApi -Method POST -Url /api/orgs/$($Pulumi.Org)/teams -Body @{name="newTeam"}

Invokes a POST request to create a new team with a payload of data.
#>
function Invoke-PulumiApi {
    param(
        [Parameter(Mandatory=$true)]
        $Url,

        [ValidateSet("GET","DELETE","PATCH","POST")]
        $Method = "GET",

        $Body = @{},
        
        [ValidateNotNullOrEmpty()]
        $Pulumi = $Global:DefaultPulumi
    )

    $Headers = @{
        Authorization = "token $($Pulumi.Token)"
        "Accept"="application/vnd.pulumi+8"
    }

    $RequestUrl = "$($Pulumi.PulumiUrl)$Url"

    Write-Debug $RequestUrl

    Invoke-RestMethod -Method $Method -Uri $RequestUrl -ContentType "application/json" -Body $Body -Headers $Headers | ForEach-Object {$_}

}
