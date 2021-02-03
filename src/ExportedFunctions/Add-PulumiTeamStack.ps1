function Add-PulumiTeamStack {
    [cmdletbinding()]
    param(
        $Team,
        [string[]]$Stack,
        $Project,
        [validateSet("READ","WRITE","ADMIN")]
        $Permission="READ",
        $Pulumi = $Global:DefaultPulumi
    )
    $Permissions = @{
        "READ" = 101;
        "WRITE" = 102;
        "ADMIN" = 103;
    }
    $Stack | ForEach-Object {
        $ThisStack = $_
        $Body = @{   
            addStackPermission = @{
                projectName = $Project;
                stackName = $ThisStack;
                permission = $Permissions[$Permission];
            }
        } | convertto-json -Depth 3 -Compress
    
        Invoke-PulumiApi -Url "/api/orgs/$($Pulumi.org)/teams/$Team" -Pulumi $Pulumi -Method "PATCH" -Body $Body
    }
}