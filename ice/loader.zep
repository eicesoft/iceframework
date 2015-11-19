namespace Ice;

/**
 * 加载器
 */
final class Loader
{
	private static instance = null;

	protected _registered = false;
	private _classses = null;

	public function __construct()
	{
		let this->_classses = [];
	}

	public function register() {
		if this->_registered === false {
			spl_autoload_register([this, "autoLoad"]);
			let this->_registered = true;
		}
	}

	/**
	 * 自动加载接口
	 */
	public function autoLoad(string! className) -> boolean
	{
		let className = str_replace("\\", "/", className->lowerfirst());

		if !isset this->_classses[className] {
			var app_config = Core::Instance()->getAppConfig();
			var appPath = "%s/%s"->format(app_config["base"], app_config["app"]);
			var classFile = "%s/%s.php"->format(appPath, className);

			if file_exists(classFile) {
				require classFile;
			} else {
				throw new Error("Class[" . className . "] file no found!", Error::ERROR_NO_CLASS);
			}
		}

		return true;
	}

	public static function Instance() -> <Loader>
	{
		if (null == self::instance) {
			let self::instance = new Loader();
		}

		return self::instance;
	}
}