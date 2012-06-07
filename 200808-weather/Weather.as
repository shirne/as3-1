package
{
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	public class Weather extends Sprite
	{
		protected var m_bIsRun:Boolean;
		protected var m_lScreenWidth:Number;
		protected var m_lScreenHeight:Number;
		protected var m_lAppWidth:Number;
		protected var m_lAppHeight:Number;
		protected var m_lOldTime:Number;
		protected var m_lNewTime:Number;
		protected var m_lTimeSpeed:Number;
		protected var m_lNumber:Number;
	
		protected var m_listObject:Array = new Array;

		public function Weather()
		{
			m_bIsRun = true;
			m_lScreenWidth = 800;
			m_lScreenHeight = 600;
			m_lAppWidth = 800;
			m_lAppHeight = 600;

			m_lNewTime = getTimer();
			m_lOldTime = m_lNewTime;
			m_lTimeSpeed = 30;
		}
		public function Left(value:Number):void
		{
			if(m_listObject.length != 0)
			{
				for(var i:int = 0; i < m_listObject.length;i ++)
				{
					m_listObject[i].nX -= value;
					if(m_listObject[i].nX < 0)
					{
						m_listObject[i].nX = m_lAppWidth - 1;
					}
				}
			}
		}
		public function Right(value:Number):void
		{
			if(m_listObject.length != 0)
			{
				for(var i:int = 0; i < m_listObject.length;i ++)
				{
					m_listObject[i].nX += value;
					if( m_listObject[i].nX >= (m_lAppWidth+1) )
					{
						m_listObject[i].nX = 0;
					}
				}
			}
		}

		public function SetScreen(lWidth:Number, lHeight:Number):void
		{
			m_lScreenWidth = lWidth; 
			m_lScreenHeight = lHeight;
		}

		public function SetApp(lWidth:Number, lHeight:Number):void
		{
			m_lAppWidth = lWidth;
			m_lAppHeight = lHeight;
		}
		
		public function SetTimeSpeed(lValue:Number):void
		{
			m_lTimeSpeed = lValue;
		}
	
		public function Begin():void
		{
			m_bIsRun = true;
		}
		
		public function Stop():void
		{
			m_bIsRun = false;
		}
		
		public function Clear():void
		{
			if(m_listObject.length != 0)
			{
				for(var i:int = 0; i < m_listObject.length; i ++)
				{
					m_listObject[i] = null;
				}
				m_listObject = new Array;
			}
		}
		
		public function GetStauts():Boolean
		{
			return m_bIsRun;
		}
			
		public function SetNumber(lValue:Number):void
		{
			return;
		}
		public function GetNumber():Number
		{
			return m_lNumber;
		}
		
		public function Show(xpos:int, ypos:int):Boolean
		{
			m_lNewTime = getTimer();
			
			if((m_lNewTime - m_lOldTime) > m_lTimeSpeed)
			{
				m_lOldTime = m_lNewTime;
				return true;
			}
			else
			{
				return false;
			}
		}

		public function Initialize():Boolean
		{
			return true;
		}
	}
}
