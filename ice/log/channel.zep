namespace Ice\Log;

abstract class Channel
{
	/**
	 * Formatter
	 *
	 * @var object
	 */
	protected _formatter;

	abstract public function log(int type, var message = null, array! context = null);
}