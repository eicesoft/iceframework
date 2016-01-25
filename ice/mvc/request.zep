namespace Ice\Mvc;

/**
 * URL 请求类
 * @author kelezyb
 */
class Request
{
    /**
      *
      * @var bool
      */
	private static instance = null;

    /**
     *
     * @var string
     */
	private verb;

    /**
     *
     * @var string
     */
	private uri;

    /**
     *
     * @var bool
     */
	private is_ajax;

	private function __construct()
	{
		let this->verb = _SERVER["REQUEST_METHOD"];
		let this->uri = _SERVER["REQUEST_URI"];
		var pos = strpos(this->uri, "?");
		if pos {
			let this->uri = substr(this->uri, 0, pos);
		}

		let this->is_ajax = (isset(_SERVER["HTTP_X_REQUESTED_WITH"]) && _SERVER["HTTP_X_REQUESTED_WITH"] === "XMLHttpRequest");
	}

    /**
     * 获得URI地址
     * @return string
     */
	public function getUri() -> string
	{
		return this->uri;
	}

    /**
     * 请求的方法类型
     * @return string
     */
	public function getVerb() -> string
	{
		return this->verb;
	}

    /**
     * 是否AJAX请求页面
     * @return bool
     */
	public function isAjax() -> bool
	{
		return this->is_ajax;
	}

    /**
     * 获得单例实例
     * @return Request
     */
	public static function Instance() -> <Request>
	{
		if (null == self::instance) {
			let self::instance = new Request();
		}

		return self::instance;
	}
}