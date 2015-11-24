namespace Ice\Mvc;

/**
 * 路由信息
 * @author kelezyb
 */
class Route
{
    /**
     * 控制器
     * @var string
     */
	private controller;

    /**
     * 方法
     * @var string
     */
	private method;

    /**
     * 构造函数
     * @param string controllermethod
     */
	public function __construct(string controllermethod)
    {
    	var info = explode("@", controllermethod);

    	let this->controller = info[0];
    	let this->method = info[1];
    }

    /**
     * 获得控制器名称
     * @return string
     */
    public function getController() -> string
    {
    	return this->controller;
    }

    /**
     * 获得方法名称
     * @return string
     */
    public function getMethod() -> string
    {
    	return this->method;
    }
}