namespace Ice\Mvc;

use Ice\Core;

/**
 * 页面模板输出
 * @author kelezyb
 */
class TempletResponse extends Response
{
    /**
     * @var string
     */
	private view;

    /**
     * @var string
     */
	private viewpath;

    /**
     *
     * var \Twig_Environment
     */
	private twig;

    /**
     * 构造函数
     * @param string view
     * @param array data
     */
	public function __construct(string view, array data)
	{
		let this->view = view;
		var app_config = Core::Instance()->getAppConfig();
		var viewPath = "%s/%s"->format(Core::Instance()->getAppPath(),  app_config["paths"]["view"]);
		var viewCachePath = "%s/%s/views"->format(Core::Instance()->getAppPath(),  app_config["paths"]["cache"]);
		var loader;
		let loader = new \Twig_Loader_Filesystem(viewPath);
		var config = [
			"cache": viewCachePath,
			"debug": app_config["debug"],
			"auto_reload": app_config["debug"]
		];
		let this->twig = new \Twig_Environment(loader, config);

		this->twig->addExtension(new \Twig_Extension_Debug());
        try {
            this->twig->addGlobal("session", _SESSION);
        } catch \Exception {

        }

		this->twig->addGlobal("server", _SERVER);

		this->addUri();
		this->addScript();
		this->addStyle();
		this->addPlugin();
		this->addImage();

		parent::__construct(data);
	}

    /**
     * 添加urimatch函数
     */
	public function addUri()
	{
		var func;
		let func = new \Twig_SimpleFunction("urimatch", function(var match) {
			var uri = \Ice\Mvc\Request::Instance()->getUri();
			return strpos(uri, match) === 0;
		});

		this->twig->addFunction(func);
	}

    /**
     * 添加script函数
     */
	private function addScript()
	{
		var func;
		let func = new \Twig_SimpleFunction("script", function(file) {
			return "<script type=\"text/javascript\" src=\"/statics/scripts/" . file . "?v=" . Core::Instance()->get("version") . "\"></script>";
		}, ["pre_escape": false, "preserves_safety": false, "is_safe": ["html"]]);
		this->twig->addFunction(func);
	}

	private function addImage()
	{
		var func;
		let func = new \Twig_SimpleFunction("image", function(file) {
			return "<image src=\"/statics/images/" . file . "?v=" . Core::Instance()->get("version") . "\" />";
		}, ["pre_escape": false, "preserves_safety": false, "is_safe": ["html"]]);
		this->twig->addFunction(func);
	}

    /**
     * 添加style函数
     */
	private function addStyle()
	{
		var func;
		let func = new \Twig_SimpleFunction("style", function(file) {
			return "<link rel=\"stylesheet\" href=\"/statics/styles/" . file . "?v=" .  Core::Instance()->get("version") . "\" />";
		}, ["pre_escape": false, "preserves_safety": false, "is_safe": ["html"]]);
		this->twig->addFunction(func);
	}

    /**
     * 添加plugins函数
     */
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

	public function addFunction(string funcname, var callback, array params) {
		var func;
		let func = new \Twig_SimpleFunction(funcname, callback, params);
		this->twig->addFunction(func);
	}
	
    /**
     * 获取模板内容
     * @return string
     */
	public function getContent() -> string
	{
		var tpl = "%s.twig"->format(this->view);
	 	var template = this->twig->loadTemplate(tpl);
		return template->render(this->data);
	}
}