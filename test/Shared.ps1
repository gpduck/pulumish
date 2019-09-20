# Dot source this script in any Pester test script that requires the module to be imported.

$ModuleManifestName = 'PulumiSH.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\Release\PulumiSH\$ModuleManifestName"

if (!$SuppressImportModule) {
    # -Scope Global is needed when running tests from inside of psake, otherwise
    # the module's functions cannot be found in the PulumiSH\ namespace
    Import-Module $ModuleManifestPath -Scope Global -ErrorAction Stop
}
