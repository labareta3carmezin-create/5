# Força a codificação para evitar erros de acentos (????)
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
                <Button x:Name="TabInstall" Content="Instalar" Width="120" Height="40" Background="Transparent" Foreground="White" Margin="5" Cursor="Hand"/>
                <Button x:Name="TabTweaks" Content="Otimizações" Width="120" Height="40" Background="#2d303d" Foreground="Cyan" BorderThickness="1" BorderBrush="Cyan" Margin="5" Cursor="Hand"/>
                <Button x:Name="TabConfig" Content="Configurações" Width="120" Height="40" Background="Transparent" Foreground="White" Margin="5" Cursor="Hand"/>
                <Button x:Name="TabUpdates" Content="Atualizações" Width="120" Height="40" Background="Transparent" Foreground="White" Margin="5" Cursor="Hand"/>
                <Button x:Name="TabMicroWin" Content="MicroWin" Width="120" Height="40" Background="Transparent" Foreground="White" Margin="5" Cursor="Hand"/>
            </StackPanel>
        </Border>

        <ScrollViewer Grid.Row="1" Margin="10" VerticalScrollBarVisibility="Auto">
            <Grid>
                <Grid x:Name="PanelTweaks" Visibility="Visible">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <StackPanel Grid.Column="0" Margin="15">
                        <TextBlock Text="Otimizações Essenciais" Foreground="DodgerBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                        <CheckBox x:Name="chkPower" Content="Ativar Plano Lost e Vinizin Oprimizer" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkRestore" Content="Criar Ponto de Restauração" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkTemp" Content="Limpar Arquivos Temporários" Foreground="White" Margin="0,4"/>
                    </StackPanel>
                </Grid>

                <StackPanel x:Name="PanelInstall" Visibility="Collapsed" Margin="20">
                    <TextBlock Text="Instalação de Aplicativos" Foreground="Cyan" FontSize="18" FontWeight="Bold"/>
                    <TextBlock Text="Selecione os programas que deseja instalar via Winget." Foreground="White" Margin="0,10"/>
                    </StackPanel>

                <StackPanel x:Name="PanelConfig" Visibility="Collapsed" Margin="20">
                    <TextBlock Text="Configurações de Sistema" Foreground="Cyan" FontSize="18" FontWeight="Bold"/>
                    <CheckBox Content="Habilitar WSL" Foreground="White" Margin="0,5"/>
                    <CheckBox Content="Habilitar Hyper-V" Foreground="White" Margin="0,5"/>
                </StackPanel>

                <StackPanel x:Name="PanelUpdates" Visibility="Collapsed" Margin="20">
                    <TextBlock Text="Gerenciamento de Atualizações" Foreground="DodgerBlue" FontSize="18" FontWeight="Bold" HorizontalAlignment="Center"/>
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,20">
                        <Button Content="Configuração Padrão" Width="200" Height="40" Margin="10"/>
                        <Button Content="Segurança Balanceada" Width="200" Height="40" Margin="10"/>
                        <Button Content="Desativar Tudo" Width="200" Height="40" Margin="10" Foreground="Red"/>
                    </StackPanel>
                </StackPanel>

                <StackPanel x:Name="PanelMicroWin" Visibility="Collapsed" Margin="20">
                    <TextBlock Text="MicroWin - Criação de ISO" Foreground="Cyan" FontSize="18" FontWeight="Bold"/>
                    <TextBlock Text="Instruções para descompactar e otimizar sua ISO do Windows." Foreground="White" TextWrapping="Wrap" Margin="0,10"/>
                </StackPanel>
            </Grid>
        </ScrollViewer>

        <Border Grid.Row="2" Background="#1c1e26" BorderBrush="Cyan" BorderThickness="0,1,0,0">
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Left" Margin="25,0">
                <Button x:Name="RunBtn" Content="EXECUTAR OTIMIZAÇÃO" Width="220" Height="40" Background="RoyalBlue" Foreground="White" FontWeight="Bold" Margin="0,0,15,0" Cursor="Hand"/>
            </StackPanel>
        </Border>
    </Grid>
</Window>
"@

$reader = [XML.XmlReader]::Create([System.IO.StringReader]$xml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- LÓGICA DE NAVEGAÇÃO ENTRE ABAS ---
$panéis = @("PanelTweaks", "PanelInstall", "PanelConfig", "PanelUpdates", "PanelMicroWin")

function Show-Tab($tabName) {
    foreach ($p in $panéis) {
        $window.FindName($p).Visibility = "Collapsed"
    }
    $window.FindName($tabName).Visibility = "Visible"
}

$window.FindName("TabTweaks").Add_Click({ Show-Tab "PanelTweaks" })
$window.FindName("TabInstall").Add_Click({ Show-Tab "PanelInstall" })
$window.FindName("TabConfig").Add_Click({ Show-Tab "PanelConfig" })
$window.FindName("TabUpdates").Add_Click({ Show-Tab "PanelUpdates" })
$window.FindName("TabMicroWin").Add_Click({ Show-Tab "PanelMicroWin" })

# --- EXECUÇÃO ---
$window.FindName("RunBtn").Add_Click({
    if ($window.FindName("chkPower").IsChecked) {
        $guid = (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61).Split(' ')[-1]
        powercfg -changename $guid "Lost e Vinizin Oprimizer"
        powercfg /setactive $guid
    }
    [Windows.Forms.MessageBox]::Show("Otimização concluída!", "Lost Engine")
})

$window.ShowDialog()
