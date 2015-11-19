namespace Ice\Data;

use Ice\Data\Builder\SelectBuilder;

//数据模块
class Model
{
	/**
	 * 表名
	 * @var string
	 */
	protected _table = "";

	/**
	 * 主键
	 * @var string
	 */
	protected _pk;

	/**
	 *
	 * @var <StringBuilder>
	 */
	protected _sb;

	public function __construct()
	{
		let this->_sb = new SelectBuilder();
	}

	/**
	 * 获得主键数据
	 *
	 * @param int $id
	 * @return array
	 */
	public function get(id) -> array
	{
		this->_sb->table(this->_table)->where(this->_pk . "='" . id . "'");

		return this->query(this->_sb, Db::FETCH_TYPE_LINE);
	}

	public function getall(bool format = false) -> array
	{
		this->_sb->table(this->_table);

		if format {
			var datas;
			let datas = this->query(this->_sb, Db::FETCH_TYPE_ALL);

			return this->formatrows(datas);
		} else {
			return this->query(this->_sb, Db::FETCH_TYPE_ALL);
		}
	}

	public function getwhere(array wheres) -> array
	{
		this->_sb->table(this->_table)->where(wheres);

		return this->query(this->_sb, Db::FETCH_TYPE_ALL);
	}

	public function getpage(string where = null, int page = 1, int max = 10, string order=null) -> array
	{
		var start;
		let start = (page - 1) * max;
		this->_sb->table(this->_table)->where(where)->order(order)->limit([start, max]);

		return this->query(this->_sb, Db::FETCH_TYPE_ALL);
	}

	public function formatrows(array datas) -> array
	{
		var ret = [];
		var data;
		for data in datas {
			let ret[data[this->_pk]] = data;
		}

		return ret;
	}

	/**
	* 查询数据数量
	*
	* @param array $where
	* @return int
	*/
	public function count(array! where = []) -> int
	{
		this->_sb->table(this->_table)->fields("Count(0) as C")->where(where);

		var data = this->query(this->_sb, Db::FETCH_TYPE_LINE);
		if isset data["C"] {
			return intval(data["C"]);
		} else {
			return 0;
		}
	}

	//更新数据
	public function update(array data, id) -> int
	{
		array sets = [];
		var sql;
		var k,v;

		for k, v in data {
			if is_string(v) {
				let v =  Db::Instance()->real_escape_string($v);
				let sets[] = "`%s`='%s'"->format(k, v);
			} else {
				let sets[] = "`%s`=%s"->format(k, v);
			}
		}

		let sql = "UPDATE `%s` SET %s WHERE %s='%s'"->format(
			this->_table, sets->join(","), this->_pk, id
		);

		return this->execute(sql);
	}

	public function insert(array data, bool lastId = false) -> int
	{
		var k, v;
		var sql;
		array fields = [];
		array values = [];
		for k,v in data {
			let fields[] = "`" . k . "`";

			if is_string(v) {
				let v =  Db::Instance()->real_escape_string($v);
				let values[] = "'" . v . "'";
			} else {
				let values[] = v;
			}
		}

		let sql = "INSERT INTO `%s`(%s) VALUES(%s)"->format(this->_table, fields->join(","), values->join(","));

		return this->execute(sql, lastId);
	}

	public function delete(id) -> int
	{
		var sql = "DELETE FROM `%s` WHERE `%s`='%s'"->format(this->_table, this->_pk, id);

		return this->execute(sql);
	}

	public function deletewhere(string where) -> int
	{
		var sql = "DELETE FROM `%s` WHERE %s"->format(this->_table, where);

		return this->execute(sql);
	}

	protected function getSelectBuilder() -> <SelectBuilder>
	{
		return this->_sb;
	}

	protected function $fetch(string sql) -> array
	{
		return Db::Instance()->$fetch(sql);
	}

	protected function query(string sql, int model) -> array
	{
		return Db::Instance()->query(sql, model);
	}

	protected function execute(string sql, bool lastId = false)
	{
		return Db::Instance()->execute(sql, lastId);
	}
}