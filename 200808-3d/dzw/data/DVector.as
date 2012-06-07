package dzw.data
{
	
	import dzw.base.DMath;
	import dzw.data.Clobal;
	
	/**
	 *	空间向量类
	 */ 
	 
	public class DVector
	{
		private var vx:Number;
		private var vy:Number;
		private var vz:Number;
		
		//此向量的垂直向量,且在X0Y平面内
		private var ak:DVector = null;	
		
		public function DVector(vx:Number, vy:Number, vz:Number)
		{
			this.vx = vx;
			this.vy = vy;
			this.vz = vz;
		}
		 
		public function toArray():Array
		{
			return [vx, vy, vz];
		}
		
		/**
		 *	返回垂直向量
		 */
		public function getApeakX0Y():DVector
		{
			if(ak == null)
			{
				ak = new DVector(-vy, vx, 0);
			}
			return ak;
		}
		
		/**
		 *	返回向量的模
		 */
		public function getSquare():Number
		{
			return vx*vx + vy*vy + vz*vz;
		}
		
		/**
		 *	返回参数向量与此向量所成夹角
		 */
		public function getNip(d:DVector):Number
		{
			var r1:Number = vx*vx + vy*vy + vz*vz;
			var r2:Number = d.vx*d.vx + d.vy*d.vy + d.vz*d.vz;
			var r3:Number = (vx-d.vx)*(vx-d.vx) + (vy-d.vy)*(vy-d.vy) + (vz-d.vz)*(vz-d.vz)
			
			return (r1+r2-r3)/(2*Math.sqrt(r1*r2));
		}
		
		public function set X(vx:Number):void
		{
			this.vx = vx;
			if(ak != null)
				ak.vy = vx;
		}
		
		public function set Y(vy:Number):void
		{
			this.vy = vy;
			if(ak != null)
				ak.vx = -vy;
		}
		
		public function set Z(vz:Number):void
		{
			this.vz = vz;
		}
		
		public function get X():Number
		{
			return this.vx;
		}
		
		public function get Y():Number
		{
			return this.vy;
		}
		
		public function get Z():Number
		{
			return this.vz;
		}
	}
}