# Forca a codificacao UTF-8 para evitar erros de simbolos estranhos
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
                <Button Content="Otimizacoes" Width="200" Height="40" Background="#2d303d" Foreground="Cyan" BorderThickness="1" BorderBrush="Cyan" Margin="10" FontWeight="Bold"/>
            </StackPanel>
        </Border>

        <ScrollViewer Grid.Row="1" Margin="20" VerticalScrollBarVisibility="Auto">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <StackPanel Grid.Column="0" Margin="10">
                    <TextBlock Text="Otimizacoes Essenciais" Foreground="DodgerBlue" FontSize="20" FontWeight="Bold" Margin="0,0,0,20"/>
                    
                    <CheckBox x:Name="chkRestore" Content="Criar Ponto de Restauracao" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkTemp" Content="Limpar Arquivos Temporarios" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkTele" Content="Desativar Telemetria e Coleta de Dados" Foreground="White" Margin="0,5" IsChecked="True"/>
                    <CheckBox x:Name="chkDVR" Content="Desativar GameDVR (Mais FPS)" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkPower" Content="Ativar Plano Lost e Vinizin Oprimizer" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkDisk" Content="Otimizar Discos (TRIM para SSD)" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkHibern" Content="Desativar Hibernacao" Foreground="White" Margin="0,5"/>

                    <TextBlock Text="Avancadas (Cuidado)" Foreground="OrangeRed" FontSize="20" FontWeight="Bold" Margin="0,30,0,20"/>
                    <CheckBox x:Name="chkEdge" Content="Remover Microsoft Edge" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkIPv6" Content="Desativar IPv6 (Melhora o Ping)" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkRecall" Content="Desativar AI Recall (Win 11)" Foreground="White" Margin="0,5"/>
                </StackPanel>

                <StackPanel Grid.Column="1" Margin="10">
                    <TextBlock Text="Preferencias Visual e Sistema" Foreground="DodgerBlue" FontSize="20" FontWeight="Bold" Margin="0,0,0,20"/>
                    
                    <CheckBox x:Name="chkDark" Content="Ativar Modo Escuro" IsChecked="True" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkMouse" Content="Desativar Aceleracao do Mouse" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkHidden" Content="Mostrar Arquivos Ocultos" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkTask" Content="Centralizar Icones da Barra de Tarefas" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkWidgets" Content="Remover Widgets e Chat (Win 11)" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkMenu" Content="Menu de Contexto Classico (Win 11)" Foreground="White" Margin="0,5"/>

                    <TextBlock Text="Planos de Desempenho" Foreground="Cyan" FontSize="20" FontWeight="Bold" Margin="0,30,0,20"/>
                    <Button x:Name="BtnUltimate" Content="Adicionar Perfil Desempenho Maximo" Height="40" Background="#2d303d" Foreground="White" Margin="0,5"/>
                </StackPanel>
            </Grid>
        </ScrollViewer>

        <Border Grid.Row="2" Background="#1c1e26" BorderBrush="Cyan" BorderThickness="0,1,0,0">
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Left" Margin="25,0">
                <Button x:Name="RunBtn" Content="EXECUTAR OTIMIZACAO" Width="250" Height="45" Background="RoyalBlue" Foreground="White" FontWeight="Bold" Cursor="Hand"/>
                <Button x:Name="UndoBtn" Content="DESFAZER" Width="150" Height="45" Background="#2d303d" Foreground="White" FontWeight="Bold" Margin="15,0,0,0" Cursor="Hand"/>
            </StackPanel>
        </Border>
    </Grid>
</Window>
"@

$reader = [XML.XmlReader]::Create([System.IO.StringReader]$xml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- LOGICA DOS BOTOES ---
$window.FindName("RunBtn").Add_Click({
    if ($window.FindName("chkPower").IsChecked) {
        $guid = (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61).Split(' ')[-1]
        powercfg -changename $guid "Lost e Vinizin Oprimizer"
        powercfg /setactive $guid
    }
    [Windows.Forms.MessageBox]::Show("Otimizacao concluida com sucesso!", "Lost Engine")
})

$window.ShowDialog()
