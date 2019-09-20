function Remove-PulumiStack {
    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact="High")]
    param(
        [Parameter(ValueFromPipeline=$true)]
        $Stack,

        $Pulumi = $Global:DefaultPulumi
    )
    process {
        if($Stack) {
            $StackName = $Stack.Name
            $ProjectName = $Stack.RoutingProject
        }
        $url = "/api/stacks/$($Pulumi.Org)/$ProjectName/$StackName"
        if($PSCmdlet.ShouldProcess("$($Pulumi.Org)/$ProjectName/$StackName", "Delete Stack")) {
            Invoke-PulumiApi -Method DELETE -Url $Url -Pulumi $Pulumi
        }
    }
}