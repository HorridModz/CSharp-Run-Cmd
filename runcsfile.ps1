# Cool snippet originally from https://stackoverflow.com/a/40854220/22081657, modified, improved, and turned into a script
# Uses the Rosyln compiler to run C# files from the command line, in one easy command
# Run as: `runcsfile <filepath>`

param (
	[parameter(Mandatory=$true)]
	[string]$filetorun
)

$ErrorActionPreference = "Stop"
$global:LASTEXITCODE = 0 

function Download-Roslyn-And-Get-Install-Path {
	# Thanks ChatGPT :) used it for some of this

    # Get all installed versions of the package
	$installedPackages = Get-Package -Name Microsoft.Net.Compilers -ErrorAction SilentlyContinue

    # Check if any versions are installed
    if ($installedPackages) {
        # Select the latest version
        $highestVersionPackage = $installedPackages | Sort-Object -Property Version -Descending | Select-Object -First 1
		return $highestVersionPackage.Source
    } else {
        Write-Host "Package Microsoft.Net.Compilers is not installed. Installing latest version..."
        $WarningPreference = "Stop"
		# Install Roslyn with Nuget (must use V2 API, because V3 doesn't work for some reason)
		Install-Package Microsoft.Net.Compilers -ProviderName NuGet -Source https://www.nuget.org/api/v2 -Scope CurrentUser
		if($LASTEXITCODE -ne 0) {
			exit $LASTEXITCODE
		}
		$WarningPreference = "Default"
		Write-Host "Successfully installed Microsoft.Net.Compilers. Rerun the script."
		exit 0
    }
}

# Download the C# Roslyn compiler and locate installation path
$RosylnPath = Download-Roslyn-And-Get-Install-Path

# Compile file to exe with Rosyln
$CompilerExePath = [System.IO.Path]::GetDirectoryName($RosylnPath) + "\tools\csc.exe"
Invoke-Expression "$CompilerExePath `"$filetorun`" /out:compiled_temp.exe"
if($LASTEXITCODE -ne 0) {
	exit $LASTEXITCODE
}

# Run it
.\compiled_temp.exe

Remove-Item "compiled_temp.exe"