<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
    <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
    <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/backup.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
        <a onclick="$('#restore').submit();" class="button"><?php echo $button_restore; ?></a>
        <a onclick="$('#backup').submit();" class="button"><?php echo $button_backup; ?></a>
        <a href="<?php echo $cancel; ?>" class="button-cancel"><?php echo $button_cancel; ?></a>
      </div>
    </div>
    <div class="content">
      <form action="<?php echo $restore; ?>" method="post" enctype="multipart/form-data" id="restore">
        <h2><?php echo $heading_restore; ?></h2>
        <table class="form">
          <tr>
            <td><?php echo $entry_restore; ?></td>
            <td><input type="file" name="import" class="custom-input-class" /></td>
          </tr>
        </table>
      </form>
      <form action="<?php echo $backup; ?>" method="post" enctype="multipart/form-data" id="backup">
        <h2><?php echo $heading_backup; ?></h2>
        <table class="form">
          <tr>
            <td><?php echo $entry_backup; ?></td>
            <td><div class="scrollbox" style="height:220px; margin-bottom:5px;">
              <?php $class='odd'; ?>
              <?php foreach ($tables as $table) { ?>
                <?php $class=($class == 'even') ? 'odd' : 'even'; ?>
                <div class="<?php echo $class; ?>">
                  <input type="checkbox" name="backup[]" value="<?php echo $table; ?>" checked="checked" />
                <?php echo $table; ?></div>
              <?php } ?>
            </div><br />
            <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> | <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a></td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>

<script type="text/javascript" src="view/javascript/jquery/sfi/js/jquery.simplefileinput.min.js"></script>

<script type="text/javascript"><!--
$(document).ready(function() {
    $('.custom-input-class').simpleFileInput({
		placeholder: '<?php echo $text_restore; ?>',
		buttonText: 'Select',
		allowedExts: ['sql'],
		width: 282
	});
});
//--></script>

<?php echo $footer; ?>