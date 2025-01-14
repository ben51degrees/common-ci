
param(
    [Parameter(Mandatory=$true)]
    [string]$RepoName,
    [string]$ProjectDir = ".",
    [string]$Name = "Release_x64",
    [string]$Configuration = "Release",
    [string]$Arch = "x64"
)

$RepoPath = [IO.Path]::Combine($pwd, $RepoName)

Write-Output "Entering '$RepoPath'"
Push-Location $RepoPath

try {
    
    nuget restore $ProjectDir
    msbuild $ProjectDir /p:Platform=$Arch /p:Configuration=$Configuration /p:BuiltOnCI=true

}
finally {
   
    Write-Output "Leaving '$RepoPath'"
    Pop-Location

}

exit $LASTEXITCODE
