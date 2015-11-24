namespace Ice\Mvc;

use Ice\Core;

/**
 * 错误码输出
 * @author kelezyb
 */
class ErrorResponse extends Response
{
	public function getContent() -> string
	{
		var code = this->data[0];
		var message = this->data[1];
		this->header("HTTP/1.1 " . code . " " . message);

		die("Server " . code . " bad gateway, ". message);

		return "";
	}
}