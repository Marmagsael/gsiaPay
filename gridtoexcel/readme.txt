A class based on commandbutton.
Assign a grid to it. On clicking it will copy contents of the grid to Excel Sheet with the headers.


Usage example

set classlib to gridtoexcel
thisform.AddObject('gridcommand','gridtoexcel')
thisform.gridcommand.height=27
thisform.gridcommand.top=20
thisform.gridcommand.left=524
thisform.gridcommand.width=84
thisform.gridcommand.visible=.t.
thisform.gridcommand.gridname=thisform.grid1

clicking on the button will cause whatever is there in the grid to be copied to an excel worksheet.

for heading it will take columns[].header1.caption. in case you have changed the name of the header
there will be an error.


this class requires excel to be loaded on the local machine. 


there is no error handling. 
any error condition will cause it to exit ungracefully. you are advised to update it for 
handling of errors etc.
