namespace Ice\Mvc;

use Ice\Core;

//JSON输出
class JsonResponse extends Response
{
	public function getContent() -> string
	{
		this->header("Content-Type:application/json");

		return json_encode(this->data);
	}
}