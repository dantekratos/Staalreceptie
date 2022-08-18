#Script for zoeken stalen Microbiologie

Add-Type -assembly System.Windows.Forms
### Window box
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = 'Staalreceptie'
$main_form.Width = 500
$main_form.Height = 150
$main_form.Topmost = $true
$main_form.StartPosition = 'CenterScreen'

### Submit button
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(50,75)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'Submit'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK

# Add button to window
$main_form.Controls.Add($OKButton)

### Cancel button
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(350,75)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel

# Add cancel button to window
$main_form.Controls.Add($CancelButton)

### Label for textbox
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(50,28)
$Font = New-Object System.Drawing.Font("Arial",10)
$label.Font = $Font
$label.Text = 'Barcode: '
$label.ForeColor = 'Black'

# Add label to window
$main_form.Controls.Add($label)

### Textbox for sample barcode
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(150,25)
$textBox.Size = New-Object System.Drawing.Size(200,25)

# Add textbox to window
$main_form.Controls.Add($textBox)

#show the windowbox
$main_form.ShowDialog()

#Get input from textbox
$main_form.Add_Shown({$textBox.Select()})
$result = $main_form.ShowDialog()

### Turn barcode into variable
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $barcode = $textBox.Text

    # Go to scanlog folder
    Set-Location -Path "C:\Users\simon\Desktop\scanlog"
   
        #search for barcode
        $output = Select-String -Path .\*.txt $barcode | select-object -ExpandProperty Line

	### result box
	$result_form = New-Object System.Windows.Forms.Form
	$result_form.Text = 'Resultaat'
	$result_form.Width = 800
	$result_form.Height = 400
	$result_form.Topmost = $true
	$result_form.StartPosition = 'CenterScreen'

	#put result into box
	$TextBox1 = New-Object system.Windows.Forms.TextBox
	$TextBox1.multiline = $True
	$TextBox1.width = 600
	$TextBox1.height = 200
	$TextBox1.location = New-Object System.Drawing.Point(20,50)
	$TextBox1.Font = 'Microsoft Sans Serif,10'
	$TextBox1.Text = $output

	#add result_box to result_form
	$result_form.Controls.Add($TextBox1)

	#show the result
	$result_form.ShowDialog()
}