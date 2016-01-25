namespace Ice\Data;

use Ice\Data\Cache\Cache;

class ListModel
{
    /**
     * 主Model Key前缀
     * @var string
     */
    protected _main_key;

    /**
     * 数据项主键
     * @var string
     */
    protected _main_id;

    /**
     * cache组件
     * @var Cache
     */
    protected _cache;

    /**
     * 构造函数
     */
    public function __construct()
    {
        let this->_cache = Cache::Instance();
    }

    /**
     * 获得主键ID
     * @param string id
     */
    public function setId(id)
    {
        let this->_main_id = id;
    }

    /**
     * 获得主键ID
     * @return string
     */
    public function getId() -> string
    {
        return this->_main_id;
    }

    /**
     * 获得主Key
     * @return string
     */
    protected function getKey() -> string
    {
        return "HM:%s:%s"->format(this->_main_key, this->_main_id);
    }

    /**
     * 设置数据项
     * @param mixed id
     * @param bar data
     */
    public function set(var id, var data)
    {
        var key = this->getKey();

        this->_cache->hSet(key, id, data);
    }

    /**
     * 批量设置数据
     * @param mixed datas
     */
    public function sets(var datas)
    {
        var key = this->getKey();

        this->_cache->HMset(key, datas);
    }

    /**
     * 删除数据项
     * @param mixed id
     * @return int
     */
    public function delete(var id) -> int
    {
        var key = this->getKey();

        return this->_cache->hDel(key, id);
    }

    /**
     * 获得数据项
     * @param mixed id
     * @return array
     */
    public function get(var id) -> array
    {
        var key = this->getKey();

        return this->_cache->hGet(key, id);
    }

    /**
     * 获得数据项列表
     * @param array ids
     * @return array
     */
    public function gets(array ids) -> array
    {
        var key = this->getKey();

        return this->_cache->hmGet(key, ids);
    }

    /**
     * 获得数据项列表
     * @return array
     */
    public function all() -> array
    {
        var key = this->getKey();

        return this->_cache->hGetAll(key);
    }

    /**
     * 删除数据
     * @return int
     */
    public function remove() -> int
    {
        var key = this->getKey();

        return this->_cache->delete(key);
    }

    /**
     * 判断数据项是否存在
     * @param mixed id
     * @return bool
     */
    public function exist(var id) -> bool
    {
        var key = this->getKey();

        return this->_cache->hExists(key, id);
    }

    /**
     * 获得数据列表长度
     * @return int
     */
    public function count() -> int
    {
        var key = this->getKey();

        return this->_cache->hLen(key);
    }

    /**
     * 获得数据项键名列表
     * @return array
     */
    public function ids() -> array
    {
        var key = this->getKey();

        return this->_cache->hKeys(key);
    }
}