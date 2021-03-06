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
      <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
        <a onclick="location='<?php echo $module; ?>';" class="button"><?php echo $button_module; ?></a>
        <a href="<?php echo $insert; ?>" class="button"><?php echo $button_insert; ?></a>
		<a onclick="$('form').attr('action', '<?php echo $reset; ?>'); $('form').submit();" class="button-repair"><?php echo $button_reset; ?></a>
        <a onclick="$('#form').submit();" class="button-delete"><?php echo $button_delete; ?></a>
      </div>
    </div>
    <div class="content">
	<?php if ($navigation_hi) { ?>
      <div class="pagination" style="margin-bottom:10px;"><?php echo $pagination; ?></div>
    <?php } ?>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form" name="newslist">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align:center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="center"><?php echo $column_image; ?></td>
              <td class="left"><?php if ($sort == 'nd.title') { ?>
                <a href="<?php echo $sort_title; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_title; ?> (<?php echo $totalnews; ?>)</a>
              <?php } else { ?>
                <a href="<?php echo $sort_title; ?>"><?php echo $column_title; ?> (<?php echo $totalnews; ?>)&nbsp;&nbsp;<img src="view/image/asc.png" alt="" /></a>
              <?php } ?></td>
              <td class="left"><?php if ($sort == 'n.date_added') { ?>
                <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
              <?php } else { ?>
                <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?>&nbsp;&nbsp;<img src="view/image/asc.png" alt="" /></a>
              <?php } ?></td>
              <td class="left"><?php if ($sort == 'n.viewed') { ?>
                <a href="<?php echo $sort_viewed; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_viewed; ?>
              <?php } else { ?>
                <a href="<?php echo $sort_viewed; ?>"><?php echo $column_viewed; ?>&nbsp;&nbsp;<img src="view/image/asc.png" alt="" /></a>
              <?php } ?></td>
              <td class="left"><?php if ($sort == 'n.status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?>
              <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?>&nbsp;&nbsp;<img src="view/image/asc.png" alt="" /></a>
              <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($news) { ?>
              <?php $class = 'odd'; ?>
              <?php foreach ($news as $news_story) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <tr class="<?php echo $class; ?>">
                  <td class="center">
                    <?php if ($news_story['selected']) { ?>
                      <input type="checkbox" name="selected[]" value="<?php echo $news_story['news_id']; ?>" checked="checked" />
                    <?php } else { ?>
                      <input type="checkbox" name="selected[]" value="<?php echo $news_story['news_id']; ?>" />
                    <?php } ?>
                  </td>
                  <td class="center"><img src="<?php echo $news_story['image']; ?>" alt="<?php echo $news_story['title']; ?>" style="padding:1px; border:1px solid #DDD;" /></td>
                  <td class="left"><?php echo $news_story['title']; ?></td>
                  <td class="left"><?php echo $news_story['date_added']; ?></td>
                  <td class="center"><?php echo $news_story['viewed']; ?></td>
                  <?php if ($news_story['status'] == 1) { ?>
                    <td class="center"><span class="enabled"><?php echo $text_enabled; ?></span></td>
                  <?php } else { ?>
                    <td class="center"><span class="disabled"><?php echo $text_disabled; ?></span></td>
                  <?php } ?>
                  <td class="right">
                    <?php foreach ($news_story['action'] as $action) { ?>
                      <a href="<?php echo $action['href']; ?>" class="button-form"><?php echo $action['text']; ?></a>
                    <?php } ?>
                  </td>
                </tr>
              <?php } ?>
            <?php } else { ?>
              <tr class="even">
                <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
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