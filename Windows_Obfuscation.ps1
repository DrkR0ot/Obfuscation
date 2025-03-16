# Fonction d'obfuscation de la commande
function Obfuscate-Command {
    param([string]$cmd)

    # Appliquer les remplacements classiques
    $obfuscated = $cmd -replace "`t", "%09" `
                       -replace " ", '$env:PROGRAMFILES[10]' `
                       -replace "\\", '$env:HOMEPATH[0]'

    # Vérifier si la commande est identique après tentative d'obfuscation
    if ($obfuscated -eq $cmd) {
        Write-Host "`n⚠️  Aucun caractère spécifique n'a été modifié." -ForegroundColor Yellow
        Write-Host "💡 Exemples d'obfuscation possibles :" -ForegroundColor Cyan
        Write-Host "   - Mettre des majuscules aléatoires : WhoAmI"
        Write-Host "   - Ajouter des doubles apostrophes : who''ami"
    } else {
        Write-Host "`n🔹 Commande obfusquée :" -ForegroundColor Cyan
        Write-Host $obfuscated
    }
}

# Fonction d'inversion de la commande
function Reverse-Command {
    param([string]$cmd)
    $reversed = ($cmd[-1..-$cmd.Length] -join '')

    Write-Host "`n🔹 Commande inversée :" -ForegroundColor Cyan
    Write-Host $reversed

    Write-Host "`n💡 Pour exécuter votre commande, utilisez :" -ForegroundColor Yellow
    Write-Host "iex `"`$('$reversed'[-1..-30] -join '')`"" -ForegroundColor Green
}

# Fonction d'encodage Base64
function Encode-Base64 {
    param([string]$cmd)
    $base64 = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($cmd))
    
    Write-Host "`n🔹 Commande encodée en Base64 :" -ForegroundColor Cyan
    Write-Host $base64

    Write-Host "`n💡 Pour exécuter votre commande, utilisez :" -ForegroundColor Yellow
    Write-Host "iex `"`$([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String('$base64')))`"" -ForegroundColor Green
}

# Menu interactif
while ($true) {
    # Demande à l'utilisateur de saisir une commande
    $cmd = Read-Host "Entrez la commande à modifier"

    # Vérifie si la commande n'est pas vide
    if ([string]::IsNullOrWhiteSpace($cmd)) {
        Write-Host "❌ Erreur : Vous devez entrer une commande !" -ForegroundColor Red
        continue
    }

    Write-Host "`n🔹 Que voulez-vous faire avec cette commande ?"
    Write-Host "1. Obfusquer la commande"
    Write-Host "2. Inverser la commande"
    Write-Host "3. Encoder en Base64"
    Write-Host "4. Quitter"

    # Demande le choix de l'utilisateur
    $choice = Read-Host "Entrez votre choix (1-4)"

    switch ($choice) {
        1 { Obfuscate-Command $cmd }
        2 { Reverse-Command $cmd }
        3 { Encode-Base64 $cmd }
        4 { Write-Host "👋 Au revoir !" -ForegroundColor Green
            break }
        default { Write-Host "❌ Option invalide, veuillez choisir entre 1 et 4." -ForegroundColor Red }
    }

    Write-Host "`n🔄 Retour au menu..."
}
