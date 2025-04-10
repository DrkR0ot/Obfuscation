# Fonction d'obfuscation de la commande
function Obfuscate-Command {

        Write-Host "💡 Exemples d'obfuscation possibles :" -ForegroundColor Cyan
        Write-Host "   - Mettre des majuscules aléatoires : WhoAmI" -ForegroundColor Yellow
        Write-Host "   - Ajouter des guillements simples ou doubles : who''ami" -ForegroundColor Yellow
        Write-Host "   - Ajouter, supprimer, modifier les commentaires de votre script" -ForegroundColor Yellow
        Write-Host "   - Modifier les noms de toutes vos variables" -ForegroundColor Yellow
        Write-Host "   - Obfuscations par la commande Get-Command. " -ForegroundColor Yellow
        Write-Host "         Exemple : Write-Output Test = &(gcm W**************-*u*****************t) Test" -ForegroundColor Yellow
}

# Fonction d'inversion de la commande
function Reverse-Command {
    param([string]$cmd)
    $reversed = ($cmd[-1..-$cmd.Length] -join '')

    Write-Host "`n🔹 Commande inversée :" -ForegroundColor Cyan
    Write-Host $reversed

    Write-Host "`n💡 Pour exécuter votre commande, utilisez :" -ForegroundColor Yellow
    Write-Host "iex `"`$('$reversed'[-1..-300] -join '')`"" -ForegroundColor Green
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
