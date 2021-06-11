Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='CommandMixer'
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null
$FileLabel = New-Object System.Windows.Forms.Label
$FileLabel.Text = "File:"
$FileLabel.Location  = New-Object System.Drawing.Point(5,10)
$FileLabel.AutoSize = $true
$main_form.Controls.Add($FileLabel)
$File = New-Object System.Windows.Forms.ComboBox
$File.Width = 300
$aob = 10
[xml]$ToastTemplate = @"
<toast>
    <visual>
        <binding template="ToastImageAndText03">
            <text id="1">CommandMixer</text>
            <text id="2">Boop.</text>
        </binding>
    </visual>
</toast>
"@
$File.Items.Add("File");
$PingData = [Windows.Data.Xml.Dom.XmlDocument]::New()
$PingData.LoadXml($ToastTemplate.OuterXml)
$File.Location  = New-Object System.Drawing.Point(75,10)
$main_form.Controls.Add($File)


$GenButton = New-Object System.Windows.Forms.Button
$GenButton.Location = New-Object System.Drawing.Size(400,10)
$GenButton.Size = New-Object System.Drawing.Size(120,23)
$GenButton.Text = "Open"
$main_form.Controls.Add($GenButton)


$GenButton.Add_Click(
{

$Notification = [Windows.UI.Notifications.ToastNotification]::New($PingData)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe").Show($Notification)

for (($i = 0); $i -lt $aob; $i++){

$j = $i

$posx = $j * 100
$posy = $j * 100

$j = New-Object System.Windows.Forms.Button
$j.Location = New-Object System.Drawing.Size($posx,50)
$j.Size = New-Object System.Drawing.Size(100,100)
$j.Text = "X"
$main_form.Controls.Add($j)

$j.Add_Click(
{

$Notification = [Windows.UI.Notifications.ToastNotification]::New($PingData)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe").Show($Notification)


})


}

})




$main_form.Width = 400
$main_form.Height = 400
$main_form.AutoSize = $true
$main_form.ShowDialog()