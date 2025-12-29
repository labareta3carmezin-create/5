# FORÇAR CODIFICAÇÃO UTF-8 PARA EVITAR ERROS DE CARACTERES (????)
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
                <Button x:Name="TabInstall" Content="Instalar" Width="120" Height="40" Background="Transparent" Foreground="White" BorderThickness="0" Margin="5" Cursor="Hand"/>
                <Button x:Name="TabTweaks" Content="Otimizações" Width="120" Height="40" Background="#2d303d" Foreground="Cyan" BorderThickness="1" BorderBrush="Cyan" Margin="5" Cursor="Hand"/>
                <Button x:Name="TabConfig" Content="Configurações" Width="120" Height="40" Background="Transparent" Foreground="White" BorderThickness="0" Margin="5" Cursor="Hand"/>
                <Button x:Name="TabUpdates" Content="Atualizações" Width="120" Height="40" Background="Transparent" Foreground="White" BorderThickness="0" Margin="5" Cursor="Hand"/>
                <Button x:Name="TabMicroWin" Content="MicroWin" Width="120" Height="40" Background="Transparent" Foreground="White" BorderThickness="0" Margin="5" Cursor="Hand"/>
            </StackPanel>
        </Border>

        <ScrollViewer Grid.Row="1" Margin="10" VerticalScrollBarVisibility="Auto">
            <StackPanel x:Name="MainContainer">
                
                <Grid x:Name="PanelTweaks" Visibility="Visible">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>

                    <StackPanel Grid.Column="0" Margin="15">
                        <TextBlock Text="Otimizações Essenciais" Foreground="DodgerBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,-5"/>
                        <Rectangle Height="1" Fill="Gray" Margin="0,10,0,15" Opacity="0.3"/>
                        
                        <CheckBox x:Name="chkRestore" Content="Criar Ponto de Restauração" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkTemp" Content="Limpar Arquivos Temporários" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkTele" Content="Desativar Telemetria e Coleta de Dados" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkDVR" Content="Desativar GameDVR (Mais FPS em Jogos)" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkPower" Content="Ativar Plano Lost e Vinizin Oprimizer" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkDisk" Content="Otimizar Discos (TRIM para SSD)" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkHibern" Content="Desativar Hibernação" Foreground="White" Margin="0,4"/>
                        
                        <TextBlock Text="Avançadas (Cuidado)" Foreground="OrangeRed" FontSize="18" FontWeight="Bold" Margin="0,25,0,-5"/>
                        <Rectangle Height="1" Fill="Gray" Margin="0,10,0,15" Opacity="0.3"/>
                        <CheckBox x:Name="chkEdge" Content="Remover Microsoft Edge" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkIPv6" Content="Desativar IPv6 (Melhora o Ping)" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkRecall" Content="Desativar AI Recall (Win 11)" Foreground="White" Margin="0,4"/>
                    </StackPanel>

                    <StackPanel Grid.Column="1" Margin="15">
                        <TextBlock Text="Preferências Visual e Sistema" Foreground="DodgerBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,-5"/>
                        <Rectangle Height="1" Fill="Gray" Margin="0,10,0,15" Opacity="0.3"/>
                        
                        <CheckBox x:Name="chkDark" Content="Ativar Modo Escuro" IsChecked="True" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkMouse" Content="Desativar Aceleração do Mouse" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkHidden" Content="Mostrar Arquivos Ocultos e Extensões" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkCenter" Content="Centralizar Ícones da Barra de Tarefas" Foreground="White" Margin="0,4"/>
                        <CheckBox x:Name="chkWidgets" Content="Remover Widgets e Chat (Win 11)" Foreground="White" Margin="0,4"/>
                        
                        <TextBlock Text="Planos de Desempenho" Foreground="Cyan" FontSize="18" FontWeight="Bold" Margin="0,25,0,-5"/>
                        <Rectangle Height="1" Fill="Gray" Margin="0,10,0,15" Opacity="0.3"/>
                        <Button x:Name="BtnUltimate" Content="Adicionar Perfil Desempenho Máximo" Height="35" Background="#2d303d" Foreground="White" Margin="0,5"/>
                    </StackPanel>
                </Grid>

                <StackPanel x:Name="PanelUpdates" Visibility="Collapsed" Margin="20">
                    <TextBlock Text="Gerenciamento de Atualizações do Windows" Foreground="DodgerBlue" FontSize="22" FontWeight="Bold" HorizontalAlignment="Center" Margin="0,0,0,30"/>
                    <UniformGrid Columns="3" Height="200">
                        <Border BorderBrush="Gray" BorderThickness="1" Margin="10" Padding="15">
                            <StackPanel>
                                <Button Content="Configurações Padrão" Background="#2d303d" Foreground="White" Height="40"/>
                                <TextBlock Text="Restaura o Windows Update ao padrão de fábrica." Foreground="LightGray" TextWrapping="Wrap" Margin="0,10" FontSize="12"/>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="DodgerBlue" BorderThickness="1" Margin="10" Padding="15">
                            <StackPanel>
                                <Button Content="Segurança Balanceada" Background="#2d303d" Foreground="White" Height="40"/>
                                <TextBlock Text="Adia atualizações de recursos por 2 anos. Segurança em 4 dias." Foreground="LightGray" TextWrapping="Wrap" Margin="0,10" FontSize="12"/>
                            </StackPanel>
                        </Border>
                        <Border BorderBrush="OrangeRed" BorderThickness="1" Margin="10" Padding="15">
                            <StackPanel>
                                <Button Content="Desativar Tudo" Background="#2d303d" Foreground="White" Height="40"/>
                                <TextBlock Text="!! Não Recomendado !! Desativa completamente o Windows Update." Foreground="LightGray" TextWrapping="Wrap" Margin="0,10" FontSize="12"/>
                            </StackPanel>
                        </Border>
                    </UniformGrid>
                </StackPanel>

            </StackPanel>
        </ScrollViewer>

        <Border Grid.Row="2" Background="#1c1e26" BorderBrush="Cyan" BorderThickness="0,1,0,0">
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Left" Margin="25,0">
                <Button x:Name="RunBtn" Content="EXECUTAR OTIMIZAÇÃO" Width="220" Height="40" Background="RoyalBlue" Foreground="White" FontWeight="Bold" Margin="0,0,15,0" Cursor="Hand"/>
                <Button x:Name="UndoBtn" Content="DESFAZER" Width="220" Height="40" Background="#2d303d" Foreground="White" FontWeight="Bold" Cursor="Hand"/>
            </StackPanel>
        </Border>
    </Grid>
</Window>
"@

# CARREGAR INTERFACE
$reader = [XML.XmlReader]::Create([System.IO.StringReader]$xml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- NAVEGAÇÃO ENTRE ABAS ---
$Panels = @{
    "Tweaks" = $window.FindName("PanelTweaks")
    "Updates" = $window.FindName("PanelUpdates")
}

$window.FindName("TabTweaks").Add_Click({ $Panels.Updates.Visibility = "Collapsed"; $Panels.Tweaks.Visibility = "Visible" })
$window.FindName("TabUpdates").Add_Click({ $Panels.Tweaks.Visibility = "Collapsed"; $Panels.Updates.Visibility = "Visible" })

# --- LÓGICA DE EXECUÇÃO ---
$window.FindName("RunBtn").Add_Click({
    if ($window.FindName("chkPower").IsChecked) {
        $guid = (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61).Split(' ')[-1]
        powercfg -changename $guid "Lost e Vinizin Oprimizer"
        powercfg /setactive $guid
    }
    [Windows.Forms.MessageBox]::Show("Otimização concluída!", "Lost Engine")
})

$window.ShowDialog()
