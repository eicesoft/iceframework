namespace Ice\Mvc\Proxy;

use Ice\Core;
use Ice\Error;

//组件代理类
class ComponentProxy
{
	private componentName;

	public function __construct(string name)
	{
		let this->componentName = name;
	}

	public function __call(string name, array arguments)
	{
		var namespaces = Core::Instance()->get("namespaces");
		var className = "%s\%s"->format(namespaces["component"], this->componentName);

		var instance;
		let instance = new {className};

		if method_exists(instance, name) {
			return call_user_func_array([instance, name], arguments);
		} else {
			throw new Error("No found component [" . this->componentName . "] is method " . name . ".", Error::ERROR_NO_COMPONENT_METHOD);
		}
	}
}