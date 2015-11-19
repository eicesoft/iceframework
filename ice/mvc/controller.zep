namespace Ice\Mvc;

use Ice\Mvc\Proxy\ComponentProxy;

//控制器类
class Controller
{
	public function __construct()
	{
		var refobj;
		var propertie;
		let refobj = new \ReflectionClass(this);
		var properties = refobj->getProperties(\ReflectionProperty::IS_PRIVATE);
		var proxy;
		for propertie in properties {
			let proxy = new ComponentProxy(propertie->getName());
			propertie->setAccessible(true);
			propertie->setValue(this, proxy);
		}
	}

	public function buildTemplet(string templet, array data)
	{
		return new TempletResponse(templet, data);
	}

	public function buildJson(array data)
	{
		return new JsonResponse(data);
	}

	public function buildRedirect(string url)
	{
		return new RedirectResponse(url);
	}
}