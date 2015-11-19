namespace Ice\Mvc;

use Ice\Core;

//JSON输出
class RedirectResponse extends Response
{
	public function getContent() -> string
	{
		this->header("Location: %s"->format(this->data));

		return "";
	}
}