namespace Ice;

/**
 * 配置读取
 * @author kelezyb
 */
final class Config
{
    /**
     * @var Config
     */
	private static instance = null;

    /**
     * @var string
     */
	private appConfigPath;

    /**
     * @var array
     */
	private modules;

    /**
     * 构造函数
     */
	private function __construct()
	{
		let this->appConfigPath = "%s/configs"->format(Core::Instance()->getAppPath());
		let this->modules = [];
	}

	/**
	 * 获得配置值
	 * @param string key
	 * @param string module
	 * @return mixed
	 */
	public function get(string key = null, string module = "app")
	{
		array data;

		if !isset this->modules[module] {
			var file_path;
			let file_path = this->appConfigPath . "/" . $module . ".php";

			if file_exists(file_path) {
				let data = require file_path;

				if (key == null) {
					return data;
				} else {
					return data[key];
				}

				let this->modules[module] = data;
			} else {
				return null;
			}
		} else {
			if key == null {
				return this->modules[module];
			} else {
				return this->modules[module][key];
			}
		}
	}

	/**
	 * 获得配置实例
	 * @return Config
	 */
	public static function Instance() -> <Config>
	{
		if null == self::instance {
			let self::instance = new Config();
		}

		return self::instance;
	}
}