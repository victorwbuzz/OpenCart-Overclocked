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
  <?php if ($attention) { ?>
    <div class="attention"><?php echo $attention; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
    <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/stock-status.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
        <a href="<?php echo $clean; ?>" class="button"><?php echo $button_clean; ?></a>
        <a onclick="$('#form').submit();" class="button-delete"><?php echo $button_delete; ?></a>
        <a href="<?php echo $cancel; ?>" class="button-cancel"><?php echo $button_cancel; ?></a>
      </div>
    </div>
    <div class="content">
    <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form" name="files">
      <table class="list">
        <thead>
          <tr>
            <td width="1" style="text-align:center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
            <td class="left"><?php echo $column_name; ?></td>
            <td class="left"><?php echo $column_size; ?></td>
            <td class="left"><?php echo $column_expire;?></td>
          </tr>
        </thead>
        <tbody>
        <?php if ($cache_files) { ?>
          <?php foreach ($cache_files as $cache_file) { ?>
          <tr>
            <td style="text-align:center;"><?php if ($cache_file['selected']) { ?>
              <input type="checkbox" name="selected[]" value="<?php echo $cache_file['name']; ?>" checked="checked" />
            <?php } else { ?>
              <input type="checkbox" name="selected[]" value="<?php echo $cache_file['name']; ?>" />
            <?php } ?></td>
            <td class="left"><?php echo $cache_file['name']; ?></td>
            <td class="left"><?php echo $cache_file['size']; ?></td>
            <td class="left"><?php echo $cache_file['time']; ?></td>
          </tr>
          <?php } ?>
        <?php } else { ?>
          <tr>
            <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
          </tr>
        <?php } ?>
        </tbody>
      </table>
    </form>
    </div>
	</div>
</div>
<?php echo $footer; ?>