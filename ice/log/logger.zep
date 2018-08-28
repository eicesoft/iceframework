namespace Ice\Log;

use Ice\Config;

//日志类
final class Logger
{
	const LEVEL_DEBUG = 0;
	const LEVEL_INFO = 1;
	const LEVEL_WARN = 2;
	const LEVEL_ERROR = 3;
	const LEVEL_ALERT = 4;

	/**
	 * 当前实例
	 * @var Logger
	 */
	private static instance = null;

	/**
	 * Channel
	 *
	 * @var array
	 */
	protected _channels;

    /**
     * 当前记录日志级别
     * @var int
     */
	private _level = Logger::LEVEL_DEBUG;

    /**
     * 构造函数
     */
	private function __construct()
	{
		let this->_channels = [];

		// var config = Config::Instance()->get(null, "log");
		// var handler;
		// var className;
		// for handler in config["handlers"] {
		// 	let className = "\Ice\Log\Channel\%s"->format(handler["type"]);
		// 	this->addChannel(new {className});
		// }

		// this->setLevelType(config["level"]);
	}

    /**
     * 添加日志通道
     * param Channel channel
     */
	public function addChannel(channel)
	{
		let this->_channels[] = channel;
	}

    /**
     * 设置日志等级
     * @param int level
     */
	public function setLevelType(int level)
	{
		let this->_level = level;
	}

    /**
     * 记录日志数据
     * @param int type
     * @param mixed message
     * @param array context
     */
	private function log(int type, var message = null, array! context = null)
	{
		// if type >= this->_level {
		// 	var channel;
		// 	for channel in this->_channels {
		// 	    if channel instanceof Channel {
		// 		    channel->log(type, message, context);
		// 		}
		// 	}
		// }
	}

    /**
     * 记录调试日志数据
     * @param mixed message
     * @param array context
     */
	public function debug(var message = null, array! context = null)
	{
		this->log(self::LEVEL_DEBUG, message, context);
	}

    /**
     * 记录信息日志数据
     * @param mixed message
     * @param array context
     */
	public function info(var message = null, array! context = null)
	{
		this->log(self::LEVEL_INFO, message, context);
	}

    /**
     * 记录警告日志数据
     * @param mixed message
     * @param array context
     */
	public function warn(var message = null, array! context = null)
	{
		this->log(self::LEVEL_WARN, message, context);
	}

    /**
     * 记录错误日志数据
     * @param mixed message
     * @param array context
     */
	public function error(var message = null, array! context = null)
	{
		this->log(self::LEVEL_ERROR, message, context);
	}

    /**
     * 记录警报日志数据
     * @param mixed message
     * @param array context
     */
	public function alert(var message = null, array! context = null)
	{
		this->log(self::LEVEL_ALERT, message, context);
	}

	/**
	 * 获得logger实例
	 * @return Logger
	 */
	public static function Instance() -> <Logger>
	{
		if null == self::instance {
			let self::instance = new Logger();
		}

		return self::instance;
	}
}