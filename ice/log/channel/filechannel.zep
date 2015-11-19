namespace Ice\Log\Channel;

use Ice\Core;
use Ice\Log\Channel;
use Ice\Log\Formatter\LineFormatter;

class FileChannel extends Channel
{
	/**
	 *
	 * @var resource
	 */
	private _handler = null;

	private _formatter = null;

	public function __construct()
	{
		var app_config = Core::Instance()->getAppConfig();
		var appLogPath = "%s%s/%s.log"->format(app_config["base"], "/app/logs", date("Y-m-d"));
		let this->_handler = fopen(appLogPath, "a+");
		let this->_formatter = new LineFormatter();
	}

	public function log(int type, var message = null, array! context = null)
	{
		var message;
		let message = this->_formatter->format(type, message, context);

		fwrite(this->_handler, message);
	}

	public function __destruct()
	{
		fclose(this->_handler);
	}
}
