namespace Ice\Data;

use Ice\Data\Builder\SelectBuilder;

/**
 * 数据模块
 * @package Ice\Data
 * @author kelezyb
 */
class SubMeter
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
	 * 分表数量
	 * @var int
	 */
	protected _count;

	/**
	 *
	 * @var <StringBuilder>
	 */
	protected _sb;

	public function __construct()
	{
		let this->_sb = new SelectBuilder();
	}

	public function get_table() {

	}
}