namespace Ice;

use Ice\Log\Logger;

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
		this->error_register();
	}

    /**
     * App运行
     */
	public function run()
	{
		Loader::Instance()->register();
		let this->dispatcher = Mvc\Dispatcher::Instance();
		var response = this->dispatcher->execute();

		if response {
			echo response->getContent();
		}
	}

    /**
     * 错误处理handler注册
     */
	public function error_register()
	{
        set_error_handler([this, "error_handler"],  E_ALL);
        set_exception_handler([this, "exception_handler"]);
	}

    /**
     * 错误处理
     * @param int errno
     * @param string errorstr
     * @param string errfile
     * @param string errline
     */
	public function error_handler(int errno, string errstr, string errfile, string errline, array! errcontext)
	{
        Logger::Instance()->error(sprintf("{ERR}%s(%d)-[%s:%d]", errstr, errno, errfile, errline));
    }

    /**
     * 异常处理
     * @param \Exception $exception
     */
    public function exception_handler(exception)
    {
        Logger::Instance()->error(sprintf("{EXCEPTION}%s(%d)-[%s:%d]",
            exception->getMessage(),
            exception->getCode(),
            exception->getFile(),
            exception->getLine()));
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