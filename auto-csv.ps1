$1 = $env:SERVIDOR
$2 = $env:ORIGEM
$3 = $env:DESTINO

"$1" > SERVIDOR.txt
"$2" > ORIGEM.txt
"$3" > DESTINO.txt

$SERVIDOR = Get-Content SERVIDOR.txt
$ORIGEM = Get-Content ORIGEM.txt
$DESTINO = Get-Content DESTINO.txt

"Servidor,Origem,Destino" > listDeploy.txt
For ($i=0; $i -lt $SERVIDOR.count; $i++) {
    $SERVIDOR[$i],$ORIGEM[$i],$DESTINO[$i] -join ',' >> listDeploy.txt
}

Get-Content listDeploy.txt
