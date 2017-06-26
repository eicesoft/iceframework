namespace Ice;

use Ice\Log\Logger;
use Ice\Util\Profile;

/**
 * 框架核心类
 * @author kelezyb
 */
final class Core
{
    /**
     * @var string
     */
	const VERSION = "0.9.0.1";

    /**
     * web运行模式
     */
    const WEB_MODE = 0;

    /**
     * shell运行模式
     */
    const SHELL_MODE = 1;

    /**
     * @var Core
     */
	private static instance = null;

    /**
     * @var array
     */
	protected app_config;

    /**
     * @var Dispatcher
     */
	private dispatcher;

    /**
     * 设置App配置
     * @param array appconfig
     */
	public function setAppConfig(array appconfig)
	{
		let this->app_config = appconfig;
	}

    /**
     * 获得App配置
     * @return mixed
     */
	public function getAppConfig() -> array
	{
		return this->app_config;
	}

    /**
     * 获得App配置项
     * @param string key
     * @param mixed def
     * @return mixed
     */
	public function get(string key, def = null)
	{
		if isset this->app_config[key] {
			return this->app_config[key];
		} else {
			return def;
		}
	}

    /**
     * 构造函数
     * @param array config
     */
	public function __construct(array config)
	{
		let this->app_config = config;
		//this->error_register();
		this->init();
	}

	private function init()
	{
	    var debug, timezone, defines;
	    if fetch debug, this->app_config["debug"] {
	        if debug {
	            ini_set("display_errors", 1);
	            error_reporting(E_ALL);
	        } else {
	            ini_set("display_errors", 0);
	            error_reporting(0);
	        }
	    } else {
	        ini_set("display_errors", 0);
            error_reporting(0);
	    }

        if fetch timezone, this->app_config["timezone"] {
            date_default_timezone_set(timezone);
        } else {
            date_default_timezone_set("UTC");
        }

        var d_k;
        if fetch defines, this->app_config["defines"] {
            var k, v;
            for k, v in defines {
                let d_k = "ICE_%s"->format(k);

                if !defined(d_k) {
                    define(d_k, v);
                }
            }
        }

        Loader::Instance()->register();
	}

    /**
     * App运行
     */
	public function run(int mode = Core::WEB_MODE)
	{
        Profile::Instance()->start("page");

	    let this->dispatcher = Mvc\Dispatcher::Instance();
	    switch mode {
	        case Core::WEB_MODE:
                var response = this->dispatcher->execute();

                if response {
                    echo response->getContent();
                }
	            break;
	        case Core::SHELL_MODE:
	            this->dispatcher->shell();
	            break;
	    }
	}

    /**
     * 获得App路径
     * @return string
     */
    public function getAppPath() -> string
    {
        return "%s/%s"->format(this->app_config["base"], this->app_config["app"]);
    }

    /**
     * 获得实例
     * @return Core
     */
	public static function Instance(array config = null) -> <Core>
	{
		if null == self::instance {
			let self::instance = new Core(config);
		}

		return self::instance;
	}

    /**
     * 获得框架版本
     * @return string
     */
	public function version() -> string
	{
		return Core::VERSION;
	}
}