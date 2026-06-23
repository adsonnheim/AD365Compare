$EnvFilePath = ".\.env.local"

If (-not (Test-Path $EnvFilePath -PathType Leaf)) {
    Write-Error "Error: .env.local file not found at $($EnvFilePath)"
    Exit 1
}

$Env = @{}
$EnvLines = Get-Content $EnvFilePath

ForEach ($Line in $EnvLines) {
    $TrimmedLine = $Line.Trim()

    If ([string]::IsNullOrEmpty($TrimmedLine) -or $TrimmedLine.StartsWith('#')) {
        Continue
    }

    $Name, $Value = $TrimmedLine -split '=', 2
    $Env.Add($Name, $Value)
}

Connect-MgGraph -Scopes "User.Read.All"

$365Users = @(Get-MgUser -All | Select-Object -ExpandProperty DisplayName)

$Trimmed365Users = @()

ForEach ($365User in $365Users) {
    $Trimmed365Users += ($365User -replace '\s+', ' ').Trim()
}

$ADUsers = @(Get-ADUser -Filter {Enabled -eq $true} -SearchBase $Env["SEARCH_BASE"] | Select-Object -ExpandProperty Name)

$TrimmedADUsers = @()

ForEach ($ADUser in $ADUsers) {
    $TrimmedADUsers += ($ADUser -replace '\s+', ' ').Trim()
}

ForEach ($Trimmed365User in $Trimmed365Users) {
    If (-not ($TrimmedADUsers -contains $Trimmed365User)) {
        Write-Host $Trimmed365User "is present in Microsoft 365 but inconsistent with Active Directory!" -BackgroundColor Green
    }
}

ForEach ($TrimmedADUser in $TrimmedADUsers) {
    If (-not ($Trimmed365Users -contains $TrimmedADUser)) {
        Write-Host $TrimmedADUser "is present in Active Directory but inconsistent with Microsoft 365!" -BackgroundColor DarkYellow
    }
}