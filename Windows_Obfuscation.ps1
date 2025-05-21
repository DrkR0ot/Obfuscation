# Command obfuscation function
function Obfuscate-Command {
    param([string]$cmd)

    # Apply classic replacements
    $obfuscated = $cmd -replace "`t", "%09"
    $obfuscated = $obfuscated -replace " ", '$env:PROGRAMFILES[10]'
    $obfuscated = $obfuscated -replace "\\", '$env:HOMEPATH[0]'

    # Check if the command is unchanged after obfuscation attempt
    if ($obfuscated -eq $cmd) {
        Write-Host "`n⚠ No specific character was modified." -ForegroundColor Yellow
        Write-Host "💡 Possible obfuscation examples:" -ForegroundColor Cyan
        Write-Host "   - Use random uppercase letters: WhoAmI" -ForegroundColor Yellow
        Write-Host "   - Add double quotes: who''ami" -ForegroundColor Yellow
        Write-Host "   - Rename all your variables" -ForegroundColor Yellow
        Write-Host "   - Obfuscation using Get-Command." -ForegroundColor Yellow
        Write-Host "         Example: Write-Output Test = &(gcm W**************-*u*****************t) Test" -ForegroundColor Yellow
    } else {
        Write-Host "`n🔹 Obfuscated command:" -ForegroundColor Cyan
        Write-Host $obfuscated
    }
}

# Command reversal function
function Reverse-Command {
    param([string]$cmd)
    $reversed = ($cmd[-1..-$cmd.Length] -join '')

    Write-Host "`n🔹 Reversed command:" -ForegroundColor Cyan
    Write-Host $reversed

    Write-Host "`n💡 To execute your command, use:" -ForegroundColor Yellow
    Write-Host "iex `"`$('$reversed'[-1..-30] -join '')`"" -ForegroundColor Green
}

# Base64 encoding function
function Encode-Base64 {
    param([string]$cmd)
    $base64 = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($cmd))

    Write-Host "`n🔹 Command encoded in Base64:" -ForegroundColor Cyan
    Write-Host $base64

    Write-Host "`n💡 To execute your command, use:" -ForegroundColor Yellow
    Write-Host "iex `"`$([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String('$base64')))`"" -ForegroundColor Green
}

# Interactive menu
while ($true) {
    # Ask the user to enter a command
    $cmd = Read-Host "Enter the command to modify"

    # Check if the command is not empty
    if ([string]::IsNullOrWhiteSpace($cmd)) {
        Write-Host "❌ Error: You must enter a command!" -ForegroundColor Red
        continue
    }

    Write-Host "`n🔹 What would you like to do with this command?"
    Write-Host "1. Obfuscate the command"
    Write-Host "2. Reverse the command"
    Write-Host "3. Encode in Base64"
    Write-Host "4. Exit"

    # Ask the user for their choice
    $choice = Read-Host "Enter your choice (1-4)"

    switch ($choice) {
        1 { Obfuscate-Command $cmd }
        2 { Reverse-Command $cmd }
        3 { Encode-Base64 $cmd }
        4 {
            Write-Host "👋 Goodbye!" -ForegroundColor Green
            break
        }
        default {
            Write-Host "❌ Invalid option, please choose between 1 and 4." -ForegroundColor Red
        }
    }

    Write-Host "`n🔄 Returning to menu..."
}
