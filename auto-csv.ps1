$SERVIDOR = $env:SERVIDOR
$ORIGEM   = $env:ORIGEM
$DESTINO  = $env:DESTINO

"Servidor;Origem;Destino" > listDeploy.csv
For ($i=0; $i -lt $SERVIDOR.count; $i++) {
    $SERVIDOR[$i],$ORIGEM[$i],$DESTINO[$i] -join ';' >> listDeploy.csv
}
