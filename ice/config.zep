namespace Ice;

//配置读取
final class Config
{
	private static instance = null;

	private appConfigPath;

	private modules;

	private function __construct()
	{
		var app_config = Core::Instance()->getAppConfig();
		let this->appConfigPath = "%s%s"->format(app_config["base"], "/app/configs");
		let this->modules = [];
	}

	//获得配置值
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

	//获得配置实例
	public static function Instance() -> <Config>
	{
		if null == self::instance {
			let self::instance = new Config();
		}

		return self::instance;
	}
}