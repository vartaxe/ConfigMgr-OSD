BeforeAll {
    $Root = Split-Path -Parent $PSScriptRoot
    $Readme = Get-Content -LiteralPath (Join-Path $Root 'README.md') -Raw
    $Index = Get-Content -LiteralPath (Join-Path $Root 'index.md') -Raw
    $Config = Get-Content -LiteralPath (Join-Path $Root '_config.yml') -Raw
    $Layout = Get-Content -LiteralPath (Join-Path $Root '_layouts\default.html') -Raw
}

Describe 'Hub branding' {
    It 'has accessible SVG <Name>' -ForEach @(
        @{ Name = 'banner' }, @{ Name = 'banner-compact' }, @{ Name = 'favicon' }
    ) {
        $Svg = Get-Content -LiteralPath (Join-Path $Root "assets\$Name.svg") -Raw
        $Svg | Should -Match 'role="img"'
        $Svg | Should -Match 'aria-labelledby="title description"'
        $Svg | Should -Match '<title id="title">'
        $Svg | Should -Match '<desc id="description">'
    }

    It 'shows the banner in <Name>' -ForEach @(
        @{ Name = 'README'; File = 'README.md' }, @{ Name = 'index'; File = 'index.md' }
    ) {
        $Text = Get-Content -LiteralPath (Join-Path $Root $File) -Raw
        $Text | Should -Match '<source[^>]+banner-compact\.svg'
        $Text | Should -Match '<img[^>]+banner\.svg[^>]+alt="[^"]+"'
        $Text | Should -Match '<img[^>]+banner\.svg[^>]+width="1280"[^>]+height="320"'
    }

    It 'links all three scripts in <Name>' -ForEach @(
        @{ Name = 'README'; File = 'README.md' }, @{ Name = 'index'; File = 'index.md' }
    ) {
        $Text = Get-Content -LiteralPath (Join-Path $Root $File) -Raw
        foreach ($Repo in 'AddComputerToADGroup', 'CopyOSDLogToFileShare', 'DiskPartitionLayout') {
            $Text | Should -Match "github\.com/vartaxe/ConfigMgr-OSD-$Repo"
            $Text | Should -Match "vartaxe\.github\.io/ConfigMgr-OSD-$Repo/"
        }
        $Text | Should -Match 'irreversibly cleans and repartitions'
        $Text | Should -Match 'not field-certified'
    }

    It 'configures the Cayman theme and navigation' {
        $Config | Should -Match 'theme: jekyll-theme-cayman'
        $Config | Should -Match 'baseurl: /ConfigMgr-OSD\b'
        $Config | Should -Match 'vartaxe\.github\.io/vartaxe/'
        foreach ($Repo in 'AddComputerToADGroup', 'CopyOSDLogToFileShare', 'DiskPartitionLayout') {
            $Config | Should -Match "vartaxe\.github\.io/ConfigMgr-OSD-$Repo/"
        }
    }

    It 'keeps accessible layout landmarks' {
        $Layout | Should -Match 'Skip to content'
        $Layout | Should -Match 'aria-label="Project navigation"'
    }

    It 'restores PSGallery before installing validation modules' {
        $Workflow = Get-Content -LiteralPath (Join-Path $Root '.github\workflows\ci.yml') -Raw
        $Workflow | Should -Match 'Get-PSRepository -Name PSGallery'
        $Workflow | Should -Match 'Register-PSRepository -Default'
    }

    It 'pins Pester 6.2.0 in CI and local validation' {
        $Workflow = Get-Content -LiteralPath (Join-Path $Root '.github\workflows\ci.yml') -Raw
        $Validation = Get-Content -LiteralPath (Join-Path $Root 'build\Invoke-Validation.ps1') -Raw
        $Workflow | Should -Match "Install-Module Pester -RequiredVersion '6\.2\.0'"
        $Workflow | Should -Match "Import-Module Pester -RequiredVersion '6\.2\.0'"
        $Validation | Should -Match "Import-Module Pester -RequiredVersion '6\.2\.0'"
    }

    It 'fails validation for incomplete or nonpassing test runs' {
        $Validation = Get-Content -LiteralPath (Join-Path $Root 'build\Invoke-Validation.ps1') -Raw
        foreach ($Gate in 'Result', 'TotalCount', 'FailedCount', 'FailedContainersCount',
            'FailedBlocksCount', 'SkippedCount', 'NotRunCount') {
            $Validation | Should -Match ([regex]::Escape("Result.$Gate"))
        }
    }

    It 'documents private vulnerability reporting and action updates' {
        $Security = Get-Content -LiteralPath (Join-Path $Root 'SECURITY.md') -Raw
        $Security | Should -Match 'security advisory reporting flow'

        $Dependabot = Get-Content -LiteralPath (Join-Path $Root '.github\dependabot.yml') -Raw
        $Dependabot | Should -Match 'package-ecosystem: github-actions'
        $Dependabot | Should -Match 'interval: monthly'
    }

    It 'provides a focused pull request checklist' {
        $Template = Get-Content -LiteralPath (Join-Path $Root '.github\pull_request_template.md') -Raw
        $Template | Should -Match 'Invoke-Validation\.ps1'
        $Template | Should -Match 'No credentials'
        $Template | Should -Match 'destructive OSD guidance'
    }
}
