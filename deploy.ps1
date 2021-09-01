$change = "$env:SCTASKNUMBER"
$deploy = 1
if ($change -eq "") {
    $date = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    Write-Output "$date - ERRO - Nao foi informado o numero da mudanca."
} else { 
    if (Test-Path .\listDeploy.csv) {
        Rename-Item .\listDeploy.csv -NewName listDeploy_$change.csv -Force
        Write-Output "========================================================================================================================================" > log.txt
        Import-Csv -Path ".\listDeploy_$change.csv" -Delimiter ";"| ForEach-Object {
            $date = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
            $deploy = $deploy + 1
            $server = $_.Servidor
            $origem = $_.Origem
            $destino = $_.Destino -replace ":","$"
            Write-Output "$date - $server - INFO - Iniciando o deploy da linha $deploy do listDeploy.csv."
            Write-Output "$date - $server - INFO - Iniciando o deploy da linha $deploy do listDeploy.csv." >> log.txt
            if (Test-Path \\$server\$destino){
                if (Test-Path $origem) {
                    try {
                        if (Test-Path \\$server\$destino\..\BKP_$change){
                            Write-Output "$date - $server - INFO - Verificando diretorio de backup no servidor $server."
                            Write-Output "$date - $server - INFO - Verificando diretorio de backup no servidor $server." >> log.txt
                        } else {
                            mkdir \\$server\$destino\..\BKP_$change -ErrorAction 'Stop' | Out-Null
                            Write-Output "$date - $server - INFO - Criando diretorio para backup no servidor $server."
                            Write-Output "$date - $server - INFO - Criando diretorio para backup no servidor $server." >> log.txt
                        }
                        Copy-Item \\$server\$destino \\$server\$destino\..\BKP_$change -Recurse -ErrorAction 'Stop'
                        try {
                            Copy-Item $origem \\$server\$destino\..\ -Recurse -Force -ErrorAction 'Stop'
                            Write-Output "$date - $server - INFO - Realizado copia dos arquivos no destino \\$server\$destino."
                            Write-Output "$date - $server - INFO - Realizado copia dos arquivos no destino \\$server\$destino." >> log.txt
                        }
                        catch {
                            Write-Output "$date - $server - ERRO - Nao foi possivel realizar a copia dos arquivos no camimnho \\$server\$destino, seguindo para proximo deploy."
                            Write-Output "$date - $server - ERRO - Nao foi possivel realizar a copia dos arquivos no camimnho \\$server\$destino, seguindo para proximo deploy." >> log.txt
                        }
                    }
                    catch {
                        Write-Output "$date - $server - ERRO - Nao foi possivel realizar o backup dos arquivos no camimnho \\$server\$destino, seguindo para proximo deploy."
                        Write-Output "$date - $server - ERRO - Nao foi possivel realizar o backup dos arquivos no camimnho \\$server\$destino, seguindo para proximo deploy." >> log.txt
                    }
                } else {
                    Write-Output "$date - $server - ERRO - Nao existe pacote no caminho $origem, seguindo para proximo deploy."
                    Write-Output "$date - $server - ERRO - Nao existe pacote no caminho $origem, seguindo para proximo deploy." >> log.txt
                }                
            } else {
                Write-Output "$date - $server - ERRO - Nao existe o caminho \\$server\$destino, seguindo para proximo deploy."
                Write-Output "$date - $server - ERRO - Nao existe o caminho \\$server\$destino, seguindo para proximo deploy." >> log.txt
            }
        }
        Write-Output "========================================================================================================================================" >> log.txt
        Remove-Item .\listDeploy_$change.csv
    } else {
        $date = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
        Write-Output "$date - ERRO - Nao existe listDeploy.csv em anexo."
    }
}
