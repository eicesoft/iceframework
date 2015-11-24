namespace Ice\Mvc;

/**
 * URL 响应类
 * @author kelezyb
 */
abstract class Response
{
    /**
     * @var mixed
     */
	protected data;

    /**
     * 构造函数
     * @param mixed data
     */
	public function __construct(data)
	{
		let this->data = data;
	}

    /**
     * 获得数据
     */
	public function getData()
	{
		return this->data;
	}

    /**
     * 设置Header参数
     * @param string header
     */
	public function header(string header)
	{
		 header(header);
	}

    /**
     * 获得响应内容
     * @return string
     */
	abstract public function getContent() -> string;
}