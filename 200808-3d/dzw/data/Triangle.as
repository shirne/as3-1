package dzw.data
{
	import flash.display.Sprite;
	
	/**
	 *	三角形
	 */
	public class Triangle extends Sprite
	{
		private var pa:DPoint;
		private var pb:DPoint;
		private var pc:DPoint;
		
		private var color:uint;
		
		public function Triangle(pa:DPoint, pb:DPoint, pc:DPoint, color:uint = 0x22222222)
		{
			this.pa = pa;
			this.pb = pb;
			this.pc = pc;
			this.color = color;
		}
		
		/**
		 *	绘制三角形
		 */
		public function draw(light:Light):void
		{
			graphics.clear();
			if(pa.IsBack || pb.IsBack || pc.IsBack)
				return ;
				
			if( isBackFace())
				return ;
			graphics.clear();
			//graphics.beginFill(color)
			graphics.beginFill(getAdjustedColor(light));
			graphics.lineStyle(0, color, 0);
			graphics.moveTo(pa.ScreenX, pa.ScreenY);
			graphics.lineTo(pb.ScreenX, pb.ScreenY);
			graphics.lineTo(pc.ScreenX, pc.ScreenY);
			graphics.lineTo(pa.ScreenX, pa.ScreenY);
			graphics.endFill();
		}
		
		/**
		 *	是否背向,用与测试是否绘制它
		 */
		private function isBackFace():Boolean 
		{
			return (pc.ScreenX - pa.ScreenX)*(pb.ScreenY - pc.ScreenY) > (pc.ScreenY - pa.ScreenY)*(pb.ScreenX - pc.ScreenX);
		}
		
		/**
		 *	返回深度
		 */
		public function get depth():Number
		{
			var temp:Number = (pa.Z<pb.Z) ? pa.Z : pb.Z;
			return  ( temp < pc.Z) ? temp : pc.Z;
		}
		
		/**
		 *	返回光照下的颜色
		 */
		private function getAdjustedColor(light:Light):uint 
		{
			var a:Number = color >> 24;
			var red:Number = color >> 16;
			var green:Number = color >> 8 & 0xff;
			var blue:Number = color & 0xff;
			var lightFactor:Number = getLightFactor(light);
			a *= lightFactor;
			red *= lightFactor;
			green *= lightFactor;
			blue *= lightFactor;
			return a << 24 | red << 16 | green << 8 | blue;
		}
		
		/*
		 *	返回与法向量的夹角
		 */
		private function getLightFactor(light:Light):Number 
		{
			var abx:Number = pa.X - pb.X;
			var aby:Number = pa.Y - pb.Y;
			var abz:Number = pa.Z - pb.Z;
			
			var bcx:Number = pb.X - pc.X;
			var bcy:Number = pb.Y - pc.Y;
			var bcz:Number = pb.Z - pc.Z;
			
			var normx:Number = (aby * bcz) - (abz * bcy);
			var normy:Number = -( (abx * bcz) - (abz * bcx));
			var normz:Number = (abx * bcy) - (aby * bcx);
			
			var dotProd:Number = normx * light.X + normy * light.Y + normz * light.Z;
			var normMag:Number = Math.sqrt(normx * normx + normy * normy + normz * normz);
			var lightMag:Number = Math.sqrt(light.X * light.X + light.Y * light.Y + light.Z * light.Z);
			
			return (Math.acos(dotProd / (normMag * lightMag)) / Math.PI) * light.Brightness;
		}
	}
}