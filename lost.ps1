Add-Type -AssemblyName PresentationFramework, System.Windows.Forms, System.Drawing

$xml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="LOST ENGINE | SUPREME TWEAKS" Height="850" Width="1200" Background="#121317" WindowStartupLocation="CenterScreen">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="60"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="60"/>
        </Grid.RowDefinitions>

        <Border Grid.Row="0" Background="#1c1e26" BorderBrush="Cyan" BorderThickness="0,0,0,1">
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Center">
                <Button x:Name="TabInstall" Content="Install" Width="120" Height="40" Background="Transparent" Foreground="White" BorderThickness="0" Margin="5" Cursor="Hand"/>
                <Button x:Name="TabTweaks" Content="Tweaks" Width="120" Height="40" Background="#2d303d" Foreground="Cyan" BorderThickness="1" BorderBrush="Cyan" Margin="5" Cursor="Hand"/>
                <Button x:Name="TabConfig" Content="Config" Width="120" Height="40" Background="Transparent" Foreground="White" BorderThickness="0" Margin="5" Cursor="Hand"/>
                <Button x:Name="TabUpdates" Content="Updates" Width="120" Height="40" Background="Transparent" Foreground="White" BorderThickness="0" Margin="5" Cursor="Hand"/>
                <Button x:Name="TabMicroWin" Content="MicroWin" Width="120" Height="40" Background="Transparent" Foreground="White" BorderThickness="0" Margin="5" Cursor="Hand"/>
            </StackPanel>
        </Border>

        <ScrollViewer Grid.Row="1" Margin="10" VerticalScrollBarVisibility="Auto">
            <StackPanel x:Name="MainContent">
                
                <Grid x:Name="TweaksPanel" Visibility="Visible">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>

                    <StackPanel Grid.Column="0" Margin="15">
                        <TextBlock Text="Essential Tweaks" Foreground="DodgerBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                        <CheckBox x:Name="chkRestore" Content="Create Restore Point" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkTemp" Content="Delete Temporary Files" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkTele" Content="Disable Telemetry" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkDVR" Content="Disable GameDVR" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkPower" Content="Lost e Vinizin Oprimizer Plan" Foreground="White" Margin="0,4"/>
                        
                        <TextBlock Text="Advanced Tweaks - CAUTION" Foreground="OrangeRed" FontSize="18" FontWeight="Bold" Margin="0,25,0,15"/>
                        <CheckBox x:Name="chkEdge" Content="Edge Debloat" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkRecall" Content="Disable AI Recall (W11)" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkIPv6" Content="Disable IPv6" Foreground="White" Margin="0,4"/>
                    </StackPanel>

                    <StackPanel Grid.Column="1" Margin="15">
                        <TextBlock Text="Customize Preferences" Foreground="DodgerBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                        <CheckBox x:Name="chkDark" Content="Dark Theme for Windows" IsChecked="True" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkMouse" Content="Disable Mouse Acceleration" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkHidden" Content="Show Hidden Files" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkTask" Content="Center Taskbar (W10/11)" Foreground="White" Margin="0,4"/>
                        
                        <TextBlock Text="Performance Plans" Foreground="Cyan" FontSize="18" FontWeight="Bold" Margin="0,25,0,15"/>
                        <Button x:Name="BtnUltimate" Content="Add and Activate Ultimate Performance Profile" Height="35" Background="#2d303d" Foreground="White" Margin="0,5"/>
                    </StackPanel>
                </Grid>

                <StackPanel x:Name="ConfigPanel" Visibility="Collapsed" Margin="15">
                    <TextBlock Text="System Features" Foreground="DodgerBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,10"/>
                    <CheckBox x:Name="chkDotNet" Content="All .NET Frameworks" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="chkHyperV" Content="Hyper-V Virtualization" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="chkWSL" Content="Windows Subsystem for Linux (WSL)" Foreground="White" Margin="0,4"/>
                    <Button x:Name="BtnFixNet" Content="Reset Network" Height="35" Width="200" HorizontalAlignment="Left" Background="#2d303d" Foreground="White" Margin="0,15"/>
                </StackPanel>

            </StackPanel>
        </ScrollViewer>

        <Border Grid.Row="2" Background="#1c1e26" BorderBrush="Cyan" BorderThickness="0,1,0,0">
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Left" Margin="25,0">
                <Button x:Name="RunBtn" Content="RUN TWEAKS" Width="220" Height="40" Background="RoyalBlue" Foreground="White" FontWeight="Bold" Margin="0,0,15,0" Cursor="Hand"/>
                <Button x:Name="UndoBtn" Content="UNDO SELECTED" Width="220" Height="40" Background="#2d303d" Foreground="White" FontWeight="Bold" Cursor="Hand"/>
            </StackPanel>
        </Border>
    </Grid>
</Window>
"@

$reader = [XML.XmlReader]::Create([System.IO.StringReader]$xml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- LÓGICA DE NAVEGAÇÃO ---
$TweaksPanel = $window.FindName("TweaksPanel")
$ConfigPanel = $window.FindName("ConfigPanel")

$window.FindName("TabTweaks").Add_Click({ $TweaksPanel.Visibility = "Visible"; $ConfigPanel.Visibility = "Collapsed" })
$window.FindName("TabConfig").Add_Click({ $TweaksPanel.Visibility = "Collapsed"; $ConfigPanel.Visibility = "Visible" })

# --- FUNÇÃO DE ENERGIA PERSONALIZADA ---
$window.FindName("RunBtn").Add_Click({
    if ($window.FindName("chkPower").IsChecked) {
        Write-Host "Configurando Plano: Lost e Vinizin Oprimizer..." -ForegroundColor Cyan
        $guid = (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61).Split(' ')[-1]
        powercfg -changename $guid "Lost e Vinizin Oprimizer"
        powercfg /setactive $guid
    }
    
    # Adicione aqui os demais comandos para cada Checkbox...
    [Windows.Forms.MessageBox]::Show("Processo Concluído!", "Lost Engine")
})

$window.ShowDialog()
