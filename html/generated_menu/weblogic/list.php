<?php
$list = $_POST["list"];
$ProdeCommerce = $_POST["ProdeCommerce"];
$ProdEXT = $_POST["ProdEXT"];
$ProdSabrix = $_POST["ProdSabrix"];
$ProdVG = $_POST["ProdVG"];
$ProdWelcomeScreen = $_POST["ProdWelcomeScreen"];
$TesteCommerce = $_POST["TesteCommerce"];
$TestEJB = $_POST["TestEJB"];
$TestEXT = $_POST["TestEXT"];
$TestSabrix = $_POST["TestSabrix"];
$TestVG = $_POST["TestVG"];
$TestWelcomeScreen = $_POST["TestWelcomeScreen"];
include($list);
include($ProdeCommerce);
include($ProdEXT);
include($ProdSabrix);
include($ProdVG);
include($ProdWelcomeScreen);
include($TesteCommerce);
include($TestEJB);
include($TestEXT);
include($TestSabrix);
include($TestVG);
include($TestWelcomeScreen);
?>
