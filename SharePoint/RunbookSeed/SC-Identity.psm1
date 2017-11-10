<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    Example of how to use this cmdlet
.EXAMPLE
    Another example of how to use this cmdlet
.INPUTS
    Inputs to this cmdlet (if any)
.OUTPUTS
    Output from this cmdlet (if any)
.NOTES
    General notes
.COMPONENT
    The component this cmdlet belongs to
.ROLE
    The role this cmdlet belongs to
.FUNCTIONALITY
    The functionality that best describes this cmdlet
#>
function Get-ConfigVariable {
    [CmdletBinding()]        
    [OutputType([string])]
    Param (        
        [Parameter(Mandatory=$true,Position=1)]
        [string]
        $Name,
        [Parameter(Mandatory=$true)]
        [ValidateSet("Azure","Local",IgnoreCase=$true)]                
        [string]
        $RunMode,        
        [string]
        $ConfigPath = "$($PSScriptRoot)\config.json",
        [switch]
        $Required        
    )
    
    begin {       
    }
    
    process {
        if ($RunMode -eq "Local") {
            Write-Verbose "Get Local Variable: [$($Name)] from path: [$($ConfigPath)]";
            if(!(Test-Path -Path $ConfigPath))
            {
                Write-Error "Could not locate config.json at '$($configPath)'";
            }

            $config = Get-Content $ConfigPath -Raw -ErrorAction:SilentlyContinue -WarningAction:SilentlyContinue | ConvertFrom-Json -ErrorAction:SilentlyContinue -WarningAction:SilentlyContinue
            $value = $config.$Name;
            Write-Verbose "Value for key [$($Name)]: $($value)";
        }else{
            Write-Verbose "Get Azure Automation Variable: [$($Name)]";
            $value = Get-AutomationVariable -Name $Name;
        }
        
        if($Required -and [string]::IsNullOrWhiteSpace($value)){
            throw "Required config variable value not found: [$($Name)]"
        }
        return $value;
    }    
    end {
    }
}

function Set-ConfigVariable {
    [CmdletBinding()]    
    [OutputType([String])]
    Param (        
        [Parameter(Mandatory=$true,Position=1)]
        [string]
        $Name,
        [Parameter(Mandatory=$true,Position=2)]
        $Value,
        [Parameter(Mandatory=$true)]
        [ValidateSet("Azure","Local",IgnoreCase=$true)]                
        [string]
        $RunMode,        
        [string]
        $ConfigPath = "$($PSScriptRoot)\config.json"        
    )
    
    begin {       
    }
    
    process {
        if ($RunMode -eq "Local") {
            # Write-Verbose "Get Local Variable: [$($Name)] from path: [$($ConfigPath)]";
            if(!(Test-Path -Path $ConfigPath))
            {
                Write-Error "Could not locate config.json at '$($configPath)'";
            }

            $config = Get-Content $ConfigPath -Raw -ErrorAction:SilentlyContinue -WarningAction:SilentlyContinue | ConvertFrom-Json -ErrorAction:SilentlyContinue -WarningAction:SilentlyContinue
            $oldValue = $config.$Name;
            Write-Verbose "Changing config value for key [$($Name)] from '$($oldValue)' to '$($value)'";
            if(!($config.PSobject.Properties.name -match $Name)){
                Write-Verbose "Prop doesnt exist... adding!";
                $config | Add-Member -Name $Name -MemberType NoteProperty -Value $value;
            }else{
                $config.$Name = $value;
            }

            $config | ConvertTo-Json | Set-Content -Path $ConfigPath;

            Write-Verbose "Done."

        }else{
            Write-Verbose "Set Azure Automation Variable: [$($Name)]"
            Set-AutomationVariable -Name $Name -Value $value;
        }
    }    
    end {
    }
}

<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-GraphAccessToken
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([string])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]
        $tenant,        
        [string]
        $clientId,
        [string]
        $clientSecret
    )

    Begin
    {
        Write-Verbose "Begin Get-GraphAccessToken";
    }
    Process
    {        
        $tokenRequestUri = "https://login.microsoft.com/$($tenant)/oauth2/token";
        $tokenRequestBody = @{
            resource= "https://graph.microsoft.com"
            client_id = $clientId            
            client_secret = $clientSecret
            grant_type = "client_credentials"
        };

        # Get Access Token
        $tokenResult = Invoke-RestMethod -Method POST -Uri $tokenRequestUri -Body $tokenRequestBody;        
        return $tokenResult.access_token;
    }
    End
    {
        Write-Verbose "Complete Get-GraphAccessToken";
    }
}



<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Execute-MSGraph
{
    [CmdletBinding()]
    [Alias()]    
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]
        $Tenant,

        # Param2 help description
        [string]
        $Resource,

        [string]
        $Link,

        [string]
        $AccessToken
    )

    Begin
    {
    }
    Process
    {
        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]";
        $headers.Add("Authorization", "Bearer $AccessToken");

        if([string]::IsNullOrEmpty($Link)){
            $graphUri = "https://graph.microsoft.com/v1.0/$($Tenant)/$($Resource.TrimStart('/'))";
        }else {
            $graphUri = $Link;
        }

        $result = Invoke-RestMethod -Headers $headers -Uri $graphUri;
        
        return $result;
    }
    End
    {
    }
}

function Get-UserDetail {
    [CmdletBinding()]
    param (        
        [Parameter(Mandatory=$true)]
        [string]
        $Id,

        [Parameter(Mandatory=$true)]
        [string]
        $TenantId,

        [Parameter(Mandatory=$true)]
        [string]
        $AccessToken
    )
    
    begin {
    }
    
    process {
        $userResourceUri = "/users/$($id)?`$select=id,displayName,givenName,surname,accountEnabled,userType,userPrincipalName,mail,onPremisesSyncEnabled,onPremisesImmutableId,onPremisesSecurityIdentifier"
        $userDetail = Execute-MSGraph -Tenant $TenantId -AccessToken $AccessToken -Resource $userResourceUri                
        return $userDetail;
    }
    
    end {
    }
}

function Should-UserBeSynced {
    [CmdletBinding()]
    param (
        [PSObject] $User
    )
        
    return ($User.id -ne $null -and $User.userPrincipalName -notmatch "#EXT#");        
}

function Generate-SASToken
{
    Param
    (
        [string]
        $ResourceUri,
        [string]
        $AccessPolicyName,
        [string]
        $AccessPolicyKey,
        [int]
        $ExpirySeconds
    )

    $sinceEpoch = (([datetime]::UtcNow) - (Get-Date -Year 1970 -Month 1 -Day 1 -Hour 0 -Minute 0 -Second 0)).TotalSeconds;
    $expiry = ($sinceEpoch + $ExpirySeconds).ToString();
    
    $encodedUri = [System.Web.HttpUtility]::UrlEncode($ResourceUri);
    $resourceAndExpiry = "$($encodedUri)`n$($expiry)"; 
    $hmacsha = New-Object System.Security.Cryptography.HMACSHA256;
    $hmacsha.Key = [System.Text.Encoding]::UTF8.GetBytes($AccessPolicyKey);
    $hash = $hmacsha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($resourceAndExpiry));
    $signature = [System.Convert]::ToBase64String($hash);
    $encodedSignature = [System.Web.HttpUtility]::UrlEncode($signature);
    $sasToken = "SharedAccessSignature sr=$($encodedUri)&sig=$($encodedSignature)&se=$($expiry)&skn=$($AccessPolicyName)";

    return $sasToken;
}

function Sync-EnsureUser
{
    [CmdletBinding()]
    [Alias()]    
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [PSObject]
        $User,

        # Param2 help description
        [string]
        $SASToken
    )

    #Write-Output "Sending control message: [$($Type)]`n$($Body)"

    # Endpoint=sb://sci-si-test.servicebus.windows.net/;
    # SharedAccessKeyName=SendAccessPolicy;
    # SharedAccessKey=E9wizucIoVBu7hZ4OXaaBrmF1ihpLD1Thh3MkPsDmJQ=;EntityPath=userinvitequeueEndpoint=sb://sci-si-test.servicebus.windows.net/;SharedAccessKeyName=SendAccessPolicy;SharedAccessKey=E9wizucIoVBu7hZ4OXaaBrmF1ihpLD1Thh3MkPsDmJQ=;EntityPath=userinvitequeue
    #$queueUri = "https://SCI-SI-TEST.servicebus.windows.net/userinvitequeue";
    $queueSendUri = "$($queueUri)/messages";


$keyName = "SendAccessPolicy";
$key = "E9wizucIoVBu7hZ4OXaaBrmF1ihpLD1Thh3MkPsDmJQ=";



Write-Output "SAS TOKEN: $($sasToken)";

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]";
    $headers.Add("Authorization", $sasToken);

    $result = Invoke-RestMethod -Method Post -Headers $headers -Uri $queueSendUri -Body $Body;
        
    
    Write-Output "Message send result:" $result;

}
