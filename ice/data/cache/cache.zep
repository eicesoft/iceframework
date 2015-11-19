namespace Ice\Data\Cache;

use Ice\Config;
use Ice\Error;
use Ice\Data\Cache\Adapter\MemcacheCache;
use Ice\Data\Cache\Adapter\RedisCache;

/**
 * 缓存处理类
 * @author kelezyb
 */
class Cache
{
	/**
	 * 默认连接名称
	 */
	const DEFAULT_NAME = "default";

	/**
	 * 当前实例
	 */
	private static instance = null;

	/**
	 * @var array 缓存的配置
	 */
	protected _configs;

	/**
	 * @var string 当前连接名称
	 */
	private _connect;

	/**
	 * @var array 缓存连接
	 */
	private _handlers = [];

	private function __construct()
	{
		let this->_configs = Config::Instance()->get(null, "cache");
		this->setConnection(Cache::DEFAULT_NAME);
	}

	/**
	 * 设置当前连接名
	 * @param string name
	 */
	public function setConnection(string name)
	{
		let this->_connect = name;

		if !isset this->_handlers[name] {
			this->init(name);
		}
	}

	/**
	 * 初始化连接
	 * @param string name
	 */
	public function init(string name) -> void
	{
		if isset this->_configs[name] {
			var config = this->_configs[name];
			var handler;
			switch config["type"] {
				case "memcache":
					let handler = new MemcacheCache();
					break;
				case "redis":
					let handler = new RedisCache();
					break;
			}
			handler->connect(config["connect"]);

			let this->_handlers[name] = handler;
		} else {
			throw new Error("Cache config not found.", Error::ERROR_NO_FOUND_CACHE_CONFIG);
		}
	}

	/**
	 * 获得Key前缀
	 */
	private function getPrefixKey(string key) -> string
	{
		return "%s%s"->format(this->_configs[this->_connect]["connect"]["prefix"], key);
	}

	/**
	 * 获得缓存内容
	 */
	public function get(string key)
	{
		let key = this->getPrefixKey(key);
		return this->_handlers[this->_connect]->get(key);
	}

	/**
	 * 设置缓存内容
	 */
	public function set(string key, var data, int expire=0)
	{
		let key = this->getPrefixKey(key);
		return this->_handlers[this->_connect]->set(key, data, expire);
	}

	/**
	 * 删除缓存内容
	 */
	public function delete(string key)
	{
		let key = this->getPrefixKey(key);
		return this->_handlers[this->_connect]->delete(key);
	}

	/**
	 * 指定匿名函数进行Key设置
	 */
	public function remeber(string key, int expire, func)
	{
		var data;
		let data = this->get(key);

		if !data {
			let data = {func}(key);

			this->set(key, data, expire);
		}

		return data;
	}

	/**
	 * 获得Cache实例
	 * @return <Cache>
	 */
	public static function Instance() -> <Cache>
	{
		if null == self::instance {
			let self::instance = new Cache();
		}

		return self::instance;
	}
}