
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
                Write-Output "::error file=$($_.InvocationInfo.MyCommand),line=$($_.InvocationInfo.ScriptLineNumber),endLine=$($_.InvocationInfo.ScriptLineNumber),title=Error::$_ `n$($_.ScriptStackTrace)"
				Write-Error $_
                break
            }
            { $_ -is [System.Management.Automation.WarningRecord] } {
                Write-Output "::warn file=$($_.InvocationInfo.MyCommand),line=$($_.InvocationInfo.ScriptLineNumber),endLine=$($_.InvocationInfo.ScriptLineNumber),title=Warning::$_`n$($_.ScriptStackTrace)"
				Write-Warning $_
                break
            }
            { $_ -is [System.Management.Automation.VerboseRecord] } {
				Write-Verbose $_
                break
            }
            { $_ -is [System.Management.Automation.DebugRecord] } {
                Write-Output "::Debug file=$($_.InvocationInfo.MyCommand),line=$($_.InvocationInfo.ScriptLineNumber),endLine=$($_.InvocationInfo.ScriptLineNumber),title=Debug::$_`n$($_.ScriptStackTrace)"
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