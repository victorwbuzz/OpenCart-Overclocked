<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><?php echo $title; ?></title>
</head>
<body style="font-family:Arial, Helvetica, sans-serif; font-size:12px; color:#000000;">
<div style="width:680px;">
  <a href="<?php echo $store_url; ?>" title="<?php echo $store_name; ?>"><img src="<?php echo $logo; ?>" alt="<?php echo $store_name; ?>" style="margin-bottom:20px; border:none;" /></a>
  <h3 style="margin-top:0px; margin-bottom:20px;"><?php echo $text_greeting; ?></h3>
  <p><?php echo $text_login; ?> <a href="<?php echo $login_link; ?>"><?php echo $login_link; ?></a></p>
  <p><b><?php echo $text_express_login; ?></b> <?php echo $login; ?></p>
  <p><b><?php echo $text_express_password; ?></b> <span style="color:#800000;"><?php echo $password; ?></span></p>
  <p><?php echo $text_services; ?></p>
  <p style="font-style:italic;"><?php echo $text_sign; ?></p>
</div>
</body>
</html>
