<?php
$DevInternal = $_POST["DevInternal"];
$list = $_POST["list"];
$ProdDMZ32 = $_POST["ProdDMZ32"];
$ProdDMZ64 = $_POST["ProdDMZ64"];
$ProdInternal = $_POST["ProdInternal"];
$TestDMZ32 = $_POST["TestDMZ32"];
$TestDMZ64 = $_POST["TestDMZ64"];
$TestInternal = $_POST["TestInternal"];
include($DevInternal);
include($list);
include($ProdDMZ32);
include($ProdDMZ64);
include($ProdInternal);
include($TestDMZ32);
include($TestDMZ64);
include($TestInternal);
?>
