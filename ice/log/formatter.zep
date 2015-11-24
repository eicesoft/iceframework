namespace Ice\Log;

/**
 * 格式化类
 * @author kelezyb
 */
abstract class Formatter
{
    /**
     * 获得日志类型字符串
     * @param int type
     * @return string
     */
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

    /**
     * 格式化数据
     * @param int type
     * @param mixed message
     * @param array context
     */
	abstract public function format(int type, var message = null, array! context = null) -> string;
}