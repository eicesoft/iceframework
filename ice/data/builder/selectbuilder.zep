namespace Ice\Data\Builder;

//Select sql builder class
final class SelectBuilder
{
	/**
	 * 表格
	 * @var string
	 */
	private _table;

	/**
	 * 字段
	 * @var mixed
	 */
	private _fields = "*";

	/**
	 * 条件
	 * @var mixed
	 */
	private _wheres = [];

	/**
	 * @var array
	 */
	private _groups = [];

	/**
	 * 排序
	 * @var array
	 */
	private _orders = [];

	/**
	 * 限制
	 * @var mixed
	 */
	private _limit;

	/**
	 * 设置表格名称
	 * @param string table
	 * @return <SqlBuilder>
	 */
	public function table(string table) -> <SqlBuilder>
	{
		let this->_table = table;
		return this;
	}

	/**
	 * 设置字段数据
	 * @param mixed fields
	 * @return <SqlBuilder>
	 */
	public function fields(fields) -> <SqlBuilder>
	{
		let this->_fields = fields;
		return this;
	}

	/**
	 * 设置查询条件
	 * @param mixed wheres
	 * @return <SqlBuilder>
	 */
	public function where(wheres) -> <SqlBuilder>
	{
		let this->_wheres = wheres;
		return this;
	}

	/**
	 * 设置分组数据
	 * @param mixed groups
	 * @return <SqlBuilder>
	 */
	public function group(groups) {
		let this->_groups = groups;
		return this;
	}

	/**
	 * 设置排序规则
	 * @param array orders
	 * @return <SqlBuilder>
	 */
	public function order(orders) -> <SqlBuilder>
	{
		let this->_orders = orders;
		return this;
	}

	/**
	 * 设置限制数量
	 * @param mixed limit
	 * @return SQLBuilder
	 */
	public function limit(limit) -> <SqlBuilder>
	{
		let this->_limit = limit;
		return this;
	}

	private function _get_field() -> string
	{
		if this->_fields {
			if is_array(this->_fields) {
				return join(",", this->_fields);
			} else {
				return this->_fields;
			}
		} else {
			return "*";
		}
	}

	/**
	 * 获得WHERE子语句
	 * @return string
	 */
	private function _get_where() -> string
	{
		if this->_wheres {
			if is_array(this->_wheres) {
				return " WHERE " . join(" AND ", this->_wheres);
			} else {
				return " WHERE " . this->_wheres;
			}
		} else {
			return "";
		}
	}

	private function _get_groups() {
		if this->_groups {
			if is_array(this->_groups) {
				return " GROUP BY " . join(",", this->_groups);
			} else {
				return " GROUP BY " . this->_groups;
			}
		} else {
			return "";
		}
	}

	/**
	 * 获得排序子语句
	 * @return string
	 */
	private function _get_order() -> string
	{
		if this->_orders {
			return " ORDER BY " . join(",", this->_orders);
		} else {
			return "";
		}
	}

	/**
	 * 获得LIMIT子语句
	 * @return string
	 */
	private function _get_limit() -> string
	{
		if this->_limit {
			if is_array(this->_limit) {
				return " LIMIT " . join(",", this->_limit);
			} else {
				return " LIMIT " . this->_limit;
			}
		} else {
			return "";
		}
	}

	/**
	 * 构造sql语句
	 * @return string
	 */
	public function __toString() -> string
	{
		var sql = "SELECT %s FROM %s%s%s%s%s"->format(
			this->_get_field(), this->_table, this->_get_where(),
			this->_get_groups(), this->_get_order(), this->_get_limit());

		this->clear();

		return sql;
	}

	public function clear()
	{
		let this->_table = null;
		let this->_fields = "*";
		let this->_wheres = [];
		let this->_groups = [];
		let this->_orders = [];
		let this->_limit = null;
	}
}