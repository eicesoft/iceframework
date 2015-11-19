namespace Ice\Mvc;

use Ice\Core;

//控制器类
class SecretController extends Controller
{
	public function __construct()
	{
		//var_dump(_REQUEST);
		parent::__construct();
		this->vaild();
	}

	public function sort(array value) -> array
	{
		ksort(value);
		return value;
	}

	public function vaild()
	{
		if isset _REQUEST["secret"] && isset _REQUEST["time"] {
			var time = time();
			var rtime = _REQUEST["time"];
			unset _REQUEST["time"];

			if time >= rtime && time - rtime < 4600 {
				var arr;
				var secret = _REQUEST["secret"];
				unset _REQUEST["secret"];
				let arr = this->sort(_REQUEST);
				var k, v;
				var ss = [];
				for k, v in arr {
					let ss[] = "%s%s"->format(k, v);
				}
				var app_config = Core::Instance()->getAppConfig();
				var secretstr = md5("%s%s"->format(join("", ss), app_config["secret"]));
				if secretstr !== secret {
					echo new ErrorResponse([502, "Secret vaild info fails."])->getContent();
				}
			} else {
				echo new ErrorResponse([502, "Secret vaild time fails."])->getContent();
			}
		} else {
			echo new ErrorResponse([502, "Secret vaild fails."])->getContent();
		}
	}
}