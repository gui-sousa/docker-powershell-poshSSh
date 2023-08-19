# Define formato de data e hora para contatenar ao nome do arquivo
$timestamp = Get-Date -Format "dd-MM-yyyy-HHmmss"

# Variaveis Origem e Destino
$SFTPdestino = "."
$SFTPendereco = "ftp.gincobiloba.com"
$SFTPorigem = "/app/origem"
$SFTPprocessados = "/app/processados"
$SFTPtemp = "/app/temp"

#Variaveis de autentica��o
$SFTPpwd = ConvertTo-SecureString "password" -AsPlainText -Force
$SFTPcred = New-Object System.Management.Automation.PSCredential ("guizin", $SFTPpwd)

# Copia temporariamente os arquivos do drive virtual para a maquina local
$sourcePath = Join-Path $SFTPorigem "*"
Copy-Item -Path "$sourcePath" -Destination "$SFTPtemp" -Recurse

# Compressão dos arquivos em zip
Compress-Archive -Path "$SFTPtemp\*" -DestinationPath "$SFTPtemp\ARQUIVO_$timestamp.zip"
Copy-Item -Path "$SFTPtemp\ARQUIVO_$timestamp.zip" -Destination $SFTPprocessados
$SFTParquivo = "$SFTPtemp\ARQUIVO_$timestamp.zip"

#Conectando ao servidor FTP
$sessao = New-SFTPSession -Computer $SFTPendereco -Credential $SFTPcred -Force

#Copiando arquivos para o Host FTP
Set-SFTPItem -SFTPSession $sessao -Path $SFTParquivo -Destination $SFTPdestino
