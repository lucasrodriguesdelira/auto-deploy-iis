"$env:SERVIDOR" -replace ',',"`n" > SERVIDOR.txt
"$env:ORIGEM" -replace ',',"`n" > ORIGEM.txt
"$env:DESTINO" -replace ',',"`n" > DESTINO.txt

$SERVIDOR = Get-Content SERVIDOR.txt
$ORIGEM = Get-Content ORIGEM.txt
$DESTINO = Get-Content DESTINO.txt

For ($i=0; $i -lt $SERVIDOR.count; $i++) {
    $SERVIDOR[$i],$ORIGEM[$i],$DESTINO[$i] -join ','
}
