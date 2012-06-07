package dzw.data
{
	import dzw.base.DMath;
	
	/**
	 *	空间三维点
	 */
	 
	public class DPoint
	{
		//空间坐标
		private var px:Number;
		private var py:Number;
		private var pz:Number;
		
		//屏幕坐标
		private var screenX:Number;
		private var screenY:Number;
		private var screenZ:Number;
		
		//是否处于视野之后
		private var isBack:Boolean;
		
		public function DPoint(px:Number, py:Number, pz:Number)
		{
			this.px = px;
			this.py = py;
			this.pz = pz;
		}
		
		public function toArray():Array
		{
			return [px, py, pz];
		}
		
		/**
		 *	与另外一点所成向量
		 */
		public function vector(d:DPoint):DVector
		{
			return new DVector(d.px - this.px, d.py - this.py, d.pz - this.pz);
		}
		
		/**
		 *	与另外一点所成距离
		 */
		public function distance(p:DPoint):Number
		{
			return Math.sqrt((p.px-this.px)*(p.px-this.px) + (p.py-this.py)*(p.py-this.py) + (p.pz-this.pz)*(p.pz-this.pz));
		}
		
		/**
		 *	与一条直线的垂直交点
		 */
		public function interToLine(l:Line):DPoint
		{
			var asd:DVector = l.Aspect;
			var dp:DPoint = l.Point;
			
			var molecule:Number  = (px - dp.px)*asd.X  + (py - dp.py)*asd.Y + (pz - dp.pz)*asd.Z ;
			
			var denominator:Number = asd.X*asd.X + asd.Y*asd.Y + asd.Z*asd.Z; 
			
			var t:Number = molecule / denominator;

			return new DPoint(t*asd.X+dp.px, t*asd.Y+dp.py, t*asd.Z+dp.pz);
		}
		
		//随意函数,增大坐标,方便测试
		public function jia(duoshaox:Number, duoshaoy:Number, duoshaoz:Number):void
		{
			px += duoshaox;
			py += duoshaoy;
			pz += duoshaoz;
		}
		
		/**
		 *	设置视觉[Line:[起点,向量]]
		 *	计算视觉下此点的屏幕坐标
		 */
		public function setEye(eye:Line):void
		{
			var haha:DVector = eye.Point.vector(this);
			var re:Number =  eye.Aspect.getNip(haha);
			
			if(re < 0)
			{
				isBack = true;
				return ;
			}
			else
			{
				isBack = false;
				
				var jiaodian:DPoint = interToLine(eye);
				var xiangliang:DVector  = eye.Aspect.getApeakX0Y();
				var tem:DVector = jiaodian.vector(this);
				
				var res:Number = xiangliang.getNip(tem);
				
				var jiaodu:Number = Math.acos(res);
				var ppToJiaodian:Number = distance(jiaodian);
				
				screenZ = eye.Point.distance(jiaodian);
				screenX = ppToJiaodian * res * Clobal.fl / (Clobal.fl + screenZ) + Clobal.W2;
				
				if(this.pz > jiaodian.pz)
				{
					screenY = ppToJiaodian * Math.sin(jiaodu) * Clobal.fl / (Clobal.fl + screenZ) + Clobal.H2;
				}else if(this.pz < jiaodian.pz)
				{
					screenY = ppToJiaodian * (-Math.sin(jiaodu)) * Clobal.fl / (Clobal.fl + screenZ) + Clobal.H2;
				}
				else
				{
					screenY = Clobal.H2;
				}
			}
		}
		
		public function set X(px:Number):void
		{
			this.px = px;
		}
		public function set Y(py:Number):void
		{
			this.py = py;
		}
		public function set Z(pz:Number):void
		{
			this.pz = pz;
		}
		
		public function get X():Number
		{
			return this.px;
		}
		public function get Y():Number
		{
			return this.py;
		}
		public function get Z():Number
		{
			return this.pz;
		}
		
		public function get ScreenX():Number
		{
			return screenX;
		}
		public function get ScreenY():Number
		{
			return screenY;
		}
		public function get ScreenZ():Number
		{
			return screenZ;
		}
		
		public function get IsBack():Boolean
		{
			return isBack;
		}
		
		/**
		 *	按X轴旋转此点
		 */
		public function rotateX(angleX:Number):void
		{
			var temp:Number = py;
			py = Math.cos(angleX)*py - Math.sin(angleX)*pz;
			pz = Math.cos(angleX)*pz + Math.sin(angleX)*temp;
		}
		
		/**
		 *	按Y轴旋转此点
		 */
		public function rotateY(angleY:Number):void
		{
			var temp:Number = px;
			px = Math.cos(angleY)*px - Math.sin(angleY)*pz;
			pz = Math.cos(angleY)*pz + Math.sin(angleY)*temp;
		}
		
		/**
		 *	按Z轴旋转此点
		 */
		public function rotateZ(angleZ:Number):void
		{
			var temp:Number = px;
			px = Math.cos(angleZ)*px - Math.sin(angleZ)*py;
			py = Math.cos(angleZ)*py + Math.sin(angleZ)*temp;
		}
	}
	
}