"Servidor,Origem,Destino" > listDeploy.txt
For ($i=0; $i -lt $SERVIDOR.count; $i++) {
    $env:SERVIDOR[$i],$env:ORIGEM[$i],$env:DESTINO[$i] -join ',' >> listDeploy.txt
}

Get-Content listDeploy.txt
