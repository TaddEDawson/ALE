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
        Audit Layer application Class
    .EXAMPLE
        # instantiate a new object of the application class
        $application = [application]::New()

        # assign values to the properties
        $application.appName = "TheApp"
        $application.hostname = "TheHost"
        $application.network = "TheNetwork"
        $application.domain = "TheDomain"
        $application.environmentType = "PROD"
        $application.version = "0.1.0.0"

        # display the object
        $application

        appName          : TheApp
        hostname         : TheHost
        network          : TheNetwork
        domain           : TheDomain
        environmentType  : PROD
        containsProdData : True
        version          : 0.1.0.0
#>
Class application 
{
    [System.String] $appName = $null
    [System.String] $hostname = $null
    [System.String] $network = $null
    [System.String] $domain = $null
    [System.String] $environmentType = $null
    [System.String] $containsProdData = $true
    [System.String] $version = $null
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

#>
Class identifiers
{

} # End Class identifiers

<#
    .SYNOPSIS
        identity
    .EXAMPLE

#>
Class identity
{

} # End Class identity

<#
    .SYNOPSIS
        item
    .EXAMPLE

#>
Class item
{

} # End Class item

<#
    .SYNOPSIS
        outcome
    .EXAMPLE

#>
Class outcome
{

} # End Class outcome

<#
    .SYNOPSIS
        page
    .EXAMPLE

#>
Class page
{

} # End Class page

<#
    .SYNOPSIS
        AuditEntry
    .EXAMPLE

#>
Class AuditEntry
{

} # End Class AuditEntry

<#
    .SYNOPSIS
        ItemEntry
    .EXAMPLE

#>
Class ItemEntry : AuditEntry
{

} # End Class ItemEntry

<#
    .SYNOPSIS
        PingEntry
    .EXAMPLE

#>
Class PingEntry
{

} # End Class PingEntry

<#
    .SYNOPSIS
        search
    .EXAMPLE

#>
Class search
{

} # End Class search

<#
    .SYNOPSIS
        SearchEntry
    .EXAMPLE

#>
Class SearchEntry : AuditEntry
{

} # End Class SearchEntry

<#
    .SYNOPSIS
        WebEntry
    .EXAMPLE

#>
Class WebEntry : AuditEntry
{

} # End Class WebEntry
# End Classes
