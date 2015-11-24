namespace Ice\Log\Channel;

use Ice\Core;
use Ice\Log\Channel;
use Ice\Log\Formatter\LineFormatter;

/**
 * 日志文件通道
 * @author kelezyb
 */
class FileChannel extends Channel
{
	/**
	 * 文件句柄
	 * @var resource
	 */
	private _handler = null;

    /**
     * 数据格式化
     * @var LineFormatter
     */
	private _formatter = null;

    /**
     * 构造函数
     */
	public function __construct()
	{
		var app_config = Core::Instance()->getAppConfig();
		var appLogPath = "%s%s/%s.log"->format(app_config["base"], "/app/logs", date("Y-m-d"));
		let this->_handler = fopen(appLogPath, "a+");
		let this->_formatter = new LineFormatter();
	}

    /**
     * 记录日志
     * @param int type
     * @param mixed message
     * @param array context
     */
	public function log(int type, var message = null, array! context = null)
	{
		var message;
		let message = this->_formatter->format(type, message, context);

		fwrite(this->_handler, message);
	}

    /**
     * 析构函数
     */
	public function __destruct()
	{
		fclose(this->_handler);
	}
}