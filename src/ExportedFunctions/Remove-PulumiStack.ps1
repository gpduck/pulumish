function Remove-PulumiStack {
    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact="High")]
    param(
        [Parameter(ValueFromPipeline=$true)]
        $Stack,

        [switch]$Force,

        $Pulumi = $Global:DefaultPulumi
    )
    
    process {
        
        if($Stack) {
            $StackName = $Stack.Name
            $ProjectName = $Stack.RoutingProject
        }
        
        $url = "/api/stacks/$($Pulumi.Org)/$ProjectName/$StackName"
        
        if($PSCmdlet.ShouldProcess("$($Pulumi.Org)/$ProjectName/$StackName", "Delete Stack")) {
            if($Force) {
                $Url = "${Url}?force=true"
            }
            Invoke-PulumiApi -Method DELETE -Url $Url -Pulumi $Pulumi
        }

    }

}