function Invoke-PulumiApi {
    param(
        [Parameter(Mandatory=$true)]
        $Url,

        [ValidateSet("GET","DELETE","PATCH")]
        $Method = "GET",
        $Body = @{},
        [ValidateNotNullOrEmpty()]
        $Pulumi = $Global:DefaultPulumi
    )
    $Headers = @{
        Authorization = "token $($Pulumi.Token)"
        "Accept"="application/vnd.pulumi+3"
    }
    $RequestUrl = "$($Pulumi.PulumiUrl)$Url"
    Write-Debug $RequestUrl
    Invoke-RestMethod -Method $Method -Uri $RequestUrl -ContentType "application/json" -Body $Body -Headers $Headers | ForEach-Object {$_}
}