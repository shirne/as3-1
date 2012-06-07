package test.demo
{
	
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.display.LoaderInfo;

	//class	:	负责加载外部swf通用模块
	
	public class LoadRes extends EventDispatcher
	{
		public static var CLASS_LOADED:String = "classLoaded";
    	public static var LOAD_ERROR:String = "loadError";
		//加载swf中类定义的加载器
		private var m_ldrLoadSwf:Loader = new Loader();		
		//所加载的swf的路径
		private var m_strUrlPath:String;					
		private var m_loadedSWFInfo:LoaderInfo;
		
		//无参数构造方法
		public function LoadRes()					
		{
		}
		
		//设置swf路径
		public function setUrlPath(urlPath:String):void		
		{
			m_strUrlPath = urlPath;
		}
		
		//开始加载外部swf
		public function startLoad():void					
		{
			m_ldrLoadSwf.load(new URLRequest(m_strUrlPath));
			m_ldrLoadSwf.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);	//侦听加载完成事件
		}
		
		//根据参数在加载的swf里获取Class类定义
		public function getClass(className:String):Class
		{
			var myClass:Class = m_loadedSWFInfo.applicationDomain.getDefinition(className) as Class;
			if(myClass != null)	{
				return myClass;
			}
			return null;
		}
		
		//加载swf完毕的事件处理
		private function completeHandler(event:Event):void 
		{
			m_loadedSWFInfo = event.target as LoaderInfo;
        	dispatchEvent(new Event(LoadRes.CLASS_LOADED));
    	}

    	private function ioErrorHandler(e:Event):void 
		{
        	dispatchEvent(new Event(LoadRes.LOAD_ERROR));
    	}

    	private function securityErrorHandler(e:Event):void 
		{
        	dispatchEvent(new Event(LoadRes.LOAD_ERROR));
   		}

	}
}