<?php
class ControllerInformationContact extends Controller {
	private $error = array();

	public function index() {
		$this->language->load('information/contact');

		$this->document->setTitle($this->language->get('heading_title'));

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			unset($this->session->data['captcha']);

			// Log mail
			$mail_log  = $this->request->post['name'] . " ( " . $this->request->post['email'] . " ) :\n";
			$mail_log .= $this->request->post['enquiry'] . "\n\n";

			$mail_file = DIR_SYSTEM . 'mails/mails.txt';

			$handle = fopen($mail_file, 'a+');

			fwrite($handle, date('Y-m-d G:i:s') . ' - ' . print_r($mail_log, true));

			fclose($handle);

			// Send mail
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->hostname = $this->config->get('config_smtp_host');
			$mail->username = $this->config->get('config_smtp_username');
			$mail->password = $this->config->get('config_smtp_password');
			$mail->port = $this->config->get('config_smtp_port');
			$mail->timeout = $this->config->get('config_smtp_timeout');
			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->request->post['email']);
			$mail->setSender($this->request->post['name']);
			$mail->setSubject(html_entity_decode(sprintf($this->language->get('email_subject'), $this->request->post['name']), ENT_QUOTES, 'UTF-8'));
			$mail->setText(strip_tags(html_entity_decode($this->request->post['enquiry'], ENT_QUOTES, 'UTF-8')));
			$mail->send();

			$this->redirect($this->url->link('information/contact/success'));
		}

		// Breadcrumbs
		$this->data['hidecrumbs'] = $this->config->get('config_breadcrumbs');

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'		=> $this->language->get('text_home'),
			'href'		=> $this->url->link('common/home'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'		=> $this->language->get('heading_title'),
			'href'		=> $this->url->link('information/contact'),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_location'] = $this->language->get('text_location');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_geolocation'] = $this->language->get('text_geolocation');
		$this->data['text_latitude'] = $this->language->get('text_latitude');
		$this->data['text_longitude'] = $this->language->get('text_longitude');

		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_enquiry'] = $this->language->get('entry_enquiry');
		$this->data['entry_captcha'] = $this->language->get('entry_captcha');

		$this->data['hide_location'] = $this->config->get('config_our_location');

		$map_location = $this->config->get('config_location');
		$map_display = $this->config->get('config_contact_map');

		if (isset($map_display) && !empty($map_location)) {
			$this->document->addScript('catalog/view/javascript/gmap/gmap3.min.js');
			$this->document->addScript('catalog/view/javascript/gmap/gmap3.infobox.js');

			$this->data['map_location'] = $map_location;
			$this->data['map_latitude'] = $this->config->get('config_latitude');
			$this->data['map_longitude'] = $this->config->get('config_longitude');

			$this->data['map'] = true;
		} else {
			$this->data['map_location'] = '';
			$this->data['map_latitude'] = '';
			$this->data['map_longitude'] = '';

			$this->data['map'] = false;
		}

		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}

		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}

		if (isset($this->error['enquiry'])) {
			$this->data['error_enquiry'] = $this->error['enquiry'];
		} else {
			$this->data['error_enquiry'] = '';
		}

		if (isset($this->error['captcha'])) {
			$this->data['error_captcha'] = $this->error['captcha'];
		} else {
			$this->data['error_captcha'] = '';
		}

		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['action'] = $this->url->link('information/contact');

		$this->data['store'] = $this->config->get('config_name');
		$this->data['address'] = nl2br($this->config->get('config_address'));
		$this->data['telephone'] = $this->config->get('config_telephone');
		$this->data['fax'] = $this->config->get('config_fax');

		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} else {
			$this->data['name'] = $this->customer->getFirstName();
		}

		if (isset($this->request->post['email'])) {
			$this->data['email'] = $this->request->post['email'];
		} else {
			$this->data['email'] = $this->customer->getEmail();
		}

		if (isset($this->request->post['enquiry'])) {
			$this->data['enquiry'] = $this->request->post['enquiry'];
		} else {
			$this->data['enquiry'] = '';
		}

		if (isset($this->request->post['captcha'])) {
			$this->data['captcha'] = $this->request->post['captcha'];
		} else {
			$this->data['captcha'] = '';
		}

		$directory = DIR_SYSTEM . 'mails/';

		// Create directory if it does not exist.
		if (!is_dir($directory)) {
			mkdir(DIR_SYSTEM . 'mails', 0777);
		}

		$mail_file = DIR_SYSTEM . 'mails/mails.txt';

		// Create file if it does not exist.
		if (!file_exists($mail_file)) {
			$handle = fopen($mail_file, 'w+');

			fclose($handle);
		}

		// Template
		$this->data['template'] = $this->config->get('config_template');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/contact.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/contact.tpl';
		} else {
			$this->template = 'default/template/information/contact.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_header',
			'common/content_top',
			'common/content_bottom',
			'common/content_footer',
			'common/footer',
			'common/header'
		);

		$this->response->setOutput($this->render());
	}

	public function success() {
		$this->language->load('information/contact');

		$this->document->setTitle($this->language->get('heading_title'));

		// Breadcrumbs
		$this->data['hidecrumbs'] = $this->config->get('config_breadcrumbs');

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'		=> $this->language->get('text_home'),
			'href'		=> $this->url->link('common/home'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'		=> $this->language->get('heading_title'),
			'href'		=> $this->url->link('information/contact'),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_message'] = $this->language->get('text_message');

		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['continue'] = $this->url->link('common/home');

		// Template
		$this->data['template'] = $this->config->get('config_template');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/success.tpl';
		} else {
			$this->template = 'default/template/common/success.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_header',
			'common/content_top',
			'common/content_bottom',
			'common/content_footer',
			'common/footer',
			'common/header'
		);

		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if (!isset($this->request->post['name']) || (utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 32)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		if (!isset($this->request->post['email']) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if (!isset($this->request->post['enquiry']) || (utf8_strlen($this->request->post['enquiry']) < 10) || (utf8_strlen($this->request->post['enquiry']) > 3000)) {
			$this->error['enquiry'] = $this->language->get('error_enquiry');
		}

		if (!isset($this->request->post['captcha']) || empty($this->session->data['captcha']) || ($this->session->data['captcha'] != strtolower($this->request->post['captcha']))) {
			$this->error['captcha'] = $this->language->get('error_captcha');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	public function captcha() {
		$this->load->library('captcha');

		$font = $this->config->get('config_captcha_font');

		$captcha = new Captcha();

		$this->session->data['captcha'] = $captcha->getCode();

		$captcha->showImage($font);
	}
}
?>