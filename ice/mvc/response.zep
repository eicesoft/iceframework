namespace Ice\Mvc;

//URL 响应类
abstract class Response
{
	protected data;

	public function __construct(data)
	{
		let this->data = data;
	}

	public function getData()
	{
		return this->data;
	}

	public function header(string header)
	{
		 header(header);
	}

	abstract public function getContent() -> string;
}