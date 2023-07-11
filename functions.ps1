
function CaptureLogsForGit {
    [CmdletBinding()]
    Param(
      [Parameter(ValueFromPipeline = $True)]
      [object] $Log
    )

    begin { }
    process {
        switch($Log) {
            { $_ -is [System.Management.Automation.ErrorRecord] } {
                Write-Output "::error file={$($_.InvocationInfo.MyCommand)},line={$($_.InvocationInfo.ScriptLineNumber)},endLine={$($_.InvocationInfo.ScriptLineNumber)},title={Warning}::{$_}"
				Write-Error $_
                Write-Output $_.ScriptStackTrace
                break
            }
            { $_ -is [System.Management.Automation.WarningRecord] } {
                Write-Output "::warning file={$($_.InvocationInfo.MyCommand)},line={$($_.InvocationInfo.ScriptLineNumber)},endLine={$($_.InvocationInfo.ScriptLineNumber)},title={Warning}::{$_}"
				Write-Warning $_
                break
            }
            { $_ -is [System.Management.Automation.VerboseRecord] } {
				Write-Verbose $_
                break
            }
            { $_ -is [System.Management.Automation.DebugRecord] } {
				Write-Output "::debug file={$($_.InvocationInfo.MyCommand)},line={$($_.InvocationInfo.ScriptLineNumber)},endLine={$($_.InvocationInfo.ScriptLineNumber)},title={Warning}::{$_}"
				Write-Debug $_
                break
            }
            Default {
				Write-Output $_
            }
        }
    }
    end { }
}