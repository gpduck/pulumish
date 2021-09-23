<#
.SYNOPSIS
Removes pulumi stacks from an org.

.DESCRIPTION
Removes pulumi stacks from an org.

.PARAMETER Stack
The Stack Object to remove from the org.

Must be an object returned by the 'Get-PulumiStack' function.

.PARAMETER Force
Forces the removal of the stack.

.PARAMETER Pulumi
The Pulumi connection object. Defaults to $Global:DefaultPulumi.

.EXAMPLE
Get-PulumiStack -Project 'DevOps' | Remove-PulumiStack -Force

Removes all stacks from project 'DevOps'.
#>
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
