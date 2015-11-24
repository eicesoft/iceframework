namespace Ice;

/**
 * 框架加载器
 * @author kelezyb
 */
final class Loader
{
    /**
     * @var Loader
     */
	private static instance = null;

    /**
     * @var bool
     */
	protected _registered = false;

	/**
	 * @var array
	 */
	private _classses = null;

    /**
     * 构造函数
     */
	public function __construct()
	{
		let this->_classses = [];
	}

    /**
     * 加载器注册
     */
	public function register() {
		if this->_registered === false {
			spl_autoload_register([this, "autoLoad"]);
			let this->_registered = true;
		}
	}

	/**
	 * 自动加载接口
	 * @param string className
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

    /**
     * 获得实例
     * @return Loader
     */
	public static function Instance() -> <Loader>
	{
		if (null == self::instance) {
			let self::instance = new Loader();
		}

		return self::instance;
	}
}