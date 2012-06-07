package dzw.data
{
	import flash.display.Sprite;
	
	/**
	 *	空间三维元件类
	 */
	public class ThreeSprite extends Sprite
	{
		protected var l:int;
		
		//模型数据,最后一个位置为所有三角形,前面为所有顶点
		protected var model:Array = new Array;
		public var light:Light = new Light();
		
		/**
		 *	绘制元件
		 */
		public function render(eye:Line):void
		{
			if(l > 0)
			{
				var ll:int;
				var temp:Array;
				for(var i = 0; i < l; i ++)
				{
					ll = model[i].length;
					temp = model[i];

					for(var j = 0; j < ll ; j ++)
					{
						//对所有顶点设置视觉,计算屏幕位置
						temp[j].setEye(eye);
					}
				
				}
				
				
				//所有三角形深度排序
				model[l].sortOn("depth", Array.DESCENDING | Array.NUMERIC);
				
				ll = model[l].length;
				temp = model[l];
	
				for(i = 0; i < ll; i ++)
				{
					//绘制三角形
					temp[i].draw(light);
				}
			}
		}
		
		/**
		 *	元件绕X轴旋转
		 */
		public function rotateX(rotate:Number):void
		{
			var l:int = this.l;
			
			if(l > 0)
			{
				var ll:int;
				
				while(l--)
				{
					ll = model[l].length;
					while(ll--)
					{
						model[l][ll].rotateX(rotate/Math.PI);
					}
				}
			}
		} 
		
		/**
		 *	元件绕Y轴旋转
		 */
		public function rotateY(rotate:Number):void
		{
			var l:int = this.l;
			
			if(l > 0)
			{
				var ll:int;
				
				while(l--)
				{
					ll = model[l].length;
					while(ll--)
					{
						model[l][ll].rotateY(rotate/Math.PI);
					}
				}
			}
		}
		
		/**
		 *	元件绕Z轴旋转
		 */
		public function rotateZ(rotate:Number):void
		{
			var l:int = this.l;
			
			if(l > 0)
			{
				var ll:int;
				
				while(l--)
				{
					ll = model[l].length;
					while(ll--)
					{
						model[l][ll].rotateZ(rotate/Math.PI);
					}
				}
			}
		}
	}
}