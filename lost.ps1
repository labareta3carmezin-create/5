# Forca codificacao para evitar erros de leitura
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

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
                <Button x:Name="TabTweaks" Content="Otimizacoes" Width="150" Height="40" Background="#2d303d" Foreground="Cyan" BorderThickness="1" BorderBrush="Cyan" Margin="10" Cursor="Hand"/>
                <Button x:Name="TabMicroWin" Content="MicroWin" Width="150" Height="40" Background="Transparent" Foreground="White" BorderThickness="0" Margin="10" Cursor="Hand"/>
            </StackPanel>
        </Border>

        <Grid Grid.Row="1" Margin="20">
            <Grid x:Name="PanelTweaks" Visibility="Visible">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>
                <StackPanel Grid.Column="0">
                    <TextBlock Text="Otimizacoes Essenciais" Foreground="DodgerBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                    <CheckBox x:Name="chkPower" Content="Ativar Plano Lost e Vinizin Oprimizer" Foreground="White" Margin="0,5"/>
                    <CheckBox Content="Limpar Arquivos Temporarios" Foreground="White" Margin="0,5"/>
                    <CheckBox Content="Desativar Telemetria" Foreground="White" Margin="0,5"/>
                    <CheckBox Content="Otimizar Disco SSD" Foreground="White" Margin="0,5"/>
                </StackPanel>
                
                <StackPanel Grid.Column="1">
                    <TextBlock Text="Preferencias de Sistema" Foreground="DodgerBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                    <CheckBox Content="Ativar Modo Escuro" IsChecked="True" Foreground="White" Margin="0,5"/>
                    <CheckBox Content="Desativar Aceleracao do Mouse" Foreground="White" Margin="0,5"/>
                </StackPanel>
            </Grid>

            <Grid x:Name="PanelMicroWin" Visibility="Collapsed">
                <StackPanel>
                    <TextBlock Text="MicroWin - Otimizacao de ISO" Foreground="Cyan" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                    <TextBlock Text="Remova telemetria e itens desnecessarios de sua ISO do Windows." Foreground="LightGray" TextWrapping="Wrap"/>
                </StackPanel>
            </Grid>
        </Grid>

        <Border Grid.Row="2" Background="#1c1e26" BorderBrush="Cyan" BorderThickness="0,1,0,0">
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Left" Margin="25,0">
                <Button x:Name="RunBtn" Content="EXECUTAR OTIMIZACAO" Width="220" Height="40" Background="RoyalBlue" Foreground="White" FontWeight="Bold" Cursor="Hand"/>
            </StackPanel>
        </Border>
    </Grid>
</Window>
"@

$reader = [XML.XmlReader]::Create([System.IO.StringReader]$xml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- LOGICA DE NAVEGACAO ---
$pTweaks = $window.FindName("PanelTweaks")
$pMicro = $window.FindName("PanelMicroWin")

$window.FindName("TabTweaks").Add_Click({ 
    $pTweaks.Visibility = "Visible"
    $pMicro.Visibility = "Collapsed" 
})

$window.FindName("TabMicroWin").Add_Click({ 
    $pTweaks.Visibility = "Collapsed"
    $pMicro.Visibility = "Visible" 
})

# --- EXECUCAO ---
$window.FindName("RunBtn").Add_Click({
    if ($window.FindName("chkPower").IsChecked) {
        $guid = (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61).Split(' ')[-1]
        powercfg -changename $guid "Lost e Vinizin Oprimizer"
        powercfg /setactive $guid
    }
    [Windows.Forms.MessageBox]::Show("Processo concluido com sucesso!", "Lost Engine")
})

$window.ShowDialog()
