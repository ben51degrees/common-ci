
param (
    [Parameter(Mandatory=$true)]
    [string]$RepoName,
    [Parameter(Mandatory=$true)]
    [string]$GitHubToken,
    [Parameter(Mandatory=$true)]
    [string]$GitHubOutput
)

. ./constants.ps1

# This token is used by the hub command.
Write-Output "Setting GITHUB_TOKEN"
$env:GITHUB_TOKEN="$GitHubToken"

Write-Output "::group::Configure Git"
./steps/configure-git.ps1 -GitHubToken $GitHubToken
Write-Output "::endgroup::"

Write-Output "::group::Clone $RepoName"
./steps/clone-repo.ps1 -RepoName $RepoName -Branch $BranchName
Write-Output "::endgroup::"

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

Write-Output "::group::Get Pull Requests"
./steps/get-pull-requests.ps1 -RepoName $RepoName -VariableName PullRequestIds -GitHubToken $GitHubToken
Write-Output pull_request_ids="[$([string]::Join(",", $PullRequestIds))]" | Out-File -FilePath $GitHubOutput -Encoding utf8 -Append
Write-Output "::endgroup::"

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}
