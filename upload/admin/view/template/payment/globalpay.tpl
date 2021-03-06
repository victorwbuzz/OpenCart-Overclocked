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
  <div class="attention"><?php echo $text_url_message; ?></div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
        <a onclick="$('#form').submit();" class="button-save"><?php echo $button_save; ?></a>
        <a onclick="apply();" class="button-save"><?php echo $button_apply; ?></a>
        <a href="<?php echo $cancel; ?>" class="button-cancel"><?php echo $button_cancel; ?></a>
      </div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs">
        <a href="#tab-api"><?php echo $tab_api; ?></a>
        <a href="#tab-account"><?php echo $tab_account; ?></a>
        <a href="#tab-order-status"><?php echo $tab_order_status; ?></a>
        <a href="#tab-payment"><?php echo $tab_payment; ?></a>
        <a href="#tab-advanced"><?php echo $tab_advanced; ?></a>
      </div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
	  <div id="tab-api">
        <table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $entry_merchant_id; ?></td>
            <td><input type="text" name="globalpay_merchant_id" value="<?php echo $globalpay_merchant_id; ?>" size="30" />
            <?php if ($error_merchant_id) { ?>
              <span class="error"><?php echo $error_merchant_id; ?></span>
            <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_secret; ?></td>
            <td><input type="password" name="globalpay_secret" value="<?php echo $globalpay_secret; ?>" size="30" />
            <?php if ($error_secret) { ?>
              <span class="error"><?php echo $error_secret; ?></span>
            <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_rebate_password; ?></td>
            <td><input type="password" name="globalpay_rebate_password" value="<?php echo $globalpay_rebate_password; ?>" size="30" /></td>
          </td>
          <tr>
            <td><?php echo $entry_live_demo; ?></td>
            <td><select name="globalpay_live_demo">
              <?php if ($globalpay_live_demo) { ?>
                <option value="1" selected="selected"><?php echo $text_live; ?></option>
                <option value="0"><?php echo $text_demo; ?></option>
              <?php } else { ?>
                <option value="1"><?php echo $text_live; ?></option>
                <option value="0" selected="selected"><?php echo $text_demo; ?></option>
              <?php } ?>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_geo_zone; ?></td>
            <td><select name="globalpay_geo_zone_id">
              <option value="0"><?php echo $text_all_zones; ?></option>
              <?php foreach ($geo_zones as $geo_zone) { ?>
                <?php if ($geo_zone['geo_zone_id'] == $globalpay_geo_zone_id) { ?>
                  <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                <?php } else { ?>
                  <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                <?php } ?>
              <?php } ?>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_debug; ?></td>
            <td><select name="globalpay_debug">
              <?php if ($globalpay_debug) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
              <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
              <?php } ?>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="globalpay_status">
              <?php if ($globalpay_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
              <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
              <?php } ?>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_total; ?></td>
            <td><input type="text" name="globalpay_total" value="<?php echo $globalpay_total; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="globalpay_sort_order" value="<?php echo $globalpay_sort_order; ?>" size="5" /></td>
          </tr>
        </table>
      </div>
      <div id="tab-account">
        <table class="list">
          <thead>
            <tr>
              <td class="left"><?php echo $text_card_type; ?></td>
              <td class="center"><?php echo $text_enabled; ?></td>
              <td class="center"><?php echo $text_use_default; ?></td>
              <td class="left"><?php echo $text_subaccount; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="left"><?php echo $text_card_visa; ?></td>
              <td class="center"><input type="checkbox" name="globalpay_account[visa][enabled]" value="1" <?php if (isset($globalpay_account['visa']['enabled']) && $globalpay_account['visa']['enabled'] == 1) { echo 'checked="checked" '; } ?> /></td>
              <td class="center"><input type="checkbox" name="globalpay_account[visa][default]" value="1" <?php if (isset($globalpay_account['visa']['default']) && $globalpay_account['visa']['default'] == 1) { echo 'checked="checked" '; } ?> /></td>
              <td class="right"><input type="text" name="globalpay_account[visa][merchant_id]" value="<?php echo isset($globalpay_account['visa']['merchant_id']) ? $globalpay_account['visa']['merchant_id'] : ''; ?>" /></td>
            </tr>
            <tr>
              <td class="left"><?php echo $text_card_master; ?></td>
              <td class="center"><input type="checkbox" name="globalpay_account[mc][enabled]" value="1" <?php if (isset($globalpay_account['mc']['enabled']) && $globalpay_account['mc']['enabled'] == 1) { echo 'checked="checked" '; } ?> /></td>
              <td class="center"><input type="checkbox" name="globalpay_account[mc][default]" value="1" <?php if (isset($globalpay_account['mc']['default']) && $globalpay_account['mc']['default'] == 1) { echo 'checked="checked" '; } ?> /></td>
              <td class="right"><input type="text" name="globalpay_account[mc][merchant_id]" value="<?php echo isset($globalpay_account['mc']['merchant_id']) ? $globalpay_account['mc']['merchant_id'] : ''; ?>" /></td>
            </tr>
            <tr>
              <td class="left"><?php echo $text_card_amex; ?></td>
              <td class="center"><input type="checkbox" name="globalpay_account[amex][enabled]" value="1" <?php if (isset($globalpay_account['amex']['enabled']) && $globalpay_account['amex']['enabled'] == 1) { echo 'checked="checked" '; } ?> /></td>
              <td class="center"><input type="checkbox" name="globalpay_account[amex][default]" value="1" <?php if (isset($globalpay_account['amex']['default']) && $globalpay_account['amex']['default'] == 1) { echo 'checked="checked" '; } ?> /></td>
              <td class="right"><input type="text" name="globalpay_account[amex][merchant_id]" value="<?php echo isset($globalpay_account['amex']['merchant_id']) ? $globalpay_account['amex']['merchant_id'] : ''; ?>" /></td>
            </tr>
            <tr>
              <td class="left"><?php echo $text_card_switch; ?></td>
              <td class="center"><input type="checkbox" name="globalpay_account[switch][enabled]" value="1" <?php if (isset($globalpay_account['switch']['enabled']) && $globalpay_account['switch']['enabled'] == 1) { echo 'checked="checked" '; } ?> /></td>
              <td class="center"><input type="checkbox" name="globalpay_account[switch][default]" value="1" <?php if (isset($globalpay_account['switch']['default']) && $globalpay_account['switch']['default'] == 1) { echo 'checked="checked" '; } ?> /></td>
              <td class="right"><input type="text" name="globalpay_account[switch][merchant_id]" value="<?php echo isset($globalpay_account['switch']['merchant_id']) ? $globalpay_account['switch']['merchant_id'] : ''; ?>" /></td>
            </tr>
            <tr>
              <td class="left"><?php echo $text_card_laser; ?></td>
              <td class="center"><input type="checkbox" name="globalpay_account[laser][enabled]" value="1" <?php if (isset($globalpay_account['laser']['enabled']) && $globalpay_account['laser']['enabled'] == 1) { echo 'checked="checked" '; } ?> /></td>
              <td class="center"><input type="checkbox" name="globalpay_account[laser][default]" value="1" <?php if (isset($globalpay_account['laser']['default']) && $globalpay_account['laser']['default'] == 1) { echo 'checked="checked" '; } ?> /></td>
              <td class="right"><input type="text" name="globalpay_account[laser][merchant_id]" value="<?php echo isset($globalpay_account['laser']['merchant_id']) ? $globalpay_account['laser']['merchant_id'] : ''; ?>" /></td>
            </tr>
            <tr>
              <td class="left"><?php echo $text_card_diners; ?></td>
              <td class="center"><input type="checkbox" name="globalpay_account[diners][enabled]" value="1" <?php if (isset($globalpay_account['diners']['enabled']) && $globalpay_account['diners']['enabled'] == 1) { echo 'checked="checked" '; } ?> /></td>
              <td class="center"><input type="checkbox" name="globalpay_account[diners][default]" value="1" <?php if (isset($globalpay_account['diners']['default']) && $globalpay_account['diners']['default'] == 1) { echo 'checked="checked" '; } ?> /></td>
              <td class="right"><input type="text" name="globalpay_account[diners][merchant_id]" value="<?php echo isset($globalpay_account['diners']['merchant_id']) ? $globalpay_account['diners']['merchant_id'] : ''; ?>" /></td>
            </tr>
          </tbody>
        </table>
      </div>
      <div id="tab-order-status">
        <table class="form">
          <tr>
            <td><?php echo $entry_status_success_settled; ?></td>
            <td><select name="globalpay_order_status_success_settled_id">
              <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $globalpay_order_status_success_settled_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
              <?php } ?>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_status_success_unsettled; ?></td>
            <td><select name="globalpay_order_status_success_unsettled_id">
              <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $globalpay_order_status_success_unsettled_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
              <?php } ?>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_status_decline; ?></td>
            <td><select name="globalpay_order_status_decline_id">
              <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $globalpay_order_status_decline_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
              <?php } ?>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_status_decline_pending; ?></td>
            <td><select name="globalpay_order_status_decline_pending_id">
              <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $globalpay_order_status_decline_pending_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
              <?php } ?>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_status_decline_stolen; ?></td>
            <td><select name="globalpay_order_status_decline_stolen_id">
              <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $globalpay_order_status_decline_stolen_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
              <?php } ?>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_status_decline_bank; ?></td>
            <td><select name="globalpay_order_status_decline_bank_id">
              <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $globalpay_order_status_decline_bank_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
              <?php } ?>
            </select></td>
          </tr>
        </table>
      </div>
      <div id="tab-payment">
        <table class="form">
          <tr>
            <td><?php echo $entry_auto_settle; ?></td>
            <td><select name="globalpay_auto_settle">
              <option value="0" <?php echo ($globalpay_auto_settle == 0 ? ' selected' : ''); ?>><?php echo $text_settle_delayed; ?></option>
              <option value="1" <?php echo ($globalpay_auto_settle == 1 ? ' selected' : ''); ?>><?php echo $text_settle_auto; ?></option>
              <option value="2" <?php echo ($globalpay_auto_settle == 2 ? ' selected' : ''); ?>><?php echo $text_settle_multi; ?></option>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_card_select; ?></td>
            <td><select name="globalpay_card_select">
              <?php if ($globalpay_card_select) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
              <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
              <?php } ?>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_tss_check; ?></td>
            <td><select name="globalpay_tss_check">
              <?php if ($globalpay_tss_check) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
              <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
              <?php } ?>
            </select></td>
          </tr>
        </table>
      </div>
      <div id="tab-advanced">
        <table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $entry_live_url; ?></td>
            <td><input type="text" name="globalpay_live_url" value="<?php echo $globalpay_live_url; ?>" size="40" />
            <?php if ($error_live_url) { ?>
              <span class="error"><?php echo $error_live_url; ?></span>
            <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_demo_url; ?></td>
            <td><input type="text" name="globalpay_demo_url" value="<?php echo $globalpay_demo_url; ?>" size="40" />
            <?php if ($error_demo_url) { ?>
              <span class="error"><?php echo $error_demo_url; ?></span>
            <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_notification_url; ?></td>
            <td><?php echo $notify_url; ?></td>
          </tr>
        </table>
      </div>
    </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>

<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script>