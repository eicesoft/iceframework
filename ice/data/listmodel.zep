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

    protected _cache;

    /**
     * 构造函数
     * @param string $main_id
     */
    public function __construct()
    {
        let this->_cache = Cache::Instance();
    }

    public function setId(id)
    {
        let this->_main_id = id;
    }

    public function getId()
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
     * @param var id
     * @param bar data
     */
    public function set(var id, var data)
    {
        var key = this->getKey();

        this->_cache->hSet(key, id, data);
    }

    /**
     * 批量设置数据
     * @param var datas
     */
    public function sets(var datas)
    {
        var key = this->getKey();

        this->_cache->HMset(key, datas);
    }

    /**
     * 删除数据项
     * @param var id
     */
    public function delete(var id)
    {
        var key = this->getKey();

        this->_cache->hDel(key, id);
    }

    public function get(id)
    {
        var key = this->getKey();

        return this->_cache->hGet(key, id);
    }

    public function gets(array ids)
    {
        var key = this->getKey();

        return this->_cache->hmGet(key, ids);
    }

    public function all()
    {
        var key = this->getKey();

        return this->_cache->hGetAll(key);
    }

    public function remove()
    {
        var key = this->getKey();

        return this->_cache->delete(key);
    }

    public function exist(var id) -> bool
    {
        var key = this->getKey();

        return this->_cache->hExists(key, id);
    }

    public function count() -> int
    {
        var key = this->getKey();

        return this->_cache->hLen(key);
    }

    public function ids() -> array
    {
        var key = this->getKey();

        return this->_cache->hKeys(key);
    }
}