function Remove-PulumiTeamStack {
    [cmdletbinding()]
    param(
        $Team,
        [string[]]$Stack,
        $Project,
        $Pulumi = $Global:DefaultPulumi
    )
    
    $Stack | ForEach-Object {
        $ThisStack = $_
        $Body = @{   
            removeStack = @{
                projectName = $Project;
                stackName = $ThisStack;
            }
        } | convertto-json -Depth 3 -Compress
    
        Invoke-PulumiApi -Url "/api/orgs/$($Pulumi.org)/teams/$Team" -Pulumi $Pulumi -Method "PATCH" -Body $Body
    }

}