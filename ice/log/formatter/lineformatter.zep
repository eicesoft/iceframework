namespace Ice\Log\Formatter;

use Ice\Log\Formatter;

/**
 *
 */
class LineFormatter extends Formatter
{
	const FORMAT_STR = "[%s] %s | %s\n";


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