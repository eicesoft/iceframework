namespace Ice\Log;

use Ice\Config;

//日志类
class Logger
{
	const LEVEL_DEBUG = 0;
	const LEVEL_INFO = 1;
	const LEVEL_WARN = 2;
	const LEVEL_ERROR = 3;
	const LEVEL_ALERT = 4;

	/**
	 * 当前实例
	 */
	private static instance = null;

	/**
	 * Channel
	 *
	 * @var object
	 */
	protected _channels;

	private _level = Logger::LEVEL_DEBUG;

	private function __construct()
	{
		let this->_channels = [];

		var config = Config::Instance()->get(null, "log");
		this->setLevelType(config["level"]);
		var handler;
		var className;
		for handler in config["handlers"] {
			let className = "\Ice\Log\Channel\%s"->format(handler["type"]);
			this->addChannel(new {className});
		}
	}

	public function addChannel(channel)
	{
		let this->_channels[] = channel;
	}

	public function setLevelType(int level)
	{
		let this->_level = level;
	}

	private function log(int type, var message = null, array! context = null)
	{
		if type >= this->_level {
			var channel;
			for channel in this->_channels {
				channel->log(type, message, context);
			}
		}
	}

	public function debug(var message = null, array! context = null)
	{
		this->log(self::LEVEL_DEBUG, message, context);
	}

	public function info(var message = null, array! context = null)
	{
		this->log(self::LEVEL_INFO, message, context);
	}

	public function warn(var message = null, array! context = null)
	{
		this->log(self::LEVEL_WARN, message, context);
	}

	public function error(var message = null, array! context = null)
	{
		this->log(self::LEVEL_ERROR, message, context);
	}

	public function alert(var message = null, array! context = null)
	{
		this->log(self::LEVEL_ALERT, message, context);
	}

	/**
	 * 获得logger实例
	 * @return <Logger>
	 */
	public static function Instance() -> <Logger>
	{
		if null == self::instance {
			let self::instance = new Logger();
		}

		return self::instance;
	}
}