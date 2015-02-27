<link rel="stylesheet" type="text/css" href="css/audit_style.css">

<br><br><br>
<br><br><br>
<br><br><br>

<a href="index.php" class="big">Go Back</a><br>

<?php
 $myname="";
   foreach (glob("menu/*") as $pathName)
   {
        if (is_dir($pathName))
        {
		$title=substr($pathName,15);
		$title=ucfirst($title);
		$myname=$pathName."/list.php";
		include $myname;
	}
   }
?>
<br>
<a href="index.php" class="big">Go Back</a>
