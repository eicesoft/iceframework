namespace Ice;

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