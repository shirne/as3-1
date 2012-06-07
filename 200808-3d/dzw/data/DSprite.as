package dzw.data
{
	import flash.display.Sprite;
	import flash.events.*;
	import dzw.base.LoadX;
	
	/*
	 *	加载外部模型数据的ThreeSprite
	 */
	 
	public class DSprite extends ThreeSprite
	{
		private var xf:LoadX;

		public function DSprite(xPath:String)
		{
			xf = new LoadX(xPath);
			xf.addEventListener(LoadX.X_LOADED, onLoadComplete);
			xf.addEventListener(LoadX.LOAD_ERROR, onLoadError);
		}
		
		/**
		 *	加载器出错处理函数
		 */
		private function onLoadError(event:Event):void
		{
			xf.removeEventListener(LoadX.X_LOADED, onLoadComplete);
			xf.removeEventListener(LoadX.LOAD_ERROR, onLoadError);
			xf = null;
		}
		
		/**
		 *	加载完成:获取数据
		 */
		private function onLoadComplete(event:Event):void
		{
			model = xf.getData();
			this.l = model.length-1;
			var l:int = this.l;
			var ll:int = model[l].length;
			
			var temp:Array = model[l];
			
			for(var i = 0; i < ll; i ++)
			{
				addChild(temp[i]);
			}
			
			var duoshaox:Number = Math.random() * 3000;
			var duoshaoy:Number = Math.random() * 2000;
			var duoshaoz:Number = Math.random() * 2000;
			for( i = 0; i < l; i ++)
			{
				temp = model[i];
				ll = temp.length;
				for(var j = 0; j < ll ; j ++)
				{
					temp[j].jia(duoshaox, duoshaoy, duoshaoz);
				}
				
			}
			
			xf.removeEventListener(LoadX.X_LOADED, onLoadComplete);
			xf = null;
		}
	}
}