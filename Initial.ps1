# Download-and-Run-WindowsOptimization.ps1 - AIB wrapper
$ErrorActionPreference = "Stop"
$temp = "C:\Temp\wdot"
New-Item -ItemType Directory -Path $temp -Force | Out-Null

# Download entire repo as zip
$zipUrl = "https://github.com/isg187/wdot/archive/refs/heads/main.zip"
$zipPath = "$temp\wdot.zip"
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath -UseBasicParsing

# Extract
Expand-Archive -Path $zipPath -DestinationPath $temp -Force
$scriptRoot = Get-ChildItem -Path $temp -Directory | Where-Object { $_.Name -like "wdot-*" } | Select-Object -First 1 -ExpandProperty FullName

# Run the main script with desired parameters
& "$scriptRoot\Windows_Optimization.ps1" -ConfigProfile "prod-vd" -Optimizations All -AcceptEULA -Verbose

# Cleanup
Remove-Item -Path $temp -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "Windows Optimization completed."