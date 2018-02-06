namespace Ice\Mvc;

/**
 * Session支持类
 * @author kelezyb
 */
class Session implements \ArrayAccess
{
	/**
	 * 当前实例
	 */
	private static instance = null;

    /**
     * 构造函数
     */
	private function __construct()
	{
		if session_status() == PHP_SESSION_NONE {
			session_start();
		}
	}

    /**
     * 是否存在Session
     * @param string offset
     */
	public function offsetExists(offset)
	{
		return isset _SESSION[offset];
	}

    /**
     * 获取Session值
     * @param string offset
     * @return mixed
     */
	public function offsetGet(offset)
	{
		return isset _SESSION[offset] ? _SESSION[offset] : null;
	}

    /**
     * 设置Session值
     * @param string offset
     * @param mixed value
     */
	public function offsetSet(offset, value)
	{
		let _SESSION[offset] = value;
	}

    /**
     * 删除Session
     * @param string offset
     */
	public function offsetUnset(offset)
	{
		unset _SESSION[offset];
	}

	/**
	 * 获得Session实例
	 * @return Session
	 */
	public static function Instance() -> <Session>
	{
		if null == self::instance {
			let self::instance = new Session();
		}

		return self::instance;
	}
}