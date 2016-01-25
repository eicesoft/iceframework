namespace Ice\Mvc\Proxy;

use Ice\Core;
use Ice\Error;

/**
 * 组件代理类
 * @author kelezyb
 */
class ComponentProxy
{
    /**
     * 组件名称
     * @var string
     */
	private _componentName;

    /**
     * 组件实例对象
     * @var mixed
     */
    private _instance;

    /**
     * 构造函数
     * @param string name
     */
	public function __construct(string name)
	{
		let this->_componentName = name;
	}

    /**
     * 方法动态调用
     * @param string name
     * @param array arguments
     * @return mixed
     */
	public function __call(string name, array arguments)
	{
        if !this->_instance {
            var namespaces = Core::Instance()->get("namespaces");
            var className = "%s\%s"->format(namespaces["component"], this->_componentName);

            let this->_instance = new {className};
		}

		if method_exists(this->_instance, name) {
			return call_user_func_array([this->_instance, name], arguments);
		} else {
			throw new Error("No found component [" . this->_componentName . "] is method " . name . ".",
			    Error::ERROR_NO_COMPONENT_METHOD);
		}
	}
}