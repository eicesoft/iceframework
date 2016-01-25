namespace Ice\Mvc;

use Ice\Mvc\Proxy\ComponentProxy;

/**
 * 控制器类
 * @author kelezyb
 */
class Controller
{
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
			let proxy = new ComponentProxy(propertie->getName());
			propertie->setAccessible(true);
			propertie->setValue(this, proxy);
		}
	}

    /**
     * 获得GET参数
     * @param string key
     * @param mixed def
     * @return mixed
     */
	public function get(string key, def=null)
	{
	    return isset _GET[key] ? _GET[key] : def;
	}

    /**
     * 获得POST参数
     * @param string key
     * @param mixed def
     * @return mixed
     */
	public function post(string key, def=null)
    {
        return isset _POST[key] ? _POST[key] : def;
    }

    /**
     * 获得REQUEST参数
     * @param string key
     * @param mixed def
     * @return mixed
     */
    public function request(string key, def=null)
    {
        return isset _REQUEST[key] ? _REQUEST[key] : def;
    }

    /**
     * 构造模板响应
     * @param string templet
     * @param array data
     * @return Response
     */
	public function buildTemplet(string templet, array data)
	{
		return new TempletResponse(templet, data);
	}

    /**
     * 构造JSON响应
     * @param array data
     * @return Response
     */
	public function buildJson(array data)
	{
		return new JsonResponse(data);
	}

    /**
     * 构造Redirect 响应
     * @param string url
     * @return Response
     */
	public function buildRedirect(string url)
	{
		return new RedirectResponse(url);
	}

	/**
     * 构造安全数据响应
     * @param string url
     * @return Response
     */
    public function buildSecretData(array data)
    {
        return new SecretResponse(data);
    }
}