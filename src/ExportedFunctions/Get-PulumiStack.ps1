function Get-PulumiStack {
    [cmdletbinding()]
    param(
        [string[]]$Project,
        $Pulumi = $Global:DefaultPulumi
    )
    
    # Lists all stacks available to the user
    $BaseURI = "/api/user/stacks?organization=$($Pulumi.Org)"

    $RequestUris = [System.Collections.ArrayList]@()
    
    if($Project){
        $Project | ForEach-Object {
            $ThisProject = $_
            $RequestUris.add($BaseURI + "&project=$ThisProject") > $null
        }
    }
    else{
        Write-Verbose "No Project specified. Retrieving all projects."
        $RequestUris.add($BaseURI) > $null
    }

    $RequestUris | ForEach-Object {
        Invoke-PulumiApi -Url $_
    }
}
