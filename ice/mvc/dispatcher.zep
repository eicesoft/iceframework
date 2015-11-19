namespace Ice\Mvc;

use Ice\Core;

//派发控制器
class Dispatcher
{
	private static instance = null;

	//路由表处理
	private router;

	public function __construct()
	{
		let this->router = Router::Instance();
	}

	public function execute()
	{
		var route = this->router->match();
		return this->_call(route);
	}

	private function _call(route)
	{
		var namespaces = Core::Instance()->get("namespaces");
		var className = "%s\%s"->format(namespaces["controller"], route->getController());

		var controllerObj = this->newInstance(className);
		var method;

		let method = route->getMethod();
		return controllerObj->{method}();
	}

	private function newInstance(className)
	{
		var instance;
		let instance = new {className};

		return instance;
	}

	public static function Instance() -> <Dispatcher>
	{
		if (null == self::instance) {
			let self::instance = new Dispatcher();
		}

		return self::instance;
	}
}