<?php
class ControllerProductProductWall extends Controller {

	public function index() {
		$this->language->load('product/product_wall');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product');
		$this->load->model('tool/image');

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
		} else {
			$limit = $this->config->get('config_catalog_limit');
		}

		$this->document->addScript('catalog/view/javascript/jquery/jquery.total-storage.min.js');

		// Breadcrumbs
		$this->data['hidecrumbs'] = $this->config->get('config_breadcrumbs');

		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'		=> $this->language->get('text_home'),
			'href'		=> $this->url->link('common/home'),
       		'separator' => false
   		);	

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}

		$this->data['breadcrumbs'][] = array(
			'text'		=> $this->language->get('heading_title'),
			'href'		=> $this->url->link('product/product_wall', $url),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_refine'] = $this->language->get('text_refine');
		$this->data['text_empty'] = $this->language->get('text_empty');
		$this->data['text_quantity'] = $this->language->get('text_quantity');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_model'] = $this->language->get('text_model');
		$this->data['text_price'] = $this->language->get('text_price');
		$this->data['text_tax'] = $this->language->get('text_tax');
		$this->data['text_points'] = $this->language->get('text_points');
		$this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		$this->data['text_display'] = $this->language->get('text_display');
		$this->data['text_list'] = $this->language->get('text_list');
		$this->data['text_grid'] = $this->language->get('text_grid');
		$this->data['text_sort'] = $this->language->get('text_sort');
		$this->data['text_limit'] = $this->language->get('text_limit');

		$this->data['lang'] = $this->language->get('code');

		$this->data['button_cart'] = $this->language->get('button_cart');
		$this->data['button_wishlist'] = $this->language->get('button_wishlist');
		$this->data['button_compare'] = $this->language->get('button_compare');
		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['compare'] = $this->url->link('product/compare');

		$this->data['label'] = $this->config->get('config_offer_label');

		$this->load->model('catalog/offer');

		$offers = $this->model_catalog_offer->getListProductOffers(0);

		$this->data['continue'] = $this->url->link('common/home');

		$this->data['products'] = array();

		$data = array(
			'sort'		=> $sort,
			'order'	=> $order,
			'start'	=> ($page - 1) * $limit,
			'limit'		=> $limit
		);

		$product_total = $this->model_catalog_product->getTotalProducts($data); 

		$results = $this->model_catalog_product->getProducts($data);

		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
			} else {
				$image = false;
			}

			if ($result['manufacturer'] && $this->config->get('config_manufacturer_name')) {
				$manufacturer = $result['manufacturer'];
			} else {
				$manufacturer = false;
			}

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}

			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$special = false;
			}

			if ($this->config->get('config_tax')) {
				$tax = $this->currency->format((float)$result['special']) ? $result['special'] : $result['price'];
			} else {
				$tax = false;
			}

			if ($this->config->get('config_review_status')) {
				$rating = (int)$result['rating'];
			} else {
				$rating = false;
			}

			if (in_array($result['product_id'], $offers, true)) {
				$offer = true;
			} else {
				$offer = false;
			}

			$this->data['products'][] = array(
				'product_id'  	=> $result['product_id'],
				'thumb'       	=> $image,
				'offer'       		=> $offer,
				'manufacturer'	=> $manufacturer,
				'name'        	=> $result['name'],
				'description' 	=> utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 200) . '..',
				'price'       		=> $price,
				'special'			=> $special,
				'tax'				=> $tax,
				'rating'			=> $result['rating'],
				'reviews'			=> sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
				'href'				=> $this->url->link('product/product', 'product_id=' . $result['product_id'])
			);
		}

		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}

		$this->data['sorts'] = array();

		$this->data['sorts'][] = array(
			'text'  	=> $this->language->get('text_default'),
			'value' 	=> 'p.sort_order-ASC',
			'href'  	=> $this->url->link('product/product_wall', 'sort=p.sort_order&order=ASC' . $url)
		);

		$this->data['sorts'][] = array(
			'text'  	=> $this->language->get('text_name_asc'),
			'value' 	=> 'pd.name-ASC',
			'href'  	=> $this->url->link('product/product_wall', 'sort=pd.name&order=ASC' . $url)
		);

		$this->data['sorts'][] = array(
			'text'  	=> $this->language->get('text_name_desc'),
			'value' 	=> 'pd.name-DESC',
			'href'  	=> $this->url->link('product/product_wall', 'sort=pd.name&order=DESC' . $url)
		);

		$this->data['sorts'][] = array(
			'text'  	=> $this->language->get('text_price_asc'),
			'value' 	=> 'p.price-ASC',
			'href'  	=> $this->url->link('product/product_wall', 'sort=p.price&order=ASC' . $url)
		);

		$this->data['sorts'][] = array(
			'text'  	=> $this->language->get('text_price_desc'),
			'value' 	=> 'p.price-DESC',
			'href'  	=> $this->url->link('product/product_wall', 'sort=p.price&order=DESC' . $url)
		);

		if ($this->config->get('config_review_status')) {
			$this->data['sorts'][] = array(
				'text'  	=> $this->language->get('text_rating_desc'),
				'value' 	=> 'rating-DESC',
				'href'  	=> $this->url->link('product/product_wall', 'sort=rating&order=DESC' . $url)
			);

			$this->data['sorts'][] = array(
				'text'  	=> $this->language->get('text_rating_asc'),
				'value' 	=> 'rating-ASC',
				'href'  	=> $this->url->link('product/product_wall', 'sort=rating&order=ASC' . $url)
			);
		}

		$this->data['sorts'][] = array(
			'text'  	=> $this->language->get('text_model_asc'),
			'value' 	=> 'p.model-ASC',
			'href' 		=> $this->url->link('product/product_wall', 'sort=p.model&order=ASC' . $url)
		);

		$this->data['sorts'][] = array(
			'text'  	=> $this->language->get('text_model_desc'),
			'value' 	=> 'p.model-DESC',
			'href'  	=> $this->url->link('product/product_wall', 'sort=p.model&order=DESC' . $url)
		);

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$this->data['limits'] = array();

		$limits = array_unique(array($this->config->get('config_catalog_limit'), 25, 50, 75, 100));

		sort ($limits);

		foreach ($limits as $value) {
			$this->data['limits'][] = array(
				'text'  	=> $value,
				'value' 	=> $value,
				'href'  	=> $this->url->link('product/product_wall', $url . '&limit=' . $value)
			);
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}

		$pagination = new Pagination();
		$pagination->total = $product_total;
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('product/product_wall', $url . '&page={page}');

		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		$this->data['limit'] = $limit;

		// Template
		$this->data['template'] = $this->config->get('config_template');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/product_wall.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/product/product_wall.tpl';
		} else {
			$this->template = 'default/template/product/product_wall.tpl';
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
}
?>