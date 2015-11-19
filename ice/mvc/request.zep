namespace Ice\Mvc;

//URL 请求类
class Request
{
	private static instance = null;

	private verb;

	private uri;

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

	public function getUri() -> string
	{
		return this->uri;
	}

	public function getVerb() -> string
	{
		return this->verb;
	}

	public function isAjax() -> bool
	{
		return this->is_ajax;
	}

	public static function Instance() -> <Request>
	{
		if (null == self::instance) {
			let self::instance = new Request();
		}

		return self::instance;
	}
}