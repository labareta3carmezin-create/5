# Força codificação UTF-8 para remover os "????" definitivamente
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

        <Grid Grid.Row="1" Margin="20">
            <Grid x:Name="PanelTweaks" Visibility="Visible">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>
                <StackPanel Grid.Column="0">
                    <TextBlock Text="Otimizações Essenciais" Foreground="DodgerBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                    <CheckBox x:Name="chkPower" Content="Ativar Plano Lost e Vinizin Oprimizer" Foreground="White" Margin="0,5"/>
                    <CheckBox Content="Limpar Arquivos Temporários" Foreground="White" Margin="0,5"/>
                    <CheckBox Content="Desativar Telemetria" Foreground="White" Margin="0,5"/>
                </StackPanel>
            </Grid>

            <Grid x:Name="PanelInstall" Visibility="Collapsed">
                <TextBlock Text="Instalação de Aplicativos (Winget/Chocolatey)" Foreground="Cyan" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                <TextBlock Text="Navegue pelas categorias para instalar softwares essenciais." Foreground="White" VerticalAlignment="Center" HorizontalAlignment="Center"/>
            </Grid>

            <Grid x:Name="PanelConfig" Visibility="Collapsed">
                <StackPanel>
                    <TextBlock Text="Recursos e Reparos" Foreground="Cyan" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                    <Button Content="Resetar Rede" Width="150" HorizontalAlignment="Left" Margin="0,5"/>
                    <Button Content="Winget Reinstall" Width="150" HorizontalAlignment="Left" Margin="0,5"/>
                </StackPanel>
            </Grid>

            <Grid x:Name="PanelMicroWin" Visibility="Collapsed">
                <StackPanel>
                    <TextBlock Text="MicroWin - Otimização de ISO" Foreground="Cyan" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                    <TextBlock Text="Use esta aba para remover telemetria e bloatware de ISOs do Windows." Foreground="LightGray" TextWrapping="Wrap"/>
                </StackPanel>
            </Grid>
        </Grid>

        <Border Grid.Row="2" Background="#1c1e26" BorderBrush="Cyan" BorderThickness="0,1,0,0">
            <Button x:Name="RunBtn" Content="EXECUTAR OTIMIZAÇÃO" Width="220" Height="40" Background="RoyalBlue" Foreground="White" FontWeight="Bold" HorizontalAlignment="Left" Margin="25,0"/>
        </Border>
    </Grid>
</Window>
"@

$reader = [XML.XmlReader]::Create([System.IO.StringReader]$xml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- LÓGICA DE TROCA DE ABAS ---
$panels = @{
    "TabInstall" = $window.FindName("PainelInstall")
    "TabTweaks"  = $window.FindName("PainelTweaks")
    "TabConfig"  = $window.FindName("PainelConfig")
    "TabMicroWin" = $window.FindName("PainelMicroWin")
}

function Switch-Tab($activeTabName) {
    $panels.Values | ForEach-Object { $_.Visibility = "Collapsed" }
    $panels[$activeTabName].Visibility = "Visible"
}

$window.FindName("TabInstall").Add_Click({ Switch-Tab "TabInstall" })
$window.FindName("TabTweaks").Add_Click({ Switch-Tab "TabTweaks" })
$window.FindName("TabConfig").Add_Click({ Switch-Tab "TabConfig" })
$window.FindName("TabMicroWin").Add_Click({ Switch-Tab "TabMicroWin" })

$window.ShowDialog()
