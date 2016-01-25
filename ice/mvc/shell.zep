namespace Ice\Mvc;

use Ice\Mvc\Proxy\ComponentProxy;

/**
 * Shell处理类
 * @author kelezyb
 */
class Shell
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

}
