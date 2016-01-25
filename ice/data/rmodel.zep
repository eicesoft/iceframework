namespace Ice\Data;

use Ice\Data\Cache\Cache;

/**
 * 数据模块
 * @package Ice\Data
 * @author kelezyb
 */
class RModel
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
     *
     * @var mixed
     */
    protected _propertys = null;

    /**
     * 构造函数
     */
    public function __construct()
    {
        let this->_cache = Cache::Instance();
        let this->_propertys = [];
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
        return "HRM:%s:%s"->format(this->_main_key, this->_main_id);
    }

    public function set(string field, var data)
    {
        let this->_propertys[field] = data;
    }

    public function get(string field)
    {
        if !this->_propertys {
            this->find();
        }

        return this->_propertys[field];
    }

    public function __set(name, value)
    {
        this->set(name, value);
    }

    public function __get(name)
    {
        return this->get(name);
    }

    public function __unset(name)
    {
        unset this->_propertys[name];
    }

    public function find()
    {
        var key = this->getKey();
        let this->_propertys = this->_cache->hGetall(key);

        return this->_propertys;
    }

    public function save()
    {
        var key = this->getKey();
        var_dump(key);
        var_dump(this->_propertys);
        this->_cache->HMset(key, this->_propertys);
        this->_cache->Hset(key, "a1","a2");
    }

    public function remove()
    {
        var key = this->getKey();
        this->_cache->delete(key);
    }

    public function toArray()
    {
        return this->_propertys;
    }
}