<?php
$list = $_POST["list"];
$ProdDMZ32 = $_POST["ProdDMZ32"];
$ProdDMZ64 = $_POST["ProdDMZ64"];
$ProdInternal = $_POST["ProdInternal"];
$Testmstrat = $_POST["Testmstrat"];
$TestQMS = $_POST["TestQMS"];
$Testshrtc = $_POST["Testshrtc"];
$Testutltc = $_POST["Testutltc"];
include($list);
include($ProdDMZ32);
include($ProdDMZ64);
include($ProdInternal);
include($Testmstrat);
include($TestQMS);
include($Testshrtc);
include($Testutltc);
?>
