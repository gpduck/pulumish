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