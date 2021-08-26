$change = "CHG006"
$deploy = 0
Import-Csv -Path "C:\Labs\code\3.txt" -Delimiter ";"| ForEach-Object {
    $date = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    $deploy = $deploy + 1
    Write-Host "$date - $server - INFO - Iniciando o deploy: $deploy."
    $server = $_.Servidor
    $origem = $_.Origem
    $destino = $_.Destino -replace ":","$"
    if (Test-Path \\$server\$destino){
        try {
            if (Test-Path \\$server\$destino\..\BKP_$change){
                Write-Host "$date - $server - INFO - Verificando diretorio de backup no servidor $server."
            } else {
                mkdir \\$server\$destino\..\BKP_$change -ErrorAction 'Stop' | Out-Null
                Write-Host "$date - $server - INFO - Criando diretorio para backup no servidor $server."
            }
            Copy-Item \\$server\$destino \\$server\$destino\..\BKP_$change -Recurse -ErrorAction 'Stop'
            try {
                Copy-Item $origem \\$server\$destino\..\ -Recurse -Force -ErrorAction 'Stop'
                Write-Host "$date - $server - INFO - Realizado copia dos arquivos no destino \\$server\$destino."
            }
            catch {
                Write-Host "$date - $server - ERRO - Nao foi possivel realizar a copia dos arquivos no camimnho \\$server\$destino, seguindo para proximo deploy."    
            }
        }
        catch {
            Write-Host "$date - $server - ERRO - Nao foi possivel realizar o backup dos arquivos no camimnho \\$server\$destino, seguindo para proximo deploy."
        }
    } else {
        Write-Host "$date - $server - ERRO - Nao foi possivel localizar o caminho \\$server\$destino, seguindo para proximo deploy."
    }
}
