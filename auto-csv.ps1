"$env:SERVIDOR" > SERVIDOR.txt
"$env:ORIGEM" > ORIGEM.txt
"$env:DESTINO" > DESTINO.txt

$SERVIDOR = Get-Content SERVIDOR.txt
$ORIGEM = Get-Content ORIGEM.txt
$DESTINO = Get-Content DESTINO.txt

"Servidor,Origem,Destino" > listDeploy.txt
For ($i=0; $i -lt $SERVIDOR.count; $i++) {
    $SERVIDOR[$i],$ORIGEM[$i],$DESTINO[$i] -join ','
}
