if (Get-Module -ListAvailable -Name ActiveDirectory) {
    Write-Host "Active Directory module is already installed."
    Import-Module ActiveDirectory
} else {
    Write-Host "Active Directory module NOT found. Installing..."
    try {
        Install-WindowsFeature -Name RSAT-AD-PowerShell -IncludeAllSubFeature -IncludeManagementTools -ErrorAction Stop
        Import-Module ActiveDirectory
        Write-Host "Active Directory module installed and imported successfully."
    } catch {
        Write-Error "Failed to install Active Directory module: $($_.Exception.Message)"
    }
}
