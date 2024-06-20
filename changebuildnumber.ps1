param (
    [string]$buildNumber
)

(Get-Content -Path "task.json") -replace 'buildNumber', $buildNumber | Set-Content -Path "task-new.json"
