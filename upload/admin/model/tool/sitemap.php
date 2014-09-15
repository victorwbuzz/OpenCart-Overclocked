<?php
class ModelToolSitemap extends Model {

	public function generate_text() {
		$this->language->load('tool/sitemap');

		$output = '';

		//Generating TEXT sitemap
		$fp = fopen("../sitemap.txt", "w+");
		fwrite($fp, $this->getTextLinks());
		fwrite($fp, $this->getTextCategories(0));
		fclose($fp);
		$output .= "<img src=\"view/image/success.png\" alt=\"\" /> &nbsp; <b>" . HTTP_CATALOG . "sitemap.txt</b><br /><br />";

		return $output;
	}

	public function generate_xml() {
		$this->language->load('tool/sitemap');

		$output = '';

		//Generating XML sitemap
		$fp = fopen("../sitemap.xml", "w+");
		fwrite($fp, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r");
		fwrite($fp, "<urlset xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd\" xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\r");
		fwrite($fp, $this->getCommonPages());
		fwrite($fp, $this->getCategories(0));
		fwrite($fp, $this->getProducts());
		fwrite($fp, $this->getManufacturers());
		fwrite($fp, $this->getInformationPages());
		fwrite($fp, "</urlset>");
		fclose($fp);
		$output .= "<img src=\"view/image/success.png\" alt=\"\" /> &nbsp; <b>" . HTTP_CATALOG . "sitemap.xml</b><br /><br />";

		return $output;
	}

	public function generate_gzip() {
		$this->language->load('tool/sitemap');

		$output = '';

		// Generating GZIP sitemap (from XML)
		if ($fp_out = gzopen('../sitemap.xml.gz','wb9')) {
			if ($fp_in = fopen('../sitemap.xml','rb')) {
				while (!feof($fp_in))
				gzwrite ($fp_out, fread($fp_in,10000));
				fclose($fp_in);
			}
			gzclose($fp_out);
		}

		$output .= "<img src=\"view/image/success.png\" alt=\"\" /> &nbsp; <b>" . HTTP_CATALOG . "sitemap.xml.gz</b><br /><br />";

		return $output;
	}

	// Generators
	protected function getCategories($parent_id, $current_path = '') {
		$output = '';

		$this->load->model('catalog/sitemap');

		$store_id = 0;

		$results = $this->model_catalog_sitemap->getAllCategories($parent_id, $store_id);

		foreach ($results as $result) {
			if (!$current_path) {
				$new_path = $result['category_id'];
			} else {
				$new_path = $current_path . '_' . $result['category_id'];
			}

			$output .= $this->generateLinkNode(HTTP_CATALOG . 'index.php?route=product/category&path=' . $new_path);

			$output .= $this->getCategories($result['category_id'], $new_path);
		}

		$stores_cat = $this->model_catalog_sitemap->getAllStores();

		if ($stores_cat) {
			foreach ($stores_cat as $store_cat) {
				if ($store_cat['store_id'] != 0) {
					$results = $this->model_catalog_sitemap->getAllCategories($parent_id, $store_cat['store_id']);

					foreach ($results as $result) {
						$store_url = $store_cat['url'];

						if (!$current_path) {
							$new_path = $result['category_id'];
						} else {
							$new_path = $current_path . '_' . $result['category_id'];
						}

						$output .= $this->generateLinkNode($store_url . 'index.php?route=product/category&path=' . $new_path);

						$output .= $this->getCategories($result['category_id'], $new_path);
					}
				}
			}
		}

		return $output;
	}

	protected function getProducts() {
		$output = '';

		$this->load->model('catalog/sitemap');

		$store_id = 0;
		$store_url = HTTP_CATALOG;

		$results = $this->model_catalog_sitemap->getAllProducts($store_id);

		foreach ($results as $result) {
			$output .= $this->generateLinkNode($store_url . 'index.php?route=product/product&product_id=' . $result['product_id'], "weekly", "1.0");
		}

		$stores_pro = $this->model_catalog_sitemap->getAllStores();

		if ($stores_pro) {
			foreach ($stores_pro as $store_pro) {
				if ($store_pro['store_id'] != 0) {
					$results = $this->model_catalog_sitemap->getAllProducts($store_pro['store_id']);

					foreach ($results as $result) {
						$store_url = $store_pro['url'];

						$output .= $this->generateLinkNode($store_url . 'index.php?route=product/product&product_id=' . $result['product_id'], "weekly", "1.0");
					}
				}
			}
		}

		return $output;
	}

	protected function getManufacturers() {
		$output = '';

		$this->load->model('catalog/sitemap');

		$store_id = 0;
		$store_url = HTTP_CATALOG;

		$results = $this->model_catalog_sitemap->getAllManufacturers($store_id);

		foreach ($results as $result) {
			$output .= $this->generateLinkNode($store_url . 'index.php?route=product/manufacturer/info&manufacturer_id=' . $result['manufacturer_id'], "weekly", "1.0");
		}

		$stores_man = $this->model_catalog_sitemap->getAllStores();

		if ($stores_man) {
			foreach ($stores_man as $store_man) {
				if ($store_man['store_id'] != 0) {
					$store_url = $store_man['url'];

					$results = $this->model_catalog_sitemap->getAllManufacturers($store_man['store_id']);

					foreach ($results as $result) {
						$output .= $this->generateLinkNode($store_url . 'index.php?route=product/manufacturer/info&manufacturer_id=' . $result['manufacturer_id'], "weekly", "1.0");
					}
				}
			}
		}

		return $output;
	}

	protected function getInformationPages() {
		$output = '';

		$this->load->model('catalog/sitemap');

		$store_id = 0;
		$store_url = HTTP_CATALOG;

		$results = $this->model_catalog_sitemap->getAllInformations();

		foreach ($results as $result) {
			$output .= $this->generateLinkNode($store_url . 'index.php?route=information/information&information_id=' . $result['information_id'], "monthly", "1.0");
		}

		$stores_inf = $this->model_catalog_sitemap->getAllStores();

		if ($stores_inf) {
			foreach ($stores_inf as $store_inf) {
				if ($store_inf['store_id'] != 0) {
					$store_info_ids = array();

					$results = $this->model_catalog_sitemap->getAllInformations();

					foreach ($results as $result) {
						$store_info_ids = $this->model_catalog_sitemap->getInformationStores($result['information_id']);

						foreach ($store_info_ids as $store_info_id) {
							if ($store_info_id != 0) {
								$store_url = $this->model_catalog_sitemap->getStoreUrl($store_info_id);

								$output .= $this->generateLinkNode($store_url . 'index.php?route=information/information&information_id=' . $result['information_id'], "monthly", "1.0");
							}
						}
					}
				}
			}
		}

		return $output;
	}

	protected function getCommonPages() {
		$output = '';

		$this->load->model('catalog/sitemap');

		$output .= $this->standardLinkNode(HTTP_CATALOG . 'index.php');
		$output .= $this->standardLinkNode(HTTP_CATALOG . 'index.php?route=common/home');
		$output .= $this->standardLinkNode(HTTP_CATALOG . 'index.php?route=information/contact');
		$output .= $this->standardLinkNode(HTTP_CATALOG . 'index.php?route=information/sitemap');
		$output .= $this->standardLinkNode(HTTP_CATALOG . 'index.php?route=account/login');
		$output .= $this->standardLinkNode(HTTP_CATALOG . 'index.php?route=account/register');
		$output .= $this->standardLinkNode(HTTP_CATALOG . 'index.php?route=product/search');
		$output .= $this->standardLinkNode(HTTP_CATALOG . 'index.php?route=product/special');
		$output .= $this->standardLinkNode(HTTP_CATALOG . 'index.php?route=product/product_list');
		$output .= $this->standardLinkNode(HTTP_CATALOG . 'index.php?route=product/category_list');

		$stores_pag = $this->model_catalog_sitemap->getAllStores();

		if ($stores_pag) {
			foreach ($stores_pag as $store_pag) {
				if ($store_pag['store_id'] != 0) {
					$store_url = $store_pag['url'];

					$output .= $this->standardLinkNode($store_url . 'index.php');
					$output .= $this->standardLinkNode($store_url . 'index.php?route=common/home');
					$output .= $this->standardLinkNode($store_url . 'index.php?route=information/contact');
					$output .= $this->standardLinkNode($store_url . 'index.php?route=information/sitemap');
					$output .= $this->standardLinkNode($store_url . 'index.php?route=account/login');
					$output .= $this->standardLinkNode($store_url . 'index.php?route=account/register');
					$output .= $this->standardLinkNode($store_url . 'index.php?route=product/search');
					$output .= $this->standardLinkNode($store_url . 'index.php?route=product/special');
					$output .= $this->standardLinkNode($store_url . 'index.php?route=product/product_list');
					$output .= $this->standardLinkNode($store_url . 'index.php?route=product/category_list');
				}
			}
		}

		return $output;
	}

	// Text Sitemap - Other Links
	protected function getTextLinks() {
		$output = '';

		$store_id = 0;
		$store_url = HTTP_CATALOG;

		$this->load->model('catalog/sitemap');

		// Common Pages
		$output .= utf8_encode(HTTP_CATALOG . 'index.php') . "\r";
		$output .= utf8_encode(HTTP_CATALOG . 'index.php?route=common/home') . "\r";
		$output .= utf8_encode(HTTP_CATALOG . 'index.php?route=information/contact') . "\r";
		$output .= utf8_encode(HTTP_CATALOG . 'index.php?route=information/sitemap') . "\r";
		$output .= utf8_encode(HTTP_CATALOG . 'index.php?route=account/login') . "\r";
		$output .= utf8_encode(HTTP_CATALOG . 'index.php?route=account/register') . "\r";
		$output .= utf8_encode(HTTP_CATALOG . 'index.php?route=product/search') . "\r";
		$output .= utf8_encode(HTTP_CATALOG . 'index.php?route=product/special') . "\r";
		$output .= utf8_encode(HTTP_CATALOG . 'index.php?route=product/product_list') . "\r";
		$output .= utf8_encode(HTTP_CATALOG . 'index.php?route=product/category_list') . "\r";

		$stores_pag = $this->model_catalog_sitemap->getAllStores();

		if ($stores_pag) {
			foreach ($stores_pag as $store_pag) {
				if ($store_pag['store_id'] != 0) {
					$store_url = $store_pag['url'];

					$output .= utf8_encode($store_url . 'index.php') . "\r";
					$output .= utf8_encode($store_url . 'index.php?route=common/home') . "\r";
					$output .= utf8_encode($store_url . 'index.php?route=information/contact') . "\r";
					$output .= utf8_encode($store_url . 'index.php?route=information/sitemap') . "\r";
					$output .= utf8_encode($store_url . 'index.php?route=account/login') . "\r";
					$output .= utf8_encode($store_url . 'index.php?route=account/register') . "\r";
					$output .= utf8_encode($store_url . 'index.php?route=product/search') . "\r";
					$output .= utf8_encode($store_url . 'index.php?route=product/special') . "\r";
					$output .= utf8_encode($store_url . 'index.php?route=product/product_list') . "\r";
					$output .= utf8_encode($store_url . 'index.php?route=product/category_list') . "\r";
				}
			}
		}

		$this->load->model('tool/seo_url');

		// Products
		$store_id = 0;
		$store_url = HTTP_CATALOG;

		$products = $this->model_catalog_sitemap->getAllProducts($store_id);

		foreach ($products as $product) {
			$link = utf8_encode($store_url . 'index.php?route=product/product&product_id=' . $product['product_id']);

			$link = $this->model_tool_seo_url->rewrite($link);

			$output .= str_replace("&", "&amp;", $link) . "\r";
		}

		$stores_pro = $this->model_catalog_sitemap->getAllStores();

		if ($stores_pro) {
			foreach ($stores_pro as $store_pro) {
				if ($store_pro['store_id'] != 0) {
					$products = $this->model_catalog_sitemap->getAllProducts($store_pro['store_id']);

					foreach ($products as $product) {
						$store_url = $store_pro['url'];

						$link = utf8_encode($store_url . 'index.php?route=product/product&product_id=' . $product['product_id']);

						$link = $this->model_tool_seo_url->rewrite($link);

						$output .= str_replace("&", "&amp;", $link) . "\r";
					}
				}
			}
		}

		// Manufacturers
		$store_id = 0;
		$store_url = HTTP_CATALOG;

		$manufacturers = $this->model_catalog_sitemap->getAllManufacturers($store_id);

		foreach ($manufacturers as $manufacturer) {
			$link = utf8_encode($store_url . 'index.php?route=product/manufacturer/info&manufacturer_id=' . $manufacturer['manufacturer_id']);

			$link = $this->model_tool_seo_url->rewrite($link);

			$output .= str_replace("&", "&amp;", $link) . "\r";
		}

		$stores_man = $this->model_catalog_sitemap->getAllStores();

		if ($stores_man) {
			foreach ($stores_man as $store_man) {
				if ($store_man['store_id'] != 0) {
					$store_url = $store_man['url'];

					$manufacturers = $this->model_catalog_sitemap->getAllManufacturers($store_man['store_id']);

					foreach ($manufacturers as $manufacturer) { 
						$link = utf8_encode($store_url . 'index.php?route=product/manufacturer/info&manufacturer_id=' . $manufacturer['manufacturer_id']);

						$link = $this->model_tool_seo_url->rewrite($link);

						$output .= str_replace("&", "&amp;", $link) . "\r";
					}
				}
			}
		}

		// Information
		$store_id = 0;
		$store_url = HTTP_CATALOG;

		$informations = $this->model_catalog_sitemap->getAllInformations();

		foreach ($informations as $information) {
			$link = utf8_encode($store_url . 'index.php?route=information/information&information_id=' . $information['information_id']);

			$link = $this->model_tool_seo_url->rewrite($link);

			$output .= str_replace("&", "&amp;", $link) . "\r";
		}

		$stores_inf = $this->model_catalog_sitemap->getAllStores();

		if ($stores_inf) {
			foreach ($stores_inf as $store_inf) {
				if ($store_inf['store_id'] != 0) {
					$store_info_ids = array();

					$informations = $this->model_catalog_sitemap->getAllInformations();

					foreach ($informations as $information) {
						$store_info_ids = $this->model_catalog_sitemap->getInformationStores($information['information_id']);

						foreach ($store_info_ids as $store_info_id) {
							if ($store_info_id != 0) {
								$store_url = $this->model_catalog_sitemap->getStoreUrl($store_info_id);

								$link = utf8_encode($store_url . 'index.php?route=information/information&information_id=' . $information['information_id']);

								$link = $this->model_tool_seo_url->rewrite($link);

								$output .= str_replace("&", "&amp;", $link) . "\r";
							}
						}
					}
				}
			}
		}

		return $output;
	}

	// Text Sitemap - Categories
	protected function getTextCategories($parent_id, $current_path = '') {
		$output = '';

		$this->load->model('catalog/sitemap');
		$this->load->model('tool/seo_url');

		$store_id = 0;

		$results = $this->model_catalog_sitemap->getAllCategories($parent_id, $store_id);

		foreach ($results as $result) {
			if (!$current_path) {
				$new_path = $result['category_id'];
			} else {
				$new_path = $current_path . '_' . $result['category_id'];
			}

			$link = utf8_encode(HTTP_CATALOG . 'index.php?route=product/category&path=' . $new_path);

			$link = $this->model_tool_seo_url->rewrite($link);

			$output .= str_replace("&", "&amp;", $link) . "\r";

			$output .= $this->getTextCategories($result['category_id'], $new_path);
		}

		$stores_cat = $this->model_catalog_sitemap->getAllStores();

		if ($stores_cat) {
			foreach ($stores_cat as $store_cat) {
				if ($store_cat['store_id'] != 0) {
					$results = $this->model_catalog_sitemap->getAllCategories($parent_id, $store_cat['store_id']);

					foreach ($results as $result) {
						$store_url = $store_cat['url'];

						if (!$current_path) {
							$new_path = $result['category_id'];
						} else {
							$new_path = $current_path . '_' . $result['category_id'];
						}

						$link = utf8_encode($store_url . 'index.php?route=product/category&path=' . $new_path);

						$link = $this->model_tool_seo_url->rewrite($link);

						$output .= str_replace("&", "&amp;", $link) . "\r";

						$output .= $this->getTextCategories($result['category_id'], $new_path);
					}
				}
			}
		}

		return $output;
	}

	protected function generateLinkNode($link, $changefreq = 'monthly', $priority = '1.0') {
		$this->load->model('tool/seo_url');

		$link = $this->model_tool_seo_url->rewrite($link);

		$link = str_replace("&", "&amp;", $link);

		$output = "<url>";
		$output .= "<loc>" . $link . "</loc>";
		$output .= "<lastmod>" . date("Y-m-d") . "</lastmod>";
		$output .= "<changefreq>" . $changefreq . "</changefreq>";
		$output .= "<priority>" . $priority . "</priority>";
		$output .= "</url>\r";

		return $output;
	}

	protected function standardLinkNode($link, $changefreq = 'monthly', $priority = '1.0') {
		$link = str_replace("&", "&amp;", $link);

		$output = "<url>";
		$output .= "<loc>" . $link . "</loc>";
		$output .= "<lastmod>" . date("Y-m-d") . "</lastmod>";
		$output .= "<changefreq>" . $changefreq . "</changefreq>";
		$output .= "<priority>" . $priority . "</priority>";
		$output .= "</url>\r";

		return $output;
	}
}
?>