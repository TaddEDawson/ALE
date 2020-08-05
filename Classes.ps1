<#
    .SYNOPSIS
        Class definitions for Audit Layer Extraction

    .DESCRIPTION
        Define classes and subclasses for reuse in ALE from M365
        Class names are case sensitive for the generation of JSON for internal application
        Order of definition important for reuse
#>
<#
    .SYNOPSIS

    .EXAMPLE
        $Config = [Config]::New()        
#>
Class Config
{
    [System.String] $appName = "TheApp"
    [System.String] $hostname = "TheHost"
    [System.String] $network = "TheNetwork"
    [System.String] $domain = "TheDomain"
    [System.String] $environmentType = "PROD"
    [System.Boolean] $containsProdData = $true
    [System.String] $version = "0.1.0.0"
} # End Class Config


<#
    .SYNOPSIS
        Audit Layer application Class
    .EXAMPLE
        # instantiate a new object of the application class
        $application = [application]::New()

        # display the object
        $application

        appName          : TheApp
        hostname         : TheHost
        network          : TheNetwork
        domain           : TheDomain
        environmentType  : PROD
        containsProdData : True
        version          : 0.1.0.0

        # Review setting defaults for given environment
#>
Class application 
{
    [System.String] $appName = $Config.appName
    [System.String] $hostname = $Config.hostname
    [System.String] $network = $Config.network
    [System.String] $domain = $Config.domain
    [System.String] $environmentType = $Config.environmentType
    [System.String] $containsProdData = $Config.containsProdData
    [System.String] $version = $Config.version
} # End Class application

<#
    .SYNOPSIS
        Audit Layer EventSubmission Class
    .EXAMPLE
        # instantiate a new object of the EventSubmission class
        $EventSubmission = [EventSubmission]::New()
        
        # Assign values to the object properties (or accept defaults)
        $EventSubmission.appName= $application.appName
        $EventSubmission.environmentType= $application.environmentType

        # Display the object
        $EventSubmission

#>
Class EventSubmission
{
    [System.DateTime] $TimeSubmitted = [DateTime]::Now
    [System.String] $eventUuid = $null
    [System.String] $appName = $null
    [System.String] $environmentType = $null
    [System.String] $eventType = $null
    [System.String] $actionType = $null
    [System.String] $submittedTo = $null
    [System.String] $response = $null
} # End Class EventSubmission

<#
    .SYNOPSIS
        Class EventCounts is used to keep track of the types of Events that occured and submitted

    .EXAMPLE
        # Instantiate a new EventCounts object
        $EventCounts = [EventCounts]::New()

        # Increment the current value of ACCOUNTS
        $EventCounts.Accounts = 3

        # Display the property values
        $EventCounts
#>
Class EventCounts
{
    [System.Int16] $ACCOUNTS = 0
    [System.Int16] $ITEMS = 0
    [System.Int16] $ERRORS = 0
    [System.Int16] $MESSAGES = 0
    [System.Int16] $PERMISSIONS = 0
    [System.Int16] $PING = 0
    [System.Int16] $SEARCHES = 0
    [System.Int16] $SESSIONS = 0
    [System.Int16] $WEB = 0
    [System.Int16] $COMMANDS = 0
} # End Class EventCOunts

<#
    .SYNOPSIS
        Header for Bulk file
    .EXAMPLE
        $BulkFileHeader = [BulkFileHeader]::New()
        $BulkFileHeader.appName = $application.appName
        $BulkFileHeader | ConvertTo-JSON

#>
Class BulkFileHeader 
{
    [System.Int16] $apiVersion = 1
    [System.String] $appName = $null
    [System.String] $uuid = [Guid]::NewGuid().ToString()
} # End Class BulkFileHeader

<#
    .SYNOPSIS

    .EXAMPLE
        $BulkFileSubmission = [BulkFileSubmission]::New()
#>
Class BulkFileSubmission
{
    [System.DateTime] $Date = [DateTime]::Now
    [System.String] $FileName = $null
    [System.Int16] $LinesOfContent = $null
    [Long] $FileSize = $null
    [System.DateTime] $earliest = [DateTime]::Now
    [System.DateTime] $latest = [DateTime]::Now
    [System.String] $Uri = $null
    [System.String] $Exception = $null
    [System.Int16] $IWRStatus = $null
    [System.String] $success = $null
    [System.String] $message = $null
    [System.String] $submitted = $null
    [System.String] $processed = $null
} # End Class BulkFileSubmission

<#
    .SYNOPSIS

    .EXAMPLE
        $computer = [computer]::New()
        $computer.hostname = $ENV:COMPUTERNAME
        $computer.domain = $application.domain

#>
Class computer
{
    [System.String] $hostname = $null
    [System.String] $domain = $null
} # End Class computer

<#
    .SYNOPSIS
        identifiers
    .EXAMPLE
        [identifiers]::New()

#>
Class identifiers
{
    [System.String] $username = "None"
    [System.String] $usernameType = "None"
    [System.String] $distinguishedName = "None"
    [System.String] $employeeNumber = "None"
    [System.String] $LoginName = "None"
    [System.String] $CWEID = "None"
    [System.String] $Email = "None"

} # End Class identifiers

<#
    .SYNOPSIS
        identity
    .EXAMPLE
        $identity = [identity]::New()

#>
Class identity
{
    [System.Object] $identifiers = [identifiers]::New()
    [System.String] $label = "None"
    [System.Boolean] $backgroundAgent = $false
    [System.String] $privilegelevel = "None"
} # End Class identity

<#
    .SYNOPSIS
        item
    .EXAMPLE
        $item = [item]::New()

#>
Class item
{
    # used to determine properties for item identifiers, this is different that identity identifiers
    $Identifiers = @{
        "key" = "value"
        }
    [System.String] $label = "None"
    [System.String] $ItemType = "None"
} # End Class item

<#
    .SYNOPSIS
        outcome
    .EXAMPLE
        $outcome = [outcome]::New()

#>
Class outcome
{
    [System.Boolean] $success = $false
    [System.Int16] $code = $null
    [System.String] $message = "None"
} # End Class outcome

<#
    .SYNOPSIS
        page
    .EXAMPLE
        $page = [page]::New()

#>
Class page
{
    [System.String] $url = "None"
    [System.String] $method = "GET"
    [System.String] $useragent = "None"
    [System.String] $referer = "None"
    [System.String] $contentMediaType = "text/html"
    [System.Int64] $duration = 0
} # End Class page

<#
    .SYNOPSIS
        AuditEntry
    .EXAMPLE
        [AuditEntry]::New()

#>
Class AuditEntry
{
    [System.String] $eventUuid = ([System.Guid]::NewGuid()).guid
    [System.Object] $application = [application]::New()
    [System.String] $eventClassification = "UNCLASSIFIED"
    [System.String] $eventType = '{0:yyy-MM-ddTHH:mm:ssZ}' -f (Get-Date).ToUniversalTime()

} # End Class AuditEntry

<#
    .SYNOPSIS
        ItemEntry
    .EXAMPLE
        [ItemEntry]::New() | ConvertTo-JSON -depth 3

#>
Class ItemEntry : AuditEntry
{
    [System.String] $eventType = "ITEMS"
    [System.String] $actionType = "LISTED"
} # End Class ItemEntry

<#
    .SYNOPSIS
        PingEntry
    .EXAMPLE
        [PingEntry]::New() | ConvertTo-JSON -depth 3
#>
Class PingEntry : AuditEntry
{
    [System.String] $eventType = "PING"
    [System.String] $actionType = "UPDATED"   
} # End Class PingEntry

<#
    .SYNOPSIS
        search
    .EXAMPLE
        [search]::New()
#>
Class search
{
    [System.Array] $datasources = @()
    [System.String] $searchText = "None Search Query"
} # End Class search

<#
    .SYNOPSIS
        SearchEntry
    .EXAMPLE
        [SearchEntry]::New() | ConvertTo-JSON -depth 3
#>
Class SearchEntry : AuditEntry
{
    [System.String] $eventType = "SEARCHES"
    [System.String] $actionType = "ENDED"
    [System.Int16] $totalResultCount = 0
    [System.Object] $search = [search]::New()
    [System.Object] $identity = [identity]::New()
    [System.Object] $outcome = [outcome]::New()
} # End Class SearchEntry

<#
    .SYNOPSIS
        WebEntry
    .EXAMPLE
        [WebEntry]::New() | ConvertTo-JSON -depth 3
#>
Class WebEntry : AuditEntry
{
    [System.String] $eventType = "WEB"
    [System.String] $actionType = "READ"
    [System.String] $server = "None"
    [System.Object] $identity = [identity]::New()
    [System.Object] $page = [page]::New()
    [System.Object] $outcome = [outcome]::New()
} # End Class WebEntry
# End Classes