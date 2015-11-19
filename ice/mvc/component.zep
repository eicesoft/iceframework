namespace Ice\Mvc;

use Ice\Log\Logger;
use Ice\Mvc\Proxy\ModelProxy;

//控制器类
class Component
{
	protected log;

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
	}
}