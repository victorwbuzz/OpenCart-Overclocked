<?php
class ModelToolSystem extends Model {

	public function deleteDirectory($dir) {
		if (!file_exists($dir)) {
			return true;
		}

		if (!is_dir($dir) || is_link($dir)) {
			return unlink($dir);
		}

		clearstatcache();

		foreach (scandir($dir) as $item) {
			if ($item == '.' || $item == '..') {
				continue;
			}

			if (!$this->deleteDirectory($dir . "/" . $item)) {
				chmod($dir . "/" . $item, 0777);

				if (!$this->deleteDirectory($dir . "/" . $item)) {
					return false;
				}
			}
		}

		return rmdir($dir);
	}

	public function setupSeo() {
		if (!file_exists('../.htaccess')) {
			if (file_exists('../.htaccess.txt') && is_writable('../.htaccess.txt')) {
				$file = fopen('../.htaccess.txt', 'a');

				$data = file_get_contents('../.htaccess.txt');

				$root = rtrim(HTTP_SERVER, '/');

				$folder = substr(strrchr($root, '/'), 1);

				$path = rtrim(rtrim(dirname($_SERVER['SCRIPT_NAME']), ''), '/' . $folder . '.\\');

				if (strlen($path) > 1) {
					$path .= '/';
				}

				if (!$path) {
					$path = '/';
				}

				$data = str_replace('RewriteBase /', 'RewriteBase ' . $path, $data);

				file_put_contents('../.htaccess.txt', $data);

				fclose($file);

				clearstatcache();

				rename('../.htaccess.txt', '../.htaccess');
			}
		}
	}
}
?>