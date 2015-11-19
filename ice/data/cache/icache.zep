namespace Ice\Data\Cache;

interface ICache
{

	public function connect(array config);

	/**
	 * cache get data
	 * @param string key
	 * @return var
	 */
	public function get(string key);

	public function set(string key, data, int expire);

	/**
	 * cache delete key
	 * @param string key
	 * @return mixed
	 */
	public function delete(string key);
}