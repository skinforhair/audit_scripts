<html>
 <head>
  <title>Audit Home</title>
 </head>
 <body>


 <form action="list.php" method="post">
  Which environments do you want to see?<br />
  <br>

<?php
   foreach (glob("generated_menu/*") as $pathName)
   {
	if (is_dir($pathName))
	{ 
		echo $pathName."<br>";
?>
 <table border=1>
  <tr><th>DEV</th><th>TEST</th><th>PROD</th></tr>
  <tr>
   <td>   
     <?php
     foreach (glob($pathName."/Dev*.php") as $filename)
         { include $filename; } 
     ?>
   </td>
   <td>
     <?php
     foreach (glob($pathName."/Test*.php") as $filename)
         { include $filename; }  
     ?>
   </td>
   <td>
     <?php
     foreach (glob($pathName."/Prod*.php") as $filename)
         { include $filename; }  
     ?>
   </td>
  </tr>
 </table>
<?php
	}//if it is a directory
   }

echo "<br><br><hr>";


?>
                <input type="submit" name="formSubmit" value="Submit" />
  </form>

 </body>
</html>

