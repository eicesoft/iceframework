namespace Ice\Mvc\Proxy;

use Ice\Core;
use Ice\Error;

//组件代理类
class ComponentProxy
{
	private _componentName;

    private _instance;

	public function __construct(string name)
	{
		let this->_componentName = name;
	}

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