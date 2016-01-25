namespace Ice\Log\Formatter;

use Ice\Log\Formatter;

/**
 * 行数据格式化
 * @author kelezyb
 */
class LineFormatter extends Formatter
{
	const FORMAT_STR = "[%s] %s | %s\n";

    /**
     * 格式化数据
     * @param int type
     * @param mixed message
     * @param array context
     */
	public function format(int type, var message = null, array! context = null)
	{
		var date;
		var stype;
		let stype = this->getTypeString(type);
		let date = date("Y-m-d H:i:s");

		var msg = LineFormatter::FORMAT_STR->format(stype, message, date);

		return vsprintf(msg, context);
	}
}