package
{
	import fl.motion.Color;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	public class Rain extends Weather
	{
		private static var PARTICLE_SMALL_RAIN:int = 0;
		private static var PARTICLE_MIDDLE_RAIN:int = 1;
		private static var PARTICLE_BIG_RAIN:int = 2;
		
		
		private var WEATHER_RAIN_MAX_TYPE:int = 10;
		
		private var m_lRainLevel1:Number;
		private var m_lRainLevel2:Number;
		private var m_lRainLevel3:Number;
		
		private var m_lNowRainLevel1:Number;
		private var m_lNowRainLevel2:Number;
		private var m_lNowRainLevel3:Number;
		
		private var m_pBitmap:Array = new Array;
		
		public function Rain()
		{
			SetNumber(150);
			m_lNowRainLevel1 = 0;
			m_lNowRainLevel2 = 0;
			m_lNowRainLevel3 = 0;

			for(var i:int = 0; i<WEATHER_RAIN_MAX_TYPE; i++)
			{
				m_pBitmap[i] = null;
			}
			
			Initialize();
		}
		
		public override function SetNumber(lValue:Number):void
		{
			if(lValue <= 0)
				return;
				
			m_lNumber = lValue * ( (m_lAppWidth/m_lScreenWidth) * (m_lAppHeight/m_lScreenHeight) );
			m_lRainLevel1 = m_lNumber / 5 * 1;
			m_lRainLevel2 = m_lNumber / 5 * 2;
			m_lRainLevel3 = m_lNumber / 5 * 1;
		}
		
		public override function Initialize():Boolean
		{
			for(var i:int = 0; i<WEATHER_RAIN_MAX_TYPE; i++)
			{
				m_pBitmap[i] = new BitmapData(3, 10, true, 0x00FFFFFF);
			}
			
			for(i = 0; i < 6; i ++)
			{
				m_pBitmap[0].setPixel32(1, i, 0xFF969696);
			}
			for(i = 0; i < 5; i ++)
			{
				m_pBitmap[1].setPixel32(1, i, 0xFF969696);
			}
			for(i = 0; i < 8; i ++)
			{
				m_pBitmap[2].setPixel32(1, i, 0xFF969696);
			}
			for(i = 0; i < 7; i ++)
			{
				m_pBitmap[3].setPixel32(1, i, 0xFF969696);
			}
			
			for(i = 0; i < 10; i ++)
			{
				m_pBitmap[4].setPixel32(1, i, 0xFFB4B4B4);
			}
			for(i = 0; i < 9; i ++)
			{
				m_pBitmap[5].setPixel32(1, i, 0xFFB4B4B4);
			}

			return true;
		}
		
		public override function Show(xpos:int, ypos:int):Boolean
		{
			for( ; this.numChildren > 0 ; )
			{
				this.removeChildAt(0);
			}
			if(super.Show(xpos, ypos) == false)
			{
				if(m_listObject.length != 0)
				{
					for(var i:int = 0; i < m_listObject.length; i ++)
					{
						var m:Bitmap = new Bitmap(m_pBitmap[m_listObject[i].nID]);
						m.x = xpos + m_listObject[i].nX + m_listObject[i].nOffsetX;
						m.y = ypos + m_listObject[i].nY ;
						addChild(m);
					}
				}
				return true;
			}
			
			if(m_bIsRun)
			{
				for(i = 0; i < 3; i ++)
				{
					if(m_lNowRainLevel1 < m_lRainLevel1)
					{
						var p:tagParticle = new tagParticle;
						p.nID = int(Math.random() * 2);
						p.nType = PARTICLE_SMALL_RAIN;
						p.nBearing = 0;
						p.nMaxOffsetX = 0;
						p.nMaxOffsetY = 0;
						p.nOffsetX = 0;
						p.nOffsetY = 0;
						p.nSpeed = 10 + int(Math.random() * 4);
						p.nX = int(Math.random() * m_lAppWidth);
						p.nY = int(Math.random() * 50);
						p.nLife = 10 + int(Math.random() * ( m_lScreenHeight / 50 ));
						m_listObject.push(p);
						m_lNowRainLevel1++;
					}
					
					if(m_lNowRainLevel2 < m_lRainLevel2)
					{
						
						p = new tagParticle;
						p.nID = 2 +int(Math.random() * 3);
						p.nType = PARTICLE_MIDDLE_RAIN;
						p.nBearing = 0;		// 0(LEFT) or 1(RIGHT)
						p.nMaxOffsetX = 0;
						p.nMaxOffsetY = 0;
						p.nOffsetX = 0;
						p.nOffsetY = 0;
						p.nSpeed = 18 + int(Math.random() * 6);
						p.nX = int(Math.random() * m_lAppWidth)
						p.nY = int(Math.random() * 51);
						p.nLife = 15 +  int(Math.random() * ( m_lScreenHeight / 50 ));

						m_listObject.push(p);
						m_lNowRainLevel2++;
					}
					
					if(m_lNowRainLevel3 < m_lRainLevel3)
					{
						
						p = new tagParticle;
						p.nID = 4 + int(Math.random() * 3);
						p.nType = PARTICLE_BIG_RAIN;
						p.nBearing = 0;
						p.nMaxOffsetX = 0;
						p.nMaxOffsetY = 0;
						p.nOffsetX = 0;
						p.nOffsetY = 0;
						p.nSpeed = 25 + int(Math.random() * 6);
						p.nX = int(Math.random() * m_lAppWidth);
						p.nY = int(Math.random() * 51);
						p.nLife = 20 + int(Math.random() * ( m_lScreenHeight / 50 ));

						m_listObject.push(p);
						m_lNowRainLevel3++;
					}
				}
			}
			
			if(m_listObject.length != 0)
			{
				again_remove_dead:
				
				for(i = 0; i < m_listObject.length; i ++)
				{
					if(m_listObject[i].nLife <= 0)
					{
						switch(m_listObject[i].nType)
						{
							case PARTICLE_SMALL_RAIN:
								m_lNowRainLevel1--;
								break;
							case PARTICLE_MIDDLE_RAIN:
								m_lNowRainLevel2--;
								break;
							case PARTICLE_BIG_RAIN:
								m_lNowRainLevel3--;
								break;
							default:
								break;
						}
						m_listObject.splice(i, 1);
						break again_remove_dead;
					}
				}
				
				for(i = 0; i < m_listObject.length; i ++)
				{
					m_listObject[i].nLife --;
					m_listObject[i].nY += m_listObject[i].nSpeed;
					
					m = new Bitmap(m_pBitmap[m_listObject[i].nID]);
					m.x = xpos + m_listObject[i].nX + m_listObject[i].nOffsetX;
					m.y = ypos + m_listObject[i].nY ;
					addChild(m);
				}
			}
			return true;
		}
		
	}
}