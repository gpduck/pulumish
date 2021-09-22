function Connect-Pulumi {
    param(
        [Parameter(Mandatory=$true)]
        $Org,
        $CredPath = (Join-Path $Home ".pulumi/credentials.json"),
        $Url = "https://api.pulumi.com",

        [Switch]$NotDefault
    )
    
    
    
    if(!(Test-Path $CredPath)) {
        Write-Error "Please log-in to pulumi using 'pulumi login' and then re-run Connect-Pulumi."
        return
    }
    
    $Credentials = Get-Content $CredPath | ConvertFrom-Json | ForEach-Object {$_}

    $TokenKeys = $Credentials.accessTokens | Get-Member -MemberType NoteProperty | ForEach-Object {$_.Name}

    If($TokenKeys -notcontains $Url) {
        Write-Error "Unable to find a credential for Pulumi at $CredPath"
    }
    Else {
        $Pulumi = [PSCustomObject]@{
            PulumiUrl = $Url
            Token = $Credentials.accessTokens."$Url"
            Org = $Org
        }
        if(!$NotDefault) {
            $Global:DefaultPulumi = $Pulumi
        }
        $Pulumi
    }

}