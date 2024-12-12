Write-Output "Branch name: $env:branchName"
$global:inputVersion = $env:branchName
$global:errorCode = 0

$BUILD_VERSIONS_LIST = "BUILD_VERSIONS_LIST"

$allVersions = @(
    "14.1", "14.2",
    "15.1", "15.2",
    "16.1", "16.2",
    "17.1", "17.2",
    "18.1", "18.2",
    "19.1", "19.2",
    "20.1", "20.2",
    "21.1", "21.2",
    "22.1", "22.2",
    "23.1", "23.2",
    "24.1", "24.2",
    "25.1", "25.2" 
)

function Process-JavaScriptProjects {
    param (
        [string]$Path = ".",
        [hashtable[]]$Folders = @(
            @{ Name = "jQuery"; Packages = @("devextreme-dist", "devextreme") },
            @{ Name = "Angular"; Packages = @("devextreme-angular", "devextreme") },
            @{ Name = "React"; Packages = @("devextreme-react", "devextreme") },
            @{ Name = "Vue"; Packages = @("devextreme-vue", "devextreme") }
        )
    )
    Write-Host "`n--== Processing JavaScript Projects ==--"

    foreach ($folder in $Folders) {
        if (-not (Test-Path $($folder.Name))) {
            Write-Host "Directory $($folder.Name) does not exist. Skipping..."
            continue
        }

        Write-Host "`n<-- Processing folder: $($folder.Name) -->"
        
        Set-Location $($folder.Name)

		$packages = $folder.Packages | ForEach-Object { "$_@$global:buildVersion" }

		$packageList = $packages -join " "

		$command = "npm install $packageList --force --save --no-fund"

		Write-Output "Running: $command"
		Invoke-Expression $command
		
        Write-Host "Running 'npm install' in $($folder.Name)"
        $installResult = & npm install --force --no-fund --loglevel=error -PassThru
        if ($LASTEXITCODE -ne 0) {
            Write-Error "ERROR: npm install failed in $($folder.Name)"
            $global:errorCode = 1
        }

        Write-Host "`n<-- Updating packages... -->"

        Write-Host "Running 'npm run build' in $($folder.Name)"
        $buildResult = & npm run build
        if ($LASTEXITCODE -ne 0) {
            Write-Error "ERROR: npm run build failed in $($folder.Name)"
            $global:errorCode = 1
        }

        Set-Location ..
    }
}

function Process-DotNetProjects {
    param (
        [string]$RootDirectory = "."
    )
    Write-Host "`nProcessing .NET Projects"

    $slnFiles = Get-ChildItem -Path $RootDirectory -Filter *.sln -Recurse -Depth 1

    if ($slnFiles.Count -eq 0) {
        Write-Host "No solution files (.sln) found in the specified directory at level 1."        
        return
    }

    foreach ($slnFile in $slnFiles) {
        Write-Host "Found solution file: $($slnFile.FullName)"
        
        dotnet build $slnFile.FullName -c Release

        if ($LASTEXITCODE -eq 0) {
            Write-Host "Build succeeded for $($slnFile.FullName)."
        } else {
            Write-Error "Build failed for $($slnFile.FullName)."
            $global:errorCode = 1
        }
    }
} 

function Set-BuildVersion {
    $inputMajorMinor = $global:inputVersion -replace "\.\d+\+$", ""

    $filteredList = $allVersions | Where-Object {
        ($_ -replace "\." -as [double]) -ge ($inputMajorMinor -replace "\." -as [double])
    }

    $currentValue = [Environment]::GetEnvironmentVariable($BUILD_VERSIONS_LIST, [EnvironmentVariableTarget]::Machine)

    $currentList = if ($currentValue) {
        $currentValue -split ";"
    } else {
        $filteredList
    }

    if ($currentList.Count -gt 1) {
        $inputMajorMinor = $currentList[0]
        Write-Output "Input version: '$inputMajorMinor'"
        $global:buildVersion = $inputMajorMinor
        $updatedList = $currentList[1..($currentList.Count - 1)]
    } else {
        Write-Output "The list in the environment variable has only one item. "
        $inputMajorMinor = $currentList
        $global:buildVersion = $inputMajorMinor
        Write-Output "Input version: '$inputMajorMinor'"
        $updatedList = ""
    }

    $newValue = $updatedList -join ";"

    [Environment]::SetEnvironmentVariable($BUILD_VERSIONS_LIST, $newValue, [EnvironmentVariableTarget]::Machine)

    Write-Output "Environment variable '$BUILD_VERSIONS_LIST' has been updated."
    Write-Output "New List: $updatedList"
}

Write-Host "`nBranch Name: $global:branchName"

Set-BuildVersion
Process-JavaScriptProjects
Process-DotNetProjects

Write-Host "Error code: $global:errorCode"

exit $global:errorCode
