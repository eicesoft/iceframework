namespace Ice\Mvc;

//Session支持类
class Session implements \ArrayAccess
{
	/**
	 * 当前实例
	 */
	private static instance = null;

	private function __construct()
	{
		if session_status() == PHP_SESSION_NONE {
			session_start();
		}
	}

	public function offsetExists(offset)
	{
		return isset _SESSION[offset];
	}

	public function offsetGet(offset)
	{
		return isset _SESSION[offset] ? _SESSION[offset] : null;
	}

	public function offsetSet(offset, value)
	{
		let _SESSION[offset] = value;
	}

	public function offsetUnset($offset)
	{
		unset _SESSION[offset];
	}

	/**
	 * 获得Session实例
	 * @return <Session>
	 */
	public static function Instance() -> <Session>
	{
		if null == self::instance {
			let self::instance = new Session();
		}

		return self::instance;
	}
}