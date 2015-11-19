namespace Ice\Log;

abstract class Formatter
{
	protected function getTypeString(int type) -> string
	{
		switch type {
			case Logger::LEVEL_DEBUG:
				return "DEBUG";
			case Logger::LEVEL_INFO:
				return "INFO";
			case Logger::LEVEL_WARN:
				return "WARN";
			case Logger::LEVEL_ERROR:
				return "ERROR";
			case Logger::LEVEL_ALERT:
				return "ALERT";
		}

		return "CUSTOM";
	}

	abstract public function format(int type, var message = null, array! context = null) -> string;
}