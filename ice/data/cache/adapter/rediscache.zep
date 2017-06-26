namespace Ice\Data\Cache\Adapter;

use Ice\Data\ICache;

class RedisCache implements ICache
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

	public function set(string key, var data, int expire)
	{
		if expire == 0 {
			return this->_handler->set(key, data);
		} else {
			return this->_handler->setEx(key, expire, data);
		}
	}

	public function delete(string key) -> int
	{
		return this->_handler->del(key);
	}

    public function __call(string name, array arguments)
    {
        return call_user_func_array([this->_handler, name], arguments);
    }
}