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
      <h1><img src="view/image/information.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
        <a onclick="$('#form').attr('action', '<?php echo $enabled; ?>'); $('#form').submit();" class="button-save"><?php echo $button_enable; ?></a>
		<a onclick="$('#form').attr('action', '<?php echo $disabled; ?>'); $('#form').submit();" class="button-cancel"><?php echo $button_disable; ?></a>
        <a href="<?php echo $insert; ?>" class="button"><?php echo $button_insert; ?></a>
        <a onclick="$('form').submit();" class="button-delete"><?php echo $button_delete; ?></a>
      </div>
    </div>
    <div class="content">
	<?php if ($navigation_hi) { ?>
      <div class="pagination" style="margin-bottom:10px;"><?php echo $pagination; ?></div>
    <?php } ?>
    <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="list">
        <thead>
          <tr>
            <td width="1" style="text-align:center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
            <td class="left"><?php if ($sort == 'id.title') { ?>
              <a href="<?php echo $sort_title; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_title; ?></a>
            <?php } else { ?>
              <a href="<?php echo $sort_title; ?>"><?php echo $column_title; ?>&nbsp;&nbsp;<img src="view/image/asc.png" alt="" /></a>
            <?php } ?></td>
            <td class="left"><?php if ($sort == 'i.sort_order') { ?>
              <a href="<?php echo $sort_sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_sort_order; ?></a>
            <?php } else { ?>
              <a href="<?php echo $sort_sort_order; ?>"><?php echo $column_sort_order; ?>&nbsp;&nbsp;<img src="view/image/asc.png" alt="" /></a>
            <?php } ?></td>
            <td class="left"><?php if ($sort == 'i.bottom') { ?>
              <a href="<?php echo $sort_bottom; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_bottom; ?></a>
            <?php } else { ?>
              <a href="<?php echo $sort_bottom; ?>"><?php echo $column_bottom; ?>&nbsp;&nbsp;<img src="view/image/asc.png" alt="" /></a>
            <?php } ?></td>
            <td class="left"><?php if ($sort == 'i.status') { ?>
              <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
            <?php } else { ?>
              <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?>&nbsp;&nbsp;<img src="view/image/asc.png" alt="" /></a>
            <?php } ?></td>
            <td class="right"><?php echo $column_action; ?></td>
          </tr>
        </thead>
        <tbody>
        <?php if ($informations) { ?>
          <?php foreach ($informations as $information) { ?>
            <tr>
              <td style="text-align:center;"><?php if ($information['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $information['information_id']; ?>" checked="checked" />
              <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $information['information_id']; ?>" />
              <?php } ?></td>
              <td class="left"><?php echo $information['title']; ?></td>
              <td class="center"><?php echo $information['sort_order']; ?></td>
              <td class="center"><?php echo $information['bottom']; ?></td>
			  <?php if ($information['status'] == 1) { ?>
                <td class="center"><span class="enabled"><?php echo $text_enabled; ?></span></td>
              <?php } else { ?>
                <td class="center"><span class="disabled"><?php echo $text_disabled; ?></span></td>
              <?php } ?>
              <td class="right"><?php foreach ($information['action'] as $action) { ?>
                <a href="<?php echo $action['href']; ?>" class="button-form"><?php echo $action['text']; ?></a>
              <?php } ?></td>
            </tr>
          <?php } ?>
        <?php } else { ?>
          <tr>
            <td class="center" colspan="6"><?php echo $text_no_results; ?></td>
          </tr>
        <?php } ?>
        </tbody>
      </table>
    </form>
    <?php if ($navigation_lo) { ?>
      <div class="pagination"><?php echo $pagination; ?></div>
	<?php } ?>
    </div>
  </div>
</div>
<?php echo $footer; ?>