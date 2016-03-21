namespace Ice\Mvc;

use Ice\Log\Logger;
use Ice\Config;
use Ice\Mvc\Proxy\ModelProxy;
use Ice\Mvc\Proxy\ComponentProxy;

/**
 * 业务组件类
 * @author kelezyb
 */
class Component
{
    /**
     * 日志扩展
     * @var Logger
     */
	protected log;

	/**
	 * 配置读取
	 * @var Config
	 */
	protected config;

    /**
     * 构造函数
     */
	public function __construct()
	{
		var refobj;
		var propertie;
		let refobj = new \ReflectionClass(this);
		var properties = refobj->getProperties(\ReflectionProperty::IS_PRIVATE);
		var proxy;
		for propertie in properties {
			let proxy = new ModelProxy(propertie->getName());
			propertie->setAccessible(true);
			propertie->setValue(this, proxy);
		}

		let this->log = Logger::Instance();
		let this->config = Config::Instance();
	}

	/**
	 *
	 * @param string name
	 * @return Component
	 */
	public function getComponent(string name)
	{
		return new ComponentProxy(name);
	}
}