<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
  </div>
  <?php if ($error_image) { ?>
    <div class="warning"><?php echo $error_image; ?></div>
  <?php } ?>
  <?php if ($error_image_cache) { ?>
    <div class="warning"><?php echo $error_image_cache; ?></div>
  <?php } ?>
  <?php if ($error_cache) { ?>
    <div class="warning"><?php echo $error_cache; ?></div>
  <?php } ?>
  <?php if ($error_download) { ?>
    <div class="warning"><?php echo $error_download; ?></div>
  <?php } ?>
  <?php if ($error_logs) { ?>
    <div class="warning"><?php echo $error_logs; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/home.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="bell">
        <?php if ($mail_log_status) { ?>
           <a href="<?php echo $open_mail_log; ?>" title=""><img src="view/image/email-on.png" alt="" title="" /></a>
        <?php } else { ?>
           <a href="<?php echo $open_mail_log; ?>" title=""><img src="view/image/email-off.png" alt="" title="" /></a>
        <?php } ?>
        <?php if ($error_log_status) { ?>
           <a href="<?php echo $open_error_log; ?>" title=""><img src="view/image/bell-on.png" alt="" title="" /></a>
        <?php } else { ?>
           <a href="<?php echo $open_error_log; ?>" title=""><img src="view/image/bell-off.png" alt="" title="" /></a>
        <?php } ?>
      </div>
    </div>
    <div class="content">
      <div class="overview">
        <div class="dashboard-heading"><?php echo $text_overview; ?></div>
        <div class="dashboard-content">
          <table class="list" style="margin-bottom:10px;">
            <tr>
              <td class="left"><?php echo $text_total_sale; ?></td>
              <td class="right"><?php echo $total_sale; ?></td>
            </tr>
            <tr>
              <td class="left"><?php echo $text_total_sale_year; ?></td>
              <td class="right"><?php echo $total_sale_year; ?></td>
            </tr>
            <tr>
              <td class="left"><?php echo $text_total_sale_month; ?></td>
              <td class="right"><?php echo $total_sale_month; ?></td>
            </tr>
            <tr>
              <td class="left"><?php echo $text_total_order; ?></td>
              <td class="right"><?php echo $total_order; ?></td>
            </tr>
            <tr>
              <td class="left"><?php echo $text_total_customer; ?>
              <?php if ($total_customer_approval > 0) { ?>
                <a href="<?php echo $view_customers; ?>" title=""><span class="color" style="background-color:#DE5954; color:#FFF;"><?php echo $total_customer_approval; ?></span></a>
              <?php } else { ?>
                <a href="<?php echo $view_customers; ?>" title=""><span class="color" style="background-color:#AAA; color:#FFF;">&gt;</span></a>
              <?php } ?>
              </td>
              <td class="right"><?php echo $total_customer; ?></td>
            </tr>
            <tr>
              <td class="left"><?php echo $text_total_review; ?>
              <?php if ($total_review_approval > 0) { ?>
                <a href="<?php echo $view_reviews; ?>" title=""><span class="color" style="background-color:#DE5954; color:#FFF;"><?php echo $total_review_approval; ?></span></a>
              <?php } else { ?>
                <a href="<?php echo $view_reviews; ?>" title=""><span class="color" style="background-color:#AAA; color:#FFF;">&gt;</span></a>
              <?php } ?>
              </td>
              <td class="right"><?php echo $total_review; ?></td>
            </tr>
			<?php if ($allow_affiliate) { ?>
            <tr>
              <td class="left"><?php echo $text_total_affiliate; ?>
              <?php if ($total_affiliate_approval > 0) { ?>
                <a href="<?php echo $view_affiliates; ?>" title=""><span class="color" style="background-color:#DE5954; color:#FFF;"><?php echo $total_affiliate_approval; ?></span></a>
              <?php } else { ?>
                <a href="<?php echo $view_affiliates; ?>" title=""><span class="color" style="background-color:#AAA; color:#FFF;">&gt;</span></a>
              <?php } ?>
              </td>
              <td class="right"><?php echo $total_affiliate; ?></td>
            </tr>
			<?php } ?>
          </table>
        </div>
      </div>
      <div class="statistic">
        <div class="range"><?php echo $entry_range; ?>
          <select id="range" onchange="getSalesChart(this.value)">
            <option value="day"><?php echo $text_day; ?></option>
            <option value="week"><?php echo $text_week; ?></option>
            <option value="month"><?php echo $text_month; ?></option>
            <option value="year"><?php echo $text_year; ?></option>
          </select>
        </div>
        <div class="dashboard-heading"><?php echo $text_statistics; ?></div>
        <div class="dashboard-content">
          <div id="report" style="width:100%; height:230px;"></div> 
        </div>
      </div>
	  <div class="tiles">
        <div class="tile">
	      <div class="tile-red">
		    <p><a href="<?php echo $view_orders; ?>" title=""><img src="view/image/dashboard/order.png" alt="" /><?php echo $text_order_today; ?>&nbsp;<?php echo $total_order_today; ?></a></p>
          </div>
        </div>
		<div class="tile">
          <div class="tile-blue">
            <p><a href="<?php echo $view_customers; ?>" title=""><img src="view/image/dashboard/customer.png" alt="" /><?php echo $text_customer_today; ?>&nbsp;<?php echo $total_customer_today; ?></a></p>
          </div>
        </div>
		<div class="tile">
          <div class="tile-yellow">
            <p><a href="<?php echo $view_sales; ?>" title=""><img src="view/image/dashboard/sale.png" alt="" /><?php echo $text_sale_today; ?>&nbsp;<?php echo $total_sale_today; ?></a></p>
          </div>
        </div>
		<div class="tile">
		  <div class="tile-green">
            <p><a href="<?php echo $view_online; ?>" title=""><img src="view/image/dashboard/online.png" alt="" /><?php echo $text_online; ?>&nbsp;<?php echo $total_online; ?></a></p>
          </div>
		</div>
	  </div>
      <div class="latest">
        <div class="dashboard-heading"><?php echo $text_latest; ?></div>
        <div class="dashboard-content">
        <div id="latest_tabs" class="htabs">
          <a href="#tab-latest-order"><?php echo $tab_order; ?></a>
          <?php if ($customers) { ?>
            <a href="#tab-latest-customer"><?php echo $tab_customer; ?></a>
          <?php } ?>
          <?php if ($reviews) { ?>
            <a href="#tab-latest-review"><?php echo $tab_review; ?></a>
          <?php } ?>
          <?php if ($affiliates && $allow_affiliate) { ?>
            <a href="#tab-latest-affiliate"><?php echo $tab_affiliate; ?></a>
          <?php } ?>
        </div>
        <div id="tab-latest-order" class="htabs-content">
          <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $column_order; ?></td>
                <td class="left"><?php echo $column_customer; ?></td>
                <td class="left"><?php echo $column_date_added; ?></td>
                <td class="left"><?php echo $column_status; ?></td>
                <td class="left"><?php echo $column_total; ?></td>
                <td class="right"><?php echo $column_action; ?></td>
              </tr>
            </thead>
            <tbody>
            <?php if ($orders) { ?>
              <?php foreach ($orders as $order) { ?>
              <tr>
                <td class="center"><?php echo $order['order_id']; ?></td>
                <td class="left"><?php echo $order['customer']; ?></td>
                <td class="left"><?php echo $order['date_added']; ?></td>
                <td class="center"><?php echo $order['status']; ?></td>
                <td class="right"><?php echo $order['total']; ?></td>
                <td class="right"><?php foreach ($order['action'] as $action) { ?>
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
        </div>
        <?php if ($customers) { ?>
        <div id="tab-latest-customer" class="htabs-content">
          <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $column_customer; ?></td>
                <td class="left"><?php echo $column_email; ?></td>
                <td class="left"><?php echo $column_customer_group; ?></td>
                <td class="left"><?php echo $column_approved; ?></td>
                <td class="left"><?php echo $column_newsletter; ?></td>
                <td class="left"><?php echo $column_status; ?></td>
                <td class="left"><?php echo $column_date_added; ?></td>
                <td class="right"><?php echo $column_action; ?></td>
              </tr>
            </thead>
            <tbody>
            <?php if ($customers) { ?>
              <?php foreach ($customers as $customer) { ?>
              <tr>
                <td class="left"><?php echo $customer['name']; ?></td>
                <td class="left"><?php echo $customer['email']; ?></td>
                <td class="left"><?php echo $customer['customer_group']; ?></td>
                <td class="center"><?php echo $customer['approved']; ?></td>
                <td class="center"><?php echo $customer['newsletter']; ?></td>
                <?php if ($customer['status'] == 1) { ?>
                  <td class="center"><span class="enabled"><?php echo $text_enabled; ?></span></td>
                <?php } else { ?>
                  <td class="center"><span class="disabled"><?php echo $text_disabled; ?></span></td>
                <?php } ?>
                <td class="center"><?php echo $customer['date_added']; ?></td>
                <td class="right"><?php foreach ($customer['action'] as $action) { ?>
                  <a href="<?php echo $action['href']; ?>" class="button-form"><?php echo $action['text']; ?></a>
                <?php } ?></td>
              </tr>
              <?php } ?>
            <?php } else { ?>
              <tr>
                <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
              </tr>
            <?php } ?>
            </tbody>
          </table>
        </div>
        <?php } ?>
        <?php if ($reviews) { ?>
        <div id="tab-latest-review" class="htabs-content">
          <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $column_product; ?></td>
                <td class="left"><?php echo $column_author; ?></td>
                <td class="left"><?php echo $column_rating; ?></td>
                <td class="left"><?php echo $column_status; ?></td>
                <td class="left"><?php echo $column_date_added; ?></td>
                <td class="right"><?php echo $column_action; ?></td>
              </tr>
            </thead>
            <tbody>
            <?php if ($reviews) { ?>
              <?php foreach ($reviews as $review) { ?>
              <tr>
                <td class="left"><?php echo $review['name']; ?></td>
                <td class="left"><?php echo $review['author']; ?></td>
                <td class="center"><img src="view/image/rating/stars-<?php echo $review['rating'] . '.png'; ?>" alt="<?php echo $review['rating']; ?>" style="margin-top:2px;" /></td>
                <?php if ($review['status'] == 1) { ?>
                  <td class="center"><span class="enabled"><?php echo $text_enabled; ?></span></td>
                <?php } else { ?>
                  <td class="center"><span class="disabled"><?php echo $text_disabled; ?></span></td>
                <?php } ?>
                <td class="center"><?php echo $review['date_added']; ?></td>
                <td class="right"><?php foreach ($review['action'] as $action) { ?>
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
        </div>
        <?php } ?>
        <?php if ($affiliates && $allow_affiliate) { ?>
        <div id="tab-latest-affiliate" class="htabs-content">
          <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $column_affiliate; ?></td>
                <td class="left"><?php echo $column_email; ?></td>
                <td class="left"><?php echo $column_approved; ?></td>
                <td class="left"><?php echo $column_status; ?></td>
                <td class="left"><?php echo $column_date_added; ?></td>
                <td class="right"><?php echo $column_action; ?></td>
              </tr>
            </thead>
            <tbody>
            <?php if ($affiliates) { ?>
              <?php foreach ($affiliates as $affiliate) { ?>
              <tr>
                <td class="left"><?php echo $affiliate['name']; ?></td>
                <td class="left"><?php echo $affiliate['email']; ?></td>
                <td class="center"><?php echo $affiliate['approved']; ?></td>
                <?php if ($affiliate['status'] == 1) { ?>
                  <td class="center"><span class="enabled"><?php echo $text_enabled; ?></span></td>
                <?php } else { ?>
                  <td class="center"><span class="disabled"><?php echo $text_disabled; ?></span></td>
                <?php } ?>
                <td class="center"><?php echo $affiliate['date_added']; ?></td>
                <td class="right"><?php foreach ($affiliate['action'] as $action) { ?>
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
        </div>
        <?php } ?>
      </div>
    </div>
  </div>
</div>

<!--[if IE]>
<script type="text/javascript" src="view/javascript/jquery/flot/excanvas.min.js"></script>
<![endif]-->

<script type="text/javascript" src="view/javascript/jquery/flot/jquery.flot.min.js"></script> 
<script type="text/javascript" src="view/javascript/jquery/flot/jquery.flot.resize.min.js"></script> 

<script type="text/javascript"><!--
function getSalesChart(range) {
	$.ajax({
		type: 'get',
		url: 'index.php?route=common/home/chart&token=<?php echo $token; ?>&range=' + range,
		dataType: 'json',
		success: function(json) {
			var option = {
				shadowSize: 0,
				colors: ['#DE5954', '#4691D2'],
				bars: {
					show: true,
					fill: true,
					lineWidth: 1,
					barColor: '#222222'
				},
				grid: {
					backgroundColor: '#FFFFFF',
					hoverable: true
				},
				points: {
					show: false
				},
				xaxis: {
					show: true,
            		ticks: json['xaxis']
				}
			}

			$.plot($('#report'), [json['order'], json['customer']], option);
		},
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
	});
}

$(document).ready(function() {
	getSalesChart($('#range').val());
});
//--></script>

<script type="text/javascript"><!--
$(document).ready(function() {
	$('#latest_tabs a').tabs();
});
//--></script>

<?php echo $footer; ?>