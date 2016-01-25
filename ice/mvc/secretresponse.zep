namespace Ice\Mvc;

use Ice\Core;

/**
 * JSON输出
 * @author kelezyb
 */
class SecretResponse extends Response
{
	public function getContent() -> string
	{
		//this->header("Content-Type:application/octet-stream");

		return gzcompress(json_encode(this->data));
	}
}