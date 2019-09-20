Currently a quick POC module against the [undocumented Pulumi API](https://github.com/pulumi/docs/issues/741) (to help me clean up some stack mess I had made while getting ramped up on Pulumi).

```PowerShell
Install-Module PulumiSH

Import-Module PulumiSH
# You need to have already logged in with pulumi.exe login
Connect-Pulumi -Org my-org

Get-PulumiProject

(Get-PulumiProject -Name my-defunct-project).Stacks | Remove-PulumiStack -Whatif
```