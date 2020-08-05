<#
    U:\Data\VSCode\ALE

    SharePoint Patterns and Practices (PnP) contains a library of PowerShell commands (PnP PowerShell) that allows you to perform complex provisioning and artifact management actions towards SharePoint. The commands use CSOM and can work against both SharePoint Online as SharePoint On-Premises.
    
    https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets?view=sharepoint-ps

    Download https://www.powershellgallery.com/packages/SharePointPnPPowerShellOnline/3.23.2007.1
    sharepointpnppowershellonline.3.23.2007.1.nupkg
    Save to U:\Data\WindowsPowerShell\Modules
    Rename to U:\Data\WindowsPowerShell\Modules\sharepointpnppowershellonline.3.23.2007.1.zip
    Extract to U:\Data\WindowsPowerShell\Modules\sharepointpnppowershellonline.3.23.2007.1
#>

Import-Module U:\Data\WindowsPowerShell\Modules\sharepointpnppowershellonline.3.23.2007.1\SharePointPnPPowerShellOnline.psd1 -Verbose

Get-Command -Module SharePointPnPPowerShellOnline | Out-GridView -PassThru | Get-Help -ShowWindow

$Credential = Get-Credential -Message "Resource for M365"

Connect-PnPOnline -Url https://falconcrossing.sharepoint.com/sites/AutomatedAuditLayer -Credentials $Credential

Connect-PnPOnline -Url https://falconcrossing-admin.sharepoint.com/ -Credentials $Credential

$PNPSite = Get-PnPSite 

Get-PnPConnection

New-PnPList -Title "BulkUploadTest" -Template DocumentLibrary

Add-PnPFile -Path .\powershell.png -Folder BulkUploadTest -Verbose

Set-Location U:\Data\VSCode\ALE

New-Item -Path Bulk -ItemType Directory

Get-ChildItem U:\ -Recurse | Select FullName, LastAccessTime, Length | Out-File .\Bulk\File1.txt

$start = Get-Date
Add-PnPFile -Path .\Bulk\File1.txt -Folder BulkUploadTest -NewFileName ("file_{0}.txt" -f (Get-Random)) -UseWebDav
$finish = Get-Date
($finish - $start).TotalMilliseconds

Measure-PnPResponseTime -Count 100 -Timeout 20

$TestSiteAlias = "testSite_{0}" -f (Get-Random)
$TestSiteAlias
$PNPSite = New-PnPSite -Type TeamSite -Title $TestSiteAlias -Alias $TestSiteAlias -Verbose -IsPublic

Connect-PnPOnline -Url $PNPSite -Credentials $Credential

New-PnPList -Title "BulkUploadTest" -Template DocumentLibrary
$start = Get-Date
Add-PnPFile -Path .\Bulk\File1.txt -Folder BulkUploadTest -NewFileName ("file_{0}.txt" -f (Get-Random)) -UseWebDav
$finish = Get-Date
($finish - $start).TotalMilliseconds

function Test-FileUpload 
{
    <#
        .SYNOPSIS
        Upload a file using Add-PNPFile

        .EXAMPLE
            Test-FileUpload -FilePath ".\Bulk\TeamsHelp.pdf" -Copies 10 -SiteUrl "https://falconcrossing.sharepoint.com/sites/testSite_234128018" -ListTitle "BulkUploadTest" -UseWebDav -Verbose

    #>
    [CmdletBinding()]
    param
    (
        $FilePath
        ,
        [Int16]
        $Copies
        ,
        $SiteUrl
        ,
        $ListTitle
        ,
        [Switch]
        $UseWebDav
    )
    process
    {
        # Connect to the PNP site
        $Results = @()

        try
        {
            $File = Get-Item $FilePath -ErrorAction Stop

            for ($i = 1; $i -le $Copies; $i++)
            { 
                $Start = Get-Date
                Add-PnPFile -Path $File.FullName -Folder $ListTitle -NewFileName ("file_{0}{1}" -f (Get-Random),($File.Extension)) -UseWebDav:$UseWebDav -ErrorAction Stop
                $Finish = Get-Date
                $Duration = ($Finish - $Start).Totalseconds
                $MBytePerSec = $File.Length/1MB/$Duration
            }
        }
        catch
        {
            $Error[0]
        }
        $Results
    } # process
} # function Test-FileUpload
