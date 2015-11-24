namespace Ice\Mvc\Proxy;

use Ice\Core;
use Ice\Error;

/**
 * 模型代理类
 * @author kelezyb
 */
class ModelProxy
{
    /**
     * 模型名称
     * @var string
     */
	private _modelName;

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
		let this->_modelName = name;
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
            var className = "%s\%s"->format(namespaces["models"], this->_modelName);

            let this->_instance = new {className};
		}

		if method_exists(this->_instance, name) {
            return call_user_func_array([this->_instance, name], arguments);
        } else {
            throw new Error("No found modelName [" . this->_modelName . "] is method " . name . ".",
                Error::ERROR_NO_MODEL_METHOD);
        }
	}
}