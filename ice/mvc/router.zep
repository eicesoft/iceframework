namespace Ice\Mvc;

use Ice\Config;
use Ice\Error;

/**
 * 路由处理类
 * @author kelezyb
 */
class Router
{
	private static instance = null;

	private request;

	private routers;

	public function __construct()
	{
		let this->request = Request::Instance();

		let this->routers = this->_extend_routers(Config::Instance()->get(null, "router"));
	}

	public function match()
	{
		var pattern, controller;

		var matches, match;
		let match = null;
		for pattern, controller in this->routers {
			if preg_match("#^/?" . pattern . "/?$#", this->request->getUri(), match) {
				let matches = array_slice(match, 1);

				return new Route(controller, matches);
			}
		}

		throw new Error("Not found uri: " . this->request->getUri(), Error::ERROR_NO_URI);
	}

	private function _extend_routers(array routers) -> array
	{
		var extend_routers = [];
		var item, value;
		var k, v;
		for item, value in routers {
			if is_array(value) {
				for k, v in value {
					var newkey = "%s%s"->format(item, k);
					let extend_routers[newkey] = v;
				}
			} else {
				let extend_routers[item] = value;
			}
		}

		return extend_routers;
	}

	public static function Instance() -> <Router>
	{
		if (null == self::instance) {
			let self::instance = new Router();
		}

		return self::instance;
	}
}