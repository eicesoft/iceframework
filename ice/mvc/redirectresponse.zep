namespace Ice\Mvc;

use Ice\Core;

/**
 * 页面跳转输出
 * @author kelezyb
 */
class RedirectResponse extends Response
{
	public function getContent() -> string
	{
		this->header("Location: %s"->format(this->data));

		return "";
	}
}