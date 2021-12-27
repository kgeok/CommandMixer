Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='CommandMixer'
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
$File = New-Object System.Windows.Forms.ComboBox
$File.Width = 300
$zonesinput = 4
$posxcounter = 0
$zones = $zonesinput * $zonesinput
[xml]$ToastTemplate = @"
<toast>
    <visual>
        <binding template="ToastImageAndText03">
            <text id="1">CommandMixer</text>
            <text id="2">Version 0.1, With Love by Kevin George, http://kgeok.github.io</text>
        </binding>
    </visual>
</toast>
"@

$PingData = [Windows.Data.Xml.Dom.XmlDocument]::New()
$PingData.LoadXml($ToastTemplate.OuterXml)
$File.Location  = New-Object System.Drawing.Point(5,10)
$main_form.Controls.Add($File)

$OpenButton = New-Object System.Windows.Forms.Button
$OpenButton.Location = New-Object System.Drawing.Size(5,50)
$OpenButton.Size = New-Object System.Drawing.Size(100,23)
$OpenButton.Text = "Open"
$main_form.Controls.Add($OpenButton)

$GenButton = New-Object System.Windows.Forms.Button
$GenButton.Location = New-Object System.Drawing.Size(105,50)
$GenButton.Size = New-Object System.Drawing.Size(100,23)
$GenButton.Text = "Build"
$main_form.Controls.Add($GenButton)

$AboutButton = New-Object System.Windows.Forms.Button
$AboutButton.Location = New-Object System.Drawing.Size(205,50)
$AboutButton.Size = New-Object System.Drawing.Size(100,23)
$AboutButton.Text = "About"
$main_form.Controls.Add($AboutButton)


$OpenButton.Add_Click({

$File.Items.Remove($FileBrowser.filename);
$FileBrowser.ShowDialog()
$File.Items.Add($FileBrowser.filename);
$content = Get-Content $FileBrowser.filename 
$content = ConvertFrom-Json –InputObject Get-Content $content
Write-Host $content

})

$AboutButton.Add_Click({

$Notification = [Windows.UI.Notifications.ToastNotification]::New($PingData)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe").Show($Notification)


})


$GenButton.Add_Click(
{


for (($i = 0); $i -lt ($zones); $i++){


If ($i % $zonesinput -eq 0){

$posx = 0
$posxcounter = 1
$posy = $posy + 100

}

If ($i % $zonesinput -ne 0){

$posx = $posxcounter * 100
$posxcounter = $posxcounter + 1

}

$j = New-Object System.Windows.Forms.Button
$j.Location = New-Object System.Drawing.Size(($posx + 5),$posy)
$j.Size = New-Object System.Drawing.Size(100,100)
$j.Text = "X"
$main_form.Controls.Add($j)

$j.Add_Click(
{


})

}

})

$main_form.Width = 300
$main_form.Height = 100
$main_form.AutoSize = $true
$main_form.ShowDialog()
