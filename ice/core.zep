namespace Ice;

use Ice\Log\Logger;

final class Core
{
	const VERSION = "0.9.0.1";

	private static instance = null;

	protected app_config;

	private dispatcher;

	public function setAppConfig(array appconfig)
	{
		let this->app_config = appconfig;
	}

	public function getAppConfig() -> array
	{
		return this->app_config;
	}

	public function get(string key, def = null)
	{
		if isset this->app_config[key] {
			return this->app_config[key];
		} else {
			return def;
		}
	}

	public function __construct(array config)
	{
		let this->app_config = config;
		this->register();
	}

	public function run()
	{
		Loader::Instance()->register();
		let this->dispatcher = Mvc\Dispatcher::Instance();
		var response = this->dispatcher->execute();

		if response {
			echo response->getContent();
		}
	}

	public function register()
	{
        set_error_handler([this, "error_handler"],  E_ALL);
        set_exception_handler([this, "exception_handler"]);
	}

	public function error_handler(int errno, string errstr, string errfile, string errline)
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

    public function getAppPath() -> string
    {
        return "%s/%s"->format(this->app_config["base"], this->app_config["app"]);
    }

	public static function Instance(array config = null) -> <Core>
	{
		if null == self::instance {
			let self::instance = new Core(config);
		}

		return self::instance;
	}

	public function version() -> string
	{
		return Core::VERSION;
	}
}