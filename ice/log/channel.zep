namespace Ice\Log;

/**
 * 日志通道抽象类
 * @author kelezyb
 */
abstract class Channel
{
	/**
	 * Formatter
	 *
	 * @var object
	 */
	protected _formatter;

    /**
     * 记录日志数据
     * @param int type
     * @param mixed msg
     * @param array context
     */
	abstract public function log(int type, var msg = null, array! context = null);
}