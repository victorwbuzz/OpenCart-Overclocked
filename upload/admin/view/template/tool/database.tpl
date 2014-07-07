<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
	<?php } ?>
	</div>
	<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
	<?php } ?>
	<div class="box">
	<div class="heading">
		<h1><img src="view/image/backup.png" alt="" /> <?php echo $heading_title; ?></h1>
		<div class="buttons">
			<a onclick="location = '<?php echo $refresh; ?>';" class="button"><?php echo $button_refresh; ?></a>
		</div>
	</div>
	<div class="content">
		<?php if ($success_optimize) { ?>
			<div class="success" style="margin-top:10px;"><?php echo $success_optimize; ?></div>
		<?php } ?>
		<?php if ($success_repair) { ?>
			<div class="success" style="margin-top:10px;"><?php echo $success_repair; ?></div>
		<?php } ?>
		<form action="<?php echo $database; ?>" method="post" enctype="multipart/form-data" id="form" name="database">
			<h2><?php echo $text_optimize; ?></h2>
			<div>
				<table class="form">
					<tr style="text-align:left;">
						<td width="20%"><b><?php echo $text_optimize; ?></b></td>
						<td width="55%"><?php echo $text_help_optimize; ?></td>
						<td width="25%">
							<a onclick="Optimize();" class="button-form"><?php echo $button_optimize; ?></a>
						</td>
					</tr>
				</table>
			</div>
			<h2><?php echo $text_repair; ?></h2>
			<div>
				<table class="form">
					<tr style="text-align:left;">
						<td width="20%"><b><?php echo $text_repair; ?></b></td>
						<td width="55%"><?php echo $text_help_repair; ?></td>
						<td width="25%">
							<a onclick="Repair();" class="button-form"><?php echo $button_repair; ?></a>
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="buttonForm" value="" />
		</form>
	</div>
	</div>
</div>

<script type="text/javascript"><!--
function Optimize() {document.database.buttonForm.value='optimize'; $('#form').submit();}
function Repair() {document.database.buttonForm.value='repair'; $('#form').submit();}
//--></script>

<script type="text/javascript"><!--
$(function() { $('#tabs a').tabs(); });
//--></script>

<?php echo $footer; ?>