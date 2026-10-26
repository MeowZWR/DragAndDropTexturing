Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

$items = @(
    @{
        Patch = 'patches/loosetexturecompiler-skip-missing-xnormal.patch'
        Directory = 'LooseTextureCompilerCore'
    }
    @{
        Patch = 'patches/helpers-cancel-omni-scan.patch'
        Directory = 'DragAndDropTexturing/IPC/PenumbraAndGlamourerHelpers'
    }
)

foreach ($item in $items) {
    Write-Host "Applying $($item.Patch)"
    git apply --directory=$($item.Directory) --whitespace=nowarn $item.Patch
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to apply $($item.Patch)"
    }
}
