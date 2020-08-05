<#
    U:\Data\VSCode\ALE

    SharePoint Patterns and Practices (PnP) contains a library of PowerShell commands (PnP PowerShell) that allows you to perform complex provisioning and artifact management actions towards SharePoint. The commands use CSOM and can work against both SharePoint Online as SharePoint On-Premises.
    
    https://docs.microsoft.com/en-us/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets?view=sharepoint-ps

    Download https://www.powershellgallery.com/packages/SharePointPnPPowerShellOnline/3.23.2007.1
    sharepointpnppowershellonline.3.23.2007.1.nupkg
    Save to U:\Data\WindowsPowerShell\Modules
    Rename to U:\Data\WindowsPowerShell\Modules\sharepointpnppowershellonline.3.23.2007.1.zip
    Extract to U:\Data\WindowsPowerShell\Modules\sharepointpnppowershellonline.3.23.2007.1

    $TestSiteAlias = "testSite_{0}" -f (Get-Random)
    $TestSiteAlias
    $PNPSite = New-PnPSite -Type TeamSite -Title $TestSiteAlias -Alias $TestSiteAlias -Verbose -IsPublic

    Connect-PnPOnline -Url $PNPSite -Credentials $Credential

#>

Import-Module U:\Data\WindowsPowerShell\Modules\sharepointpnppowershellonline.3.23.2007.1\SharePointPnPPowerShellOnline.psd1 -Verbose -Force

Get-Command -Module SharePointPnPPowerShellOnline | Out-GridView -PassThru | Get-Help -ShowWindow

$Credential = Get-Credential -Message "Resource for M365"

$SiteUrl = "https://falconcrossing.sharepoint.com/sites/testSite_234128018"

Connect-PnPOnline -Url $SiteUrl -Credentials $Credential
<#
Connect-PnPOnline -Url https://falconcrossing.sharepoint.com/sites/AutomatedAuditLayer -Credentials $Credential
Connect-PnPOnline -Url https://falconcrossing-admin.sharepoint.com/ -Credentials $Credential
#>

$PNPSite = Get-PnPSite 

Get-PnPConnection

$ListTitle = "BulkUploadTest"

if(Get-PNPList $ListTitle)
{
    "$ListTile exists"
}
else
{
    "$ListTitle does not exist, creating"

    New-PnPList -Title $ListTitle -Template DocumentLibrary -Verbose
}

Set-Location U:\Data\VSCode\ALE


$start = Get-Date
Add-PnPFile -Path U:\Data\VSCode\ALE\Bulk\TeamsHelp.pdf -Folder $ListTitle -NewFileName ("file_{0}.pdf" -f (Get-Random)) -UseWebDav
$finish = Get-Date
($finish - $start).TotalMilliseconds



function Test-FileUpload
{
    <#
        .SYNOPSIS
        Upload a file using Add-PNPFile

        .EXAMPLE
            Test-FileUpload -FilePath "U:\Data\VSCode\ALE\Bulk\TeamsHelp.pdf" -Copies 15 -SiteUrl "https://falconcrossing.sharepoint.com/sites/testSite_234128018" -ListTitle "BulkUploadTest" -UseWebDav -Verbose

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
        $ResultObjectProperties = [Ordered] @{
                            Copy = $null
                            Start = $null
                            Finish = $null
                            Name = $null
                            SizeMB = $null
                            Duration = $null
                            MBytePerSec = $null
                        }

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

                $Result = New-Object -TypeName PSObject -Property $ResultObjectProperties
                $Result.Copy = $i
                $Result.Start = $Start
                $Result.Finish = $Finish
                $Result.Name = $File.FullName
                $Result.SizeMB = "{0:N2}" -f ($File.Length/1MB)
                $Result.Duration = "{0:N2}" -f $Duration
                $Result.MBytePerSec = "{0:N2}" -f $MBytePerSec

                $Results += $Result
            }
        }
        catch
        {
            $Error[0]
        }
        $Results
    } # process
} # function Test-FileUpload
