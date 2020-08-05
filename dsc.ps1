Import-Module U:\Data\WindowsPowerShell\Modules\azureadpreview.2.0.2.105\AzureADPreview.psd1 -Verbose -Scope Local -Force
Import-Module U:\Data\WindowsPowerShell\Modules\dscparser.1.1.0.3\DSCParser.psd1 -Verbose -Scope Local -Force
Import-Module U:\Data\WindowsPowerShell\Modules\exchangeonlinemanagement.2.0.3-preview\ExchangeOnlineManagement.psd1 -Verbose -Scope Local -Force
Import-Module U:\Data\WindowsPowerShell\Modules\Microsoft.Graph.Authentication.0.7.1\Microsoft.Graph.Authentication.psd1 -Verbose -Scope Local -Force
Import-Module U:\Data\WindowsPowerShell\Modules\Microsoft.Graph.Groups.Planner.0.7.1\Microsoft.Graph.Groups.Planner.psd1 -Verbose -Scope Local -Force
Import-Module U:\Data\WindowsPowerShell\Modules\Microsoft.Graph.Identity.ConditionalAccess.0.7.1\Microsoft.Graph.Identity.ConditionalAccess.psd1 -Verbose -Scope Local -Force
Import-Module U:\Data\WindowsPowerShell\Modules\Microsoft.Graph.Planner.0.7.1\Microsoft.Graph.Planner.psd1 -Verbose -Scope Local -Force
Import-Module U:\Data\WindowsPowerShell\Modules\Microsoft.PowerApps.Administration.PowerShell.2.0.72\Microsoft.PowerApps.Administration.PowerShell.psd1 -Verbose -Scope Local -Force
Import-Module U:\Data\WindowsPowerShell\Modules\MicrosoftTeams.1.1.4\MicrosoftTeams.psd1 -Verbose -Scope Local -Force
Import-Module U:\Data\WindowsPowerShell\Modules\MSCloudLoginAssistant.1.0.32\MSCloudLoginAssistant.psd1 -Verbose -Scope Local -Force
Import-Module U:\Data\WindowsPowerShell\Modules\ReverseDSC.2.0.0.6\ReverseDSC.psd1 -Verbose -Scope Local -Force
Import-Module U:\Data\WindowsPowerShell\Modules\SharePointPnPPowerShellOnline.3.23.2007.1\SharePointPnPPowerShellOnline.psd1 -Verbose -Scope Local -Force
Import-Module U:\Data\WindowsPowerShell\Modules\microsoft365dsc.1.20.730.2\Microsoft365DSC.psd1 -Verbose -Scope Local

Set-M365DSCTelemetryOption -Enabled $False

Get-Credentials

Show-M365DSCGUI
