package dzw.base
{
	import flash.utils.getTimer;
	import dzw.data.*;
	import flash.display.Sprite;
    import flash.events.*;
    import flash.net.*;
	import flash.utils.ByteArray;

	
	public class LoadX extends EventDispatcher
	{
		public static var X_LOADED:String = "xLoad";
    	public static var LOAD_ERROR:String = "loadError";
		
		//加载swf中类定义的加载器
		private var m_ldrLoadX:URLLoader = new URLLoader();
		private var m_strUrlPath:String;
		private var all:Array = new Array;
		
		public function LoadX(xPath:String)
		{
			m_strUrlPath =  xPath;
			m_ldrLoadX.load(new URLRequest(m_strUrlPath));
			m_ldrLoadX.addEventListener(Event.COMPLETE, completeHandler);	//侦听加载完成事件
			m_ldrLoadX.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);	//侦听加载完成事件
		}
		
		private function ioErrorHandler(event:Event):void 
		{
			m_ldrLoadX.removeEventListener(Event.COMPLETE, completeHandler);
			m_ldrLoadX.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			m_ldrLoadX = null;
			dispatchEvent(new Event(LoadX.LOAD_ERROR));
		}
		
		private function completeHandler(event:Event):void 
		{
			var newTime:Number = getTimer();
			var str:String = new String(m_ldrLoadX.data);
			//var str:String = m_ldrLoadX.data as String;
			var index:int;
			var tempArr:Array;
			var oneMeshT:Array = new Array;
			while(1)				//是否还有Mesh
			{
				index =  str.indexOf("Mesh ", index+1);
				if(index == -1)
					break;
				if(str.charCodeAt(index-2) == 101)
					continue;
				
				var oneMesh:Array = new Array;
				
				index = str.indexOf(";", index+1);
				
				
				var newIndex:int = str.indexOf(";;", index+1);
				
				var subStr:String = str.substr(index+1, newIndex - index);	//每个mesh..顶点数据
				var strArr:Array = subStr.split(',');						//按每行拆分
				
				for(var i:int = 0; i < strArr.length; i ++)					//循环读取每行数据
				{
					tempArr = strArr[i].split(';');				//拆分每行的三个数据
					var p:DPoint = new DPoint(Number(tempArr[0])*100, Number(tempArr[1])*100, Number(tempArr[2])*100);
					oneMesh.push(p);
					tempArr[0] = null;
					tempArr[1] = null;
					tempArr[2] = null;
					tempArr = null;
					strArr[i] = null;
				}
				
				index = str.indexOf(";", newIndex+3);						//每个mesh三角形数据
				newIndex = str.indexOf(";;", index+1);
				subStr = null;
				subStr = str.substr(index+1, newIndex - index);	
				strArr = null;
				strArr = subStr.split(/;,/);									//按每行拆分
				
				var tempIndex:int = str.indexOf("Material {", newIndex);
				var argb:uint = 0xFFFFFFFF;
				if(tempIndex != -1)
				{
					var tt:int = str.indexOf(";;", tempIndex);
					var ssubstr:String = str.substr(tempIndex+12, tt-tempIndex-12);
					var colorArr:Array = ssubstr.split(/;/);
					var r:uint = (Number(colorArr[0]))*255 << 16;
					var g:uint = (Number(colorArr[1]))*255 << 8;
					var b:uint = (Number(colorArr[2]))*255;
					var a:uint = (Number(colorArr[3]))*255 << 24;
					argb = r + g + b + a;
				}
				
				for(i = 0; i < strArr.length; i ++)
				{
					tempArr = strArr[i].split(';');				
					
					if(Number(tempArr[0]) > 3)
					{
						for(var tl:int = 0; tl< tempArr.length; tl ++)
						{
							tempArr[tl] = null;
						}
						tempArr = null;
						continue;
					}
					tempArr[0] = null;

					tempArr = tempArr[1].split(',');
					
					var t:Triangle = new Triangle(oneMesh[Number(tempArr[0])], oneMesh[Number(tempArr[1])], oneMesh[Number(tempArr[2])], argb)
					tempArr[0] = null;
					tempArr[1] = null;
					tempArr[2] = null;
					tempArr = null;
					oneMeshT.push(t);
				}
				
				all.push(oneMesh);
				
			}
			all.push(oneMeshT);
			str = null;
			m_ldrLoadX.removeEventListener(Event.COMPLETE, completeHandler);
			m_ldrLoadX = null;
        	dispatchEvent(new Event(LoadX.X_LOADED));
			trace(getTimer() - newTime);
    	}

		public function getData():Array
		{
			return all;
		}

    	private function securityErrorHandler(e:Event):void 
		{
        	
   		}
	}
}