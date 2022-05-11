# Prompt for remote computer name, assumed to be online
$comp = Read-Host "Computername"

# Local directory to save copy of logs for review
# Change to whichever directory you save your work to
$reports = "C:\reports\"

# Add remote computer name to log file name
$outFile = $reports + $comp + "_WinDefLogs.txt"

# Get appropriate Defender log from remote computer: "MPLOG-[8 digits]-[6 digits].log"
$mplog = (Get-ChildItem "\\$comp\c$\ProgramData\Microsoft\Windows Defender\Support" | Where-Object {$_.Name -Like "MPLOG*"}).Name

# Output log file for review
# To Do: Test this in rare cases where there 
# is more than one MPLOG.log file
ForEach ($log in $mplog) {
    Get-Content "\\$comp\c$\ProgramData\Microsoft\Windows Defender\Support\$log" | Out-File $outFile
    }

# Logic check to see if completed successfully or not
If (Test-Path -LiteralPath $outFile) {
    Write-Host "The logs have been written to [$outFile] and are ready for review."
    }
Else {
    Write-Host "The logs could not be written. Please troubleshoot"
    }
