namespace Ice\Mvc\Proxy;

use Ice\Core;
use Ice\Error;

//模型代理类
class ModelProxy
{
	private modelName;

	public function __construct(string name)
	{
		let this->modelName = name;
	}

	public function __call(string name, array arguments)
	{
		var namespaces = Core::Instance()->get("namespaces");
		var className = "%s\%s"->format(namespaces["models"], this->modelName);

		var instance;
		let instance = new {className};

		if method_exists(instance, name) {
			return call_user_func_array([instance, name], arguments);
		} else {
			throw new Error("No found modelName [" . this->modelName . "] is method " . name . ".", Error::ERROR_NO_MODEL_METHOD);
		}
	}
}