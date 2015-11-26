namespace Ice\Mvc;

use Ice\Error;

/**
 * HTTP请求类
 * @author kelezyb
 */
class Http
{
    /**
     *
     * @var resource
     */
	private _handler;

    /**
     * 构造函数
     */
	public function __construct()
	{
		//let _handler = curl_init();
	}

    /**
     * GET获取页面数据
     * @param string url
     * @return string
     */
	public function get(string url) -> string
	{
		let this->_handler = curl_init();
		curl_setopt(this->_handler, CURLOPT_URL, url);
		curl_setopt(this->_handler, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt(this->_handler, CURLOPT_HEADER, 0);
		var output = curl_exec(this->_handler);
		this->check();
		curl_close(this->_handler);

		return output;
	}

    /**
     * POST获取页面数据
     * @param string url
     * @return string
     */
	public function post(string url, array params) -> string
	{
		let this->_handler = curl_init();

		curl_setopt(this->_handler, CURLOPT_URL, url);
		curl_setopt(this->_handler, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt(this->_handler, CURLOPT_HEADER, 0);
		curl_setopt(this->_handler, CURLOPT_POST, 1);
		curl_setopt(this->_handler, CURLOPT_POSTFIELDS, params);
		var output = curl_exec(this->_handler);
		this->check();
		curl_close(this->_handler);

		return output;
	}

    /**
     * 排序数据
     * @param array value
     * @return array
     */
	protected function sort(array value) -> array
	{
		ksort(value);
		return value;
	}

    /**
     * 安全模式获取页面数据
     * @param string url
     * @return string
     */
	public function secret_post(string url, array params, string secret="") -> string
	{
		var arr;
		let arr = this->sort(params);

		var k, v;
		var ss = [];
		for k, v in arr {
			let ss[] = "%s%s"->format(k, v);
		}

		var secretstr = md5("%s%s"->format(join("", ss), secret));
		let params["secret"] = secretstr;
		let params["time"] = time();

		return this->post(url, params);
	}

	public function decode_post(string url, array params) -> string
	{
	    var dedata = this->post(url, params);
        return json_decode(gzuncompress(dedata), true);
	}

    /**
     * 检查错误
     */
	private function check()
	{
		if curl_errno(this->_handler) {
			throw new Error(curl_error(this->_handler), Error::ERROR_HTTP_FETCH);
		}
	}
}