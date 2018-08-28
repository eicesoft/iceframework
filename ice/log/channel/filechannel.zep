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
		var appLogPath = "%s/logs/%s.log"->format(Core::Instance()->getAppPath(), date("Y-m-d"));

		let this->_handler = fopen(appLogPath, "a+");
		let this->_formatter = new LineFormatter();
	}

    /**
     * 记录日志
     * @param int type
     * @param mixed msg
     * @param array context
     */
	public function log(int type, var msg = null, array! context = null)
	{
		var message;
		let message = this->_formatter->format(type, msg, context);

		if this->_handler {
			fwrite(this->_handler, message);
		}
	}

    /**
     * 析构函数
     */
	public function __destruct()
	{
		if(is_resource(this->_handler)) {
			fclose(this->_handler);
		}
	}
}