# ______       _      ___  ___      _       _     
# | ___ \     | |     |  \/  |     | |     | |    
# | |_/ /_   _| |_ ___| .  . | __ _| |_ ___| |__  
# | ___ | | | | __/ _ | |\/| |/ _` | __/ __| '_ \ 
# | |_/ | |_| | ||  __| |  | | (_| | || (__| | | |
# \____/ \__, |\__\___\_|  |_/\__,_|\__\___|_| |_|
#        __/ |                                   
#       |___/                                                     
#
#   Script Written By: Michael Terry
#   Purpose: File Comparison Tool
#   Version: 2.0.0
#   Date: 3/30/25
#


######################### Import Packages #########################
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

######################### UI Settings #########################

$backColor = [System.Drawing.ColorTranslator]::FromHtml("#1E1E1E")
$foreColor = [System.Drawing.ColorTranslator]::FromHtml("#333333")
$accentColor = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")


######################### Create Form #########################
$form = New-Object System.Windows.Forms.Form
$form.Text = "ByteMatch"
$form.Size = New-Object System.Drawing.Size(600, 268)
$form.StartPosition = "CenterScreen"
$form.BackColor = $backColor
$form.Topmost = $true
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.Icon = ".\ByteMatch\Icon.ico"
    
######################### File 1 TextBox #########################
$txtBoxPath1 = New-Object System.Windows.Forms.TextBox
$txtBoxPath1.Location = New-Object System.Drawing.Point(63, 38)
$txtBoxPath1.AutoSize = "False"
$txtBoxPath1.Size = New-Object System.Drawing.Size(440, 0)
$txtBoxPath1.BackColor = $foreColor
$txtBoxPath1.ForeColor = $accentColor
$form.Controls.Add($txtBoxPath1)
    
######################### File 1 Label #########################
$lblPath1 = New-Object System.Windows.Forms.Label
$lblPath1.Location = New-Object System.Drawing.Point(25, 40)
$lblPath1.Text = "File 1: "
$lblPath1.ForeColor = $accentColor
$form.Controls.Add($lblPath1)
    
######################### File 1 Button #########################
$btnPath1 = New-Object System.Windows.Forms.Button
$btnPath1.Location = New-Object System.Drawing.Point(515, 37)
$btnPath1.Size = New-Object System.Drawing.Size(40, 20)
$btnPath1.Text = "..."
$btnPath1.BackColor = $foreColor
$btnPath1.ForeColor = $accentColor
$btnPath1.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$form.Controls.Add($btnPath1)
    
$btnPath1.Add_Click({
        $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
        $openFileDialog.InitialDirectory = [Environment]::GetFolderPath("Desktop") # Set default directory
        $openFileDialog.Filter = "All files (*.*)|*.*" # File filter
    
        if ($openFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
            $selectedFile = $openFileDialog.FileName
            $txtBoxPath1.Text = $openFileDialog.FileName
        }
    })
    
######################### File 2 TextBox #########################    
$txtBoxPath2 = New-Object System.Windows.Forms.TextBox
$txtBoxPath2.Location = New-Object System.Drawing.Point(63, 95)
$txtBoxPath2.AutoSize = "False"
$txtBoxPath2.Size = New-Object System.Drawing.Size(440, 0)
$txtBoxPath2.BackColor = $foreColor
$txtBoxPath2.ForeColor = $accentColor
$form.Controls.Add($txtBoxPath2)
    
######################### File 2 Label #########################
$lblPath2 = New-Object System.Windows.Forms.Label
$lblPath2.Location = New-Object System.Drawing.Point(25, 97)
$lblPath2.Text = "File 2: "
$lblPath2.ForeColor = $accentColor
$form.Controls.Add($lblPath2)
    
######################### File 2 Button #########################
$btnPath2 = New-Object System.Windows.Forms.Button
$btnPath2.Location = New-Object System.Drawing.Point(515, 94)
$btnPath2.Size = New-Object System.Drawing.Size(40, 20)
$btnPath2.Text = "..."
$btnPath2.BackColor = $foreColor
$btnPath2.ForeColor = $accentColor
$btnPath2.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$form.Controls.Add($btnPath2)
    
$btnPath2.Add_Click({
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.InitialDirectory = [Environment]::GetFolderPath("Desktop") # Set default directory
    $openFileDialog.Filter = "All files (*.*)|*.*" # File filter

    if ($openFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $selectedFile = $openFileDialog.FileName
        $txtBoxPath2.Text = $openFileDialog.FileName
    }
})

######################### Compare Button #########################
$btnCompare = New-Object System.Windows.Forms.Button
$btnCompare.Location = New-Object System.Drawing.Point(185, 152)
$btnCompare.Size = New-Object System.Drawing.Size(80, 40)
$btnCompare.Text = "Compare"
$btnCompare.BackColor = $foreColor
$btnCompare.ForeColor = $accentColor
$btnCompare.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$form.Controls.Add($btnCompare)

$btnCompare.Add_Click({
    try {

        ##### Assign Hashes #####
        $hash1 = Get-FileHash -Path $txtBoxPath1.Text -Algorithm SHA256
        $hash2 = Get-FileHash -Path $txtBoxPath2.Text -Algorithm SHA256

        ##### Compare Hashes #####
        if ($hash1.Hash -eq $hash2.Hash) {
            [System.Windows.Forms.MessageBox]::Show("The files are identical.", "Comparison Result", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        } else {
            [System.Windows.Forms.MessageBox]::Show("The files are different.", "Comparison Result", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        }
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Error: $_", "Comparison Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

######################### Reset Button #########################
$btnReset = New-Object System.Windows.Forms.Button
$btnReset.Location = New-Object System.Drawing.Point(315, 152)
$btnReset.Size = New-Object System.Drawing.Size(80, 40)
$btnReset.Text = "Reset"
$btnReset.BackColor = $foreColor
$btnReset.ForeColor = $accentColor
$btnReset.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$form.Controls.Add($btnReset)

$btnReset.Add_Click({
    $txtBoxPath1.Text = ""
    $txtBoxPath2.Text = ""
})

######################### Main #########################
$form.ActiveControl = $null
$form.ShowDialog()
