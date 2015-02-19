<link rel="stylesheet" type="text/css" href="css/audit_style.css">
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
<a href="index.php">Go Back</a>
