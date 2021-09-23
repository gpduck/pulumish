<#
.SYNOPSIS
Connects to a pulumi organization.

.DESCRIPTION
Connects to a pulumi organization.

.PARAMETER Org
The Pulumi organization name to connect to.

.PARAMETER ApiKey
The ApiKey to use when connecting.

By default this function will try using the default CredPath value if ApiKey is not specified.

.PARAMETER CredPath
The path to the credentials.json file created when connecting with the 'pulumi login' command.

Defaults to $HOME/.pulumi/credentials.json.

.PARAMETER Url
The url of the pulumi api to connect to.

Defaults to 'https://api.pulumi.com'.

.PARAMETER NotDefault
Specifies to not save the org in the 'Global:DefaultPulumi' variable.

If specified the pulumi connection object that is output will need to be passed into other commands explicitly.

.EXAMPLE
Connect-Pulumi -ApiKey pul-123412341234134

Connects to pulumi with an ApiKey.

.EXAMPLE
Connect-Pulumi

Connects to pulumi with the default credentials in ~/.pulumi/credentials.json.

.EXAMPLE

$pulumi = Connect-Pulumi -NotDefault

Connects to pulumi bypassing the saving to $Global:DefaultPulumi.
#>
function Connect-Pulumi {
    [cmdletbinding(DefaultParameterSetName="WithPath")]
    param(
        [Parameter(Mandatory=$true)]
        $Org,
        [Parameter(Mandatory=$true,ParameterSetName="WithAPIKey")]
        $ApiKey,
        [Parameter(Mandatory=$false,ParameterSetName="WithPath")]
        $CredPath = (Join-Path $Home ".pulumi/credentials.json"),
        $Url = "https://api.pulumi.com",

        [Switch]$NotDefault
    )
    
    
    Switch($PSCmdlet.ParameterSetName){
        "WithAPIKey" {
            # Do Nothing
        }
        "WithPath" {
            if(!(Test-Path $CredPath)) {
                Write-Error "Please log-in to pulumi using 'pulumi login' and then re-run Connect-Pulumi."
                return
            }
        
            $Credentials = Get-Content $CredPath | ConvertFrom-Json | ForEach-Object {$_}

            $TokenKeys = $Credentials.accessTokens | Get-Member -MemberType NoteProperty | ForEach-Object {$_.Name}

            If($TokenKeys -notcontains $Url) {
                Write-Error "Unable to find a credential for Pulumi at $CredPath"
            }
            $ApiKey = $Credentials.accessTokens."$Url"
        }
        default {
            Write-Error "Unkown parameter set specified."
        }
    }
    $Pulumi = [PSCustomObject]@{
        PulumiUrl = $Url
        Token = $ApiKey
        Org = $Org
    }
    if(!$NotDefault) {
        $Global:DefaultPulumi = $Pulumi
    }
    $Pulumi

}
