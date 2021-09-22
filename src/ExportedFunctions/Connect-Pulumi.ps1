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
