namespace Ice;

class Error extends \Exception
{
	const ERROR_NO_CLASS = 101;
	const ERROR_NO_COMPONENT_METHOD = 102;
	const ERROR_NO_MODEL_METHOD = 103;
	const ERROR_NO_URI = 401;
	const ERROR_NO_FOUND_CACHE_CONFIG = 601;
	const ERROR_HTTP_FETCH = 1001;
}