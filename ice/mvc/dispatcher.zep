namespace Ice\Mvc;

use Ice\Core;

/**
 * 派发控制器
 * @author kelezyb
 */
class Dispatcher
{
    /**
     * 静态实例
     * @var Dispatcher
     */
	private static instance = null;

	/**
	 * 路由表处理
	 * @var Router
	 */
	private router;

    /**
     * 构造函数
     */
	public function __construct()
	{

	}

    /**
     * 派发器执行
     * @return Response
     */
	public function execute()
	{
	    let this->router = Router::Instance();
		var route = this->router->match();
		return this->_call(route);
	}

	public function shell()
	{
	    var argv;
	    var param;
	    if fetch argv, _SERVER["argv"] {
	        if count(argv) > 1 {
	            var namespaces = Core::Instance()->get("namespaces");
	            var instance;
                let param = array_slice(argv, 2);
                var className = "%s\%s"->format(namespaces["shells"], argv[1]);
                let instance = this->newInstance(className);
                call_user_func_array([instance, "execute"], param);
            }
	    }
	}

    /**
     * 调用控制器方法
     * @param Route route
     */
	private function _call(<Route> route)
	{
		var namespaces = Core::Instance()->get("namespaces");
		var className = "%s\%s"->format(namespaces["controller"], route->getController());

		var controllerObj = this->newInstance(className);
		var method;

		let method = route->getMethod();
		return controllerObj->{method}();
	}

    /**
     * 生成控制器对象实例
     * @param string className
     * @return Controller
     */
	private function newInstance(string className)
	{
		var instance;
		let instance = new {className};

		return instance;
	}

    /**
     * 获得单例实例
     * @return Dispatcher
     */
	public static function Instance() -> <Dispatcher>
	{
		if (null == self::instance) {
			let self::instance = new Dispatcher();
		}

		return self::instance;
	}
}