function Get-PulumiStackState {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string[]]$Project,
        
        [Parameter(Mandatory=$true)]
        [string[]]$StackName,

        $Pulumi = $Global:DefaultPulumi
    )
    
    # Lists all stacks available to the user
    $BaseURI = "/api/stacks/$($Pulumi.Org)"

    $RequestUris = [System.Collections.ArrayList]@()
    
    $Project | ForEach-Object {
        $ThisProject = $_
        $StackName | ForEach-Object {
            $ThisStackName = $_
            $RequestUris.add($BaseURI + "/$ThisProject/$ThisStackName/export") > $null
        }
    }

    $RequestUris | ForEach-Object {
        Invoke-PulumiApi -Url $_
    }
    
}
