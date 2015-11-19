namespace Ice\Mvc;

class Route
{
	private controller;

	private method;

	public function __construct(string controllermethod)
    {
    	var info = explode("@", controllermethod);

    	let this->controller = info[0];
    	let this->method = info[1];
    }

    public function getController() -> string
    {
    	return this->controller;
    }

    public function getMethod() -> string
    {
    	return this->method;
    }
}