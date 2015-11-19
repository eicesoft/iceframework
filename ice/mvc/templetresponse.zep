namespace Ice\Mvc;

use Ice\Core;

class TempletResponse extends Response
{
	private view;

	private viewpath;

	private twig;

	public function __construct(string view, array data)
	{
		let this->view = view;
		var app_config = Core::Instance()->getAppConfig();
		var viewPath = "%s/%s/%s"->format(app_config["base"],  app_config["app"],  app_config["paths"]["view"]);
		var viewCachePath = "%s/%s/%s/views"->format(app_config["base"],  app_config["app"],  app_config["paths"]["cache"]);
		var loader;
		let loader = new \Twig_Loader_Filesystem(viewPath);
		var config = [
			"cache": viewCachePath,
			"debug": false,
			"auto_reload": true
		];
		let this->twig = new \Twig_Environment(loader, config);

        this->twig->addExtension(new \Twig_Extension_Optimizer());
		this->twig->addExtension(new \Twig_Extension_Debug());

		this->twig->addGlobal("session", _SESSION);
		this->twig->addGlobal("server", _SERVER);

		this->addUri();
		this->addScript();
		this->addStyle();
		this->addPlugin();

		parent::__construct(data);
	}

	public function addUri()
	{
		var func;
		let func = new \Twig_SimpleFunction("urimatch", function(var match) {
			var uri = \Ice\Mvc\Request::Instance()->getUri();
			return strpos(uri, match) === 0;
		});

		this->twig->addFunction(func);
	}

	private function addScript()
	{
		var func;
		let func = new \Twig_SimpleFunction("script", function(file) {
			return "<script type=\"text/javascript\" src=\"/statics/scripts/" . file . "?v=" . Core::Instance()->get("version") . "\"></script>";
		}, ["pre_escape": false, "preserves_safety": false, "is_safe": ["html"]]);
		this->twig->addFunction(func);
	}

	private function addStyle()
	{
		var func;
		let func = new \Twig_SimpleFunction("style", function(file) {
			return "<link rel=\"stylesheet\" href=\"/statics/styles/" . file . "?v=" .  Core::Instance()->get("version") . "\" />";
		}, ["pre_escape": false, "preserves_safety": false, "is_safe": ["html"]]);
		this->twig->addFunction(func);
	}

	private function addPlugin()
	{
		var func;
		let func = new \Twig_SimpleFunction("plugins", function(linktype, file) {
			if linktype == "script" {
				return "<script charset=\"utf-8\" type=\"text/javascript\" src=\"/statics/plugins/{$file}?v=" . Core::Instance()->get("version") . "\"></script>";
			} elseif linktype == "css" {
				return "<link rel=\"stylesheet\"  href=\"/statics/plugins/" . file . "?v=" . Core::Instance()->get("version") . "\" />";
			}

		}, ["pre_escape": false, "preserves_safety": false, "is_safe": ["html"]]);
		this->twig->addFunction(func);
	}

	public function getContent() -> string
	{
		var tpl = "%s.twig"->format(this->view);
	 	var template = this->twig->loadTemplate(tpl);
		return template->render(this->data);
	}
}