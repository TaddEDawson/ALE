Get-Module Microsoft.Teams.Config | Remove-Module -Force
Get-Module MSOnline | Remove-Module -Force

Import-Module \\ain2\dfsroot\USERDATA38\TADDED\Data\WindowsPowerShell\Modules\msonline.1.1.183.57\MSOnline.psd1 -Verbose -DisableNameChecking -Scope Local
Import-Module \\ain2\dfsroot\userdata38\tadded\Data\WindowsPowerShell\Modules\microsoftteams.1.1.4\MicrosoftTeams.psd1 -Verbose -DisableNameChecking -Force -Scope Local

$Credentials = Get-Credential

Connect-MicrosoftTeams -Credential $Credentials

<#
Account      : tadd@falconcrossing.com
Environment  : AzureCloud
Tenant       : 61f6e2b3-3044-466a-9740-1142eeb1910c
TenantId     : 61f6e2b3-3044-466a-9740-1142eeb1910c
TenantDomain : falconcrossing.com
#>

Foreach ($MSTeam in (Get-Team))
{
    $MSTeam | Format-List
}

$Team = Get-Team -GroupId 118afd38-9045-4bac-a6c6-1d3722349833
$Team.Visibility = "Public"

