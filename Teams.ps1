<#
    Download nupkg file
        https://www.powershellgallery.com/packages/MicrosoftTeams/1.1.4 
    To
        \\ain2\dfsroot\userdata38\tadded\Data\WindowsPowerShell\Modules\
    Extract to
        \\ain2\dfsroot\userdata38\tadded\Data\WindowsPowerShell\Modules\microsoftteams.1.1.4
#>

Import-Module \\ain2\dfsroot\userdata38\tadded\Data\WindowsPowerShell\Modules\microsoftteams.1.1.4\MicrosoftTeams.psd1 -Verbose
$Credential = Get-Credential -Message "Resource for M365"
Connect-MicrosoftTeams -Credential $Credential -Verbose

<#
    VERBOSE: Performing the operation "Connect-MicrosoftTeams" on target "Establishing a PowerShell session connected to the environment.".
    
    Account      : tadd@falconcrossing.com
    Environment  : AzureCloud
    Tenant       : 61f6e2b3-3044-466a-9740-1142eeb1910c
    TenantId     : 61f6e2b3-3044-466a-9740-1142eeb1910c
    TenantDomain : falconcrossing.com
#>

Get-Team

<#
    GroupId                              DisplayName        Visibility  Archived  MailNickName       Description       
    -------                              -----------        ----------  --------  ------------       -----------       
    138bcfdc-55c3-4958-a896-5681d21720bd falconcrossing     Public      False     falconcrossing     falconcrossing    
    f83c91db-d347-4183-9132-a49233a01f2f TDS                Private     False     TDS                TDS               
    41d9a224-f8f3-4c73-9a24-d6892d41206d FX                 Private     False     PMO                The purpose of ...
    6327789b-558c-41e1-88f9-9b0e1fbfb3d2 Remote Access      Private     False     RemoteAccess       Page to discuss...
    df93eff6-7126-4c77-9ea0-ff2456d296de FX Support         Public      False     Support            Check here for ...
    9770b19e-e56e-460a-9cd7-b7d6a4c6967e CCB                Private     False     CCB                CCB               
    0b180117-3a68-4971-8e3b-84c270a8396c UCE                Private     False     UCE                The purpose of ...
    8a56a987-e523-4346-addc-8acff08c3325 EX                 Private     False     EX                 The purpose of ...
    118afd38-9045-4bac-a6c6-1d3722349833 Audit Layer Ext... Private     False     AutomatedAuditL... Customer Audit ...
#>

$TeamsApps = Get-TeamsApp 

$PollyTeamsApp = $TeamsApps | Where-Object {$_.DisplayName -eq "Polly"}



