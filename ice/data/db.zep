namespace Ice\Data;

use Ice\Config;
use Ice\Util\Profile;
use Ice\Error;

/**
 * DB配置
 */
class Db
{
	const FETCH_TYPE_ALL = 0;

	const FETCH_TYPE_LINE = 1;

	private static instance = null;

	/**
	 * @var \PDO
	 */
	private readerhandler;

	/**
	 * @var \PDO
	 */
	private writerhandler;

	public function __construct()
	{
		var config = Config::Instance()->get("databases", "db");
		this->_init(config);
	}

	/**
	 * @param array $config
	 */
	protected function _init(array configs)
	{
		try {
			var readercfg = configs["reader"];
			let this->readerhandler = this->_initHandler(readercfg);
		} catch \PDOException {
			throw new Error("Connect reader DB error", 4001);
		}

		try {
			var writercfg = configs["writer"];
			let this->writerhandler = this->_initHandler(writercfg);
		} catch \PDOException {
			throw new Error("Connect writer DB error", 4001);
		}
	}

    /**
     * 初始化Handler
     * @param array config
     */
	private function _initHandler(config)
	{
		var dns = "%s:host=%s;dbname=%s;port=%s"->format(config["type"], config["host"], config["database"], config["port"]);
		var alertcommd = "set NAMES '%s'"->format(config["encode"]);
		var options = [
			\PDO::ATTR_CASE : \PDO::CASE_NATURAL,
			\PDO::MYSQL_ATTR_INIT_COMMAND : alertcommd,
			\PDO::ATTR_ERRMODE : \PDO::ERRMODE_EXCEPTION
		];

		return new \PDO(dns, config["user"], config["password"], options);
	}

	/**
	 * 执行数据查询
	 * @param string sql
	 * @param int mode
	 * @return array
	 */
	public function query(string sql, int mode = Db::FETCH_TYPE_ALL)
	{
	    string key = "sql_%s"->format(microtime(true));
	    Profile::Instance()->start(key);
 		var stmt;
		var result;

 		let stmt = this->readerhandler->query(sql);

		if stmt {
			if mode == Db::FETCH_TYPE_ALL {
				let result = stmt->fetchAll(\PDO::FETCH_ASSOC);
			} else {
				let result = stmt->$fetch(\PDO::FETCH_ASSOC);
			}
			Profile::Instance()->end(key);
			var time = Profile::Instance()->get(key, Profile::TIME_FIELD);
			var memory = Profile::Instance()->get(key, Profile::MEMORY_FIELD);
			Profile::Instance()->record("sql", sql, time, memory);
			return result;
		} else {
			Profile::Instance()->end(key);
                        var time = Profile::Instance()->get(key, Profile::TIME_FIELD);
                        var memory = Profile::Instance()->get(key, Profile::MEMORY_FIELD);
                        Profile::Instance()->record("sql", sql, time, memory);
			return [];
		}
	}

	public function setopt(string key, string val) {
		string sql = "set %s = '%s'"->format(key, val);
		var ret = this->readerhandler->exec(sql);
	}

    /**
     *
     */
	public function $fetch(string sql)
	{
	    string key = "sql_%s"->format(microtime(true));
        Profile::Instance()->start(key);

		var stmt;
		let stmt = this->readerhandler->prepare(sql, [\PDO::ATTR_CURSOR: \PDO::CURSOR_SCROLL]);
		stmt->execute();
        Profile::Instance()->end(key);
        var time = Profile::Instance()->get(key, Profile::TIME_FIELD);
        var memory = Profile::Instance()->get(key, Profile::MEMORY_FIELD);
        Profile::Instance()->record("sql", sql, time, memory);

		return stmt;
	}

	/**
	 * 执行SQL语句
	 * @param string sql
	 * @param bool id
	 * @return mixed
	 */
	public function execute(string sql, bool id=false)
	{
	    string key = "sql_%s"->format(microtime(true));
        Profile::Instance()->start(key);
		var ret = this->writerhandler->exec(sql);
		Profile::Instance()->end(key);
        var time = Profile::Instance()->get(key, Profile::TIME_FIELD);
        var memory = Profile::Instance()->get(key, Profile::MEMORY_FIELD);
        Profile::Instance()->record("sql", sql, time, memory);

		if id {
			let ret = this->writerhandler->lastInsertId();
		}

		return ret;
	}

	public function beginTransaction()
	{
		return this->writerhandler->beginTransaction();
	}

	public function commit()
	{
		return this->writerhandler->commit();
	}

	public function rollBack()
	{
		return this->writerhandler->rollBack();
	}

	//
	/**
     * 获得配置实例
     * @return Db
     */
	public static function Instance() -> <Db>
	{
		if null == self::instance {
			let self::instance = new Db();
		}

		return self::instance;
	}

	/**
	 * @param string str
	 * @return string
	 */
	public function real_escape_string(str) -> string
	{
		return addslashes(str);
	}
}
