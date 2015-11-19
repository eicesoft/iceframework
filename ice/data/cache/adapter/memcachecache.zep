namespace Ice\Data\Cache\Adapter;

use Ice\Data\Cache\ICache;

class MemcacheCache extends ICache
{
	private _handler;

	public function connect(array config)
	{
		let this->_handler = new \Memcache();
		this->_handler->addserver(config["host"], config["port"]);
	}

	public function get(string key)
	{
		return this->_handler->get(key);
	}

	public function set(string key, data, int expire)
	{
		return this->_handler->set(key, data, 2, expire);
	}

	public function delete(string key)
	{
		return this->_handler->delete(key);
	}
}