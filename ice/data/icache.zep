namespace Ice\Data;

interface ICache
{
    /**
     * 连接数据库
     * @param array config
     */
	public function connect(array config);

	/**
	 * 获得数据
	 * @param string key
	 * @return mixed
	 */
	public function get(string key);

	/**
	 * 设置数据
	 * @param string key
	 * @param var data
	 * @param int expire
	 */
	public function set(string key, var data, int expire) -> int;

	/**
	 * 删除数据
	 * @param string key
	 */
	public function delete(string key) -> int;
}