<#
  Powershell script to remove all classic and personal teams instances, and install the new MS teams. 

  Note that Microsoft gradullly removes Classic teams if New teams is already installed in your environment. So you might not have to worry about this too much if your users are already migrated.

#>


# Function to uninstall classic Microsoft Teams and cleanup
function Uninstall-ClassicTeams
{
    $uninstallCommand = "$classicTeamsPath\Update.exe --uninstall"
    Start-Process -FilePath $uninstallCommand -NoNewWindow -Wait
    Remove-Item -Path $classicTeamsPath -Recurse -Force

    #path to desktop
    $desktopPath = [System.Environment]::GetFolderPath("Desktop")

    #gets all shortcuts on desktop
    $desktopShortcuts = Get-ChildItem -Path $desktopPath -Filter "*.lnk" -Recurse

    #check if it is a Teams Shortcut
    foreach ($shortcut in $desktopShortcuts)
    {
        $shell = New-Object -ComObject WScript.Shell
        $targetPath = $shell.CreateShortcut($shortcut.FullName).TargetPath

            if ($targetPath -like "*Teams.exe*")
            {
                Remove-Item -Path $shortcut.FullName -Force -ErrorAction SilentlyContinue
            }
    }

    #path to start menu
    $startMenuPath = [System.Environment]::GetFolderPath("StartMenu")
    #get the start menu shortcuts
    $startMenuShortcuts = Get-ChildItem -Path $startMenuPath -Filter "*.lnk" -Recurse

    #check for the Teams shortcut
    foreach ($shortcut in $startMenuShortcuts)
    {
        $shell = New-Object -ComObject WScript.Shell
        $targetPath = $shell.CreateShortcut($shortcut.FullName).TargetPath
        #find and remove the teams shortcut

        if ($targetPath -like "*Teams.exe*")
            {
                Remove-Item -Path $shortcut.FullName -Force
            }
    }
}

# Function to install new Microsoft Teams
function Install-NewTeams
{
    # either script to download and install the MSTeams installer from the web.

    #or incase of intine point to to the intunewin file.

}


# Stop all Teams processes
get-process "teams*" | stop-process -Force -ErrorAction SilentlyContinue

#remove any personal teams installation
Get-AppxPackage "MicrosoftTeams*" -AllUsers | Remove-AppPackage -AllUsers -ErrorAction SilentlyContinue

# Uninstall All Classic Teams appx packages
Get-AppxPackage "Teams*" -AllUsers | Remove-AppPackage -AllUsers -ErrorAction SilentlyContinue


# Paths for classic and new Microsoft Teams
$classicTeamsPath = "$env:LOCALAPPDATA\Microsoft\Teams"
$newTeamsPath = "$env:LOCALAPPDATA\Microsoft\Teams\current"



# Check if classic Microsoft Teams is installed
if (Test-Path $classicTeamsPath)
{
    Uninstall-ClassicTeams
}

# Check if new Microsoft Teams is installed
if (-Not (Test-Path $newTeamsPath))
{
    Install-NewTeams
}
