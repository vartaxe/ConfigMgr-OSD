[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $PSScriptRoot
$AnalyzerSettings = Join-Path $Root 'PSScriptAnalyzerSettings.psd1'

Import-Module Pester -RequiredVersion '5.7.1' -ErrorAction Stop
Import-Module PSScriptAnalyzer -RequiredVersion '1.25.0' -ErrorAction Stop

$Findings = @(
    Invoke-ScriptAnalyzer -Path (Join-Path $Root 'Tests') -Recurse -Settings $AnalyzerSettings -Severity Error, Warning
    Invoke-ScriptAnalyzer -Path (Join-Path $Root 'build') -Recurse -Settings $AnalyzerSettings -Severity Error, Warning
)
if ($Findings.Count -gt 0) {
    $Findings | Format-Table
    throw 'PSScriptAnalyzer findings require review.'
}

$Result = Invoke-Pester -Path (Join-Path $Root 'Tests') -Output Detailed -PassThru
if ($null -eq $Result -or $Result.Result -ne 'Passed' -or $Result.TotalCount -eq 0 -or
    $Result.FailedCount -gt 0 -or $Result.FailedContainersCount -gt 0 -or
    $Result.FailedBlocksCount -gt 0 -or $Result.SkippedCount -gt 0 -or
    $Result.NotRunCount -gt 0) {
    throw 'Pester did not complete with a fully passing, nonempty test suite.'
}