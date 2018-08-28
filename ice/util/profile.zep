namespace Ice\Util;

use Ice\Core;

/**
 * 性能分析
 * @author kelezyb
 */
class Profile
{
    const TIME_FIELD = "time";
    const MEMORY_FIELD = "memory";
    const DATA_FIELD = "data";

    /**
     * @var Config
     */
    private static instance = null;

    private _sections;

    private _records;

    private _debug;

    /**
     * 构造函数
     */
    public function __construct()
    {
        let this->_sections = [];
        let this->_records = [];

        let this->_debug = Core::Instance()->get("debug");
    }

    /**
     * 记录开始时间
     * @param string name
     */
    public function start(string name)
    {
        if this->_debug {
            // let this->_sections[name] = [
            //     "start" : [
            //         Profile::TIME_FIELD : microtime(true),
            //         Profile::MEMORY_FIELD : memory_get_usage()
            //     ]
            // ];
        }
    }

    /**
     * 记录结束时间
     * @param string name
     */
    public function end(string name)
    {
        if this->_debug {
            // let this->_sections[name]["end"] = [
            //          Profile::TIME_FIELD : microtime(true),
            //          Profile::MEMORY_FIELD : memory_get_usage()
            // ];
        }
    }

    /**
     * 获得性能数据
     * @param string name
     * @param string field
     */
    public function get(string name, string field)
    {
        // if this->_debug {
        //     var info = this->_sections[name];

        //     return info["end"][field] - info["start"][field];
        // } else {
        //     return -1;
        // }
    }

    /**
     * 记录执行性能数据
     * @param string module
     * @param string data
     * @param float time
     * @param int memory
     */
    public function record(string module, string data, float time, int memory)
    {
        if this->_debug {
            // if !isset this->_records[module] {
            //     let this->_records[module] = [];
            // }

            // let this->_records[module][] = [
            //     Profile::DATA_FIELD : data,
            //     Profile::TIME_FIELD : time,
            //     Profile::MEMORY_FIELD : memory
            // ];
        }
    }

    public function getRecords(string module) -> array
    {
        if this->_debug {
            return this->_records[module];
        } else {
            return [];
        }
    }

    public function log()
    {

    }

    /**
     * 获得配置实例
     * @return Profile
     */
    public static function Instance() -> <Profile>
    {
        if null == self::instance {
            let self::instance = new Profile();
        }

        return self::instance;
    }
 }