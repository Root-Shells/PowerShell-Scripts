$listenerIP = '0.0.0.0'
$listenerPort = 4444

$listener = New-Object System.Net.Sockets.TcpListener([IPAddress]::Parse($listenerIP), $listenerPort)
$listener.Start()

Write-Host "Listening on port $listenerPort..."

$client = $listener.AcceptTcpClient()
$stream = $client.GetStream()

Write-Host "Connection received!"

[byte[]]$bytes = 0..65535 | ForEach-Object { 0 }

while (($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0) {
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes, 0, $i)
    Write-Host $data
}

$client.Close()
$listener.Stop()
