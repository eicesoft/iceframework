namespace Ice\Data\Cache\Adapter;

use Ice\Data\Cache\ICache;

class RedisCache extends ICache
{
	private _handler;

	public function connect(array config)
	{
		let this->_handler = new \Redis();
		this->_handler->connect(config["host"], config["port"]);
		this->_handler->setOption(\Redis::OPT_SERIALIZER, \Redis::SERIALIZER_PHP);
	}

	public function get(string key)
	{
		return this->_handler->get(key);
	}

	public function set(string key, data, int expire)
	{
		return this->_handler->set(key, data, expire);
	}

	public function delete(string key)
	{
		return this->_handler->delete(key);
	}
}