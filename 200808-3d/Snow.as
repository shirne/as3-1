package
{
	import fl.motion.Color;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	public class Snow extends Weather
	{
		private static var PARTICLE_SMALL_SNOW:int = 0;
		private static var PARTICLE_MIDDLE_SNOW:int = 1;
		private static var PARTICLE_BIG_SNOW:int = 2;

		private var WEATHER_SNOW_MAX_TYPE:int = 10;
		
		private var m_lSnowLevel1:Number;
		private var m_lSnowLevel2:Number;
		private var m_lSnowLevel3:Number;
		
		private var m_lNowSnowLevel1:Number;
		private var m_lNowSnowLevel2:Number;
		private var m_lNowSnowLevel3:Number;
		
		private var m_pBitmap:Array = new Array;
		
		public function Snow()
		{
			SetNumber(150);
			m_lNowSnowLevel1 = 0;
			m_lNowSnowLevel2 = 0;
			m_lNowSnowLevel3 = 0;

			// snow graphics resource
			for(var i:int = 0; i<WEATHER_SNOW_MAX_TYPE; i++)
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

			m_lSnowLevel1 = m_lNumber / 5 * 1;
			m_lSnowLevel2 = m_lNumber / 5 * 2;
			m_lSnowLevel3 = m_lNumber / 5 * 1;
		
		}
		
		public override function Initialize():Boolean
		{
			for(var i:int = 0; i<WEATHER_SNOW_MAX_TYPE; i++)
			{
				m_pBitmap[i] = new BitmapData(3, 3, true, 0x00FFFFFF);
			}
			m_pBitmap[0].setPixel32(1, 1, 0xFFB4B4B4);
			
			m_pBitmap[1].setPixel32(1, 1, 0xFFB4B4B4);
			m_pBitmap[1].setPixel32(2, 2, 0xFFB4B4B4);
			
			m_pBitmap[2].setPixel32(1, 1, 0xFFB4B4B4);
			m_pBitmap[2].setPixel32(0, 2, 0xFFB4B4B4);
			
			m_pBitmap[3].setPixel32(0, 0, 0xFFB4B4B4);
			m_pBitmap[3].setPixel32(2, 0, 0xFFB4B4B4);
			m_pBitmap[3].setPixel32(1, 1, 0xFFB4B4B4);
			m_pBitmap[3].setPixel32(1, 2, 0xFFB4B4B4);
			
			m_pBitmap[4].setPixel32(1, 0, 0xFFB4B4B4);
			m_pBitmap[4].setPixel32(1, 1, 0xFFB4B4B4);
			m_pBitmap[4].setPixel32(0, 2, 0xFFB4B4B4);
			m_pBitmap[4].setPixel32(2, 2, 0xFFB4B4B4);
			
			m_pBitmap[5].setPixel32(1, 1, 0xFFB4B4B4);
			m_pBitmap[5].setPixel32(2, 1, 0xFFB4B4B4);
			m_pBitmap[5].setPixel32(1, 2, 0xFFB4B4B4)
			
			m_pBitmap[6].setPixel32(0, 0, 0xFFB4B4B4);
			m_pBitmap[6].setPixel32(2, 0, 0xFFB4B4B4);
			m_pBitmap[6].setPixel32(1, 1, 0xFFB4B4B4);
			m_pBitmap[6].setPixel32(0, 2, 0xFFB4B4B4);
			m_pBitmap[6].setPixel32(2, 2, 0xFFB4B4B4);
			
			m_pBitmap[7].setPixel32(0, 0, 0xFFB4B4B4);
			m_pBitmap[7].setPixel32(2, 0, 0xFFB4B4B4);
			m_pBitmap[7].setPixel32(0, 2, 0xFFB4B4B4);
			m_pBitmap[7].setPixel32(2, 2, 0xFFB4B4B4);
			m_pBitmap[7].setPixel32(1, 1, 0xFFB4B4B4);
			m_pBitmap[7].setPixel32(2, 1, 0xFFB4B4B4);
			
			m_pBitmap[8].setPixel32(1, 0, 0xFFB4B4B4);
			m_pBitmap[8].setPixel32(0, 1, 0xFFB4B4B4);
			m_pBitmap[8].setPixel32(1, 1, 0xFFB4B4B4);
			m_pBitmap[8].setPixel32(2, 1, 0xFFB4B4B4);
			m_pBitmap[8].setPixel32(1, 2, 0xFFB4B4B4);
			
			return true;
		}
		
		public override function Show(xpos:int, ypos:int):Boolean
		{
			for( ; this.numChildren > 0 ; )
			{
				this.removeChildAt(0);
			}
			
			var tempLength:int = m_listObject.length ;
			if(super.Show(xpos, ypos) == false)
			{
				if(tempLength != 0)
				{
					for(var i:int = 0; i < tempLength; i ++)
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
					if(m_lNowSnowLevel1 < m_lSnowLevel1)
					{
						var p:tagParticle = new tagParticle;
						p.nID = int(Math.random() * 3);
						p.nType = PARTICLE_SMALL_SNOW;
						p.nBearing = int(Math.random() * 2);// 0(LEFT) or 1(RIGHT)
						if(p.nBearing >= 2)
							p.nBearing = 0;
						p.nMaxOffsetX = int(Math.random() * 5);
						p.nMaxOffsetY = 0;
						p.nOffsetX = 0;
						p.nOffsetY = 0;
						p.nSpeed = 1 + int(Math.random() * 2);
						p.nX = int(Math.random() * m_lAppWidth);
						p.nY = int(Math.random() * 50);
						p.nLife = int(Math.random() * ( m_lScreenHeight / 3 ));

						m_listObject.push(p);
						m_lNowSnowLevel1++;
					}
					if(m_lNowSnowLevel2 < m_lSnowLevel2)
					{
						p = new tagParticle;
						p.nID = 3+ int(Math.random() * 3);
						p.nType = PARTICLE_MIDDLE_SNOW;
						p.nBearing = int(Math.random() * 2);// 0(LEFT) or 1(RIGHT)
						if(p.nBearing >= 2)
							p.nBearing = 0;
						p.nMaxOffsetX = int(Math.random() * 7);
						p.nMaxOffsetY = 0;
						p.nOffsetX = 0;
						p.nOffsetY = 0;
						p.nSpeed = 2 + int(Math.random() * 2);
						p.nX = int(Math.random() * m_lAppWidth);
						p.nY = int(Math.random() * 100);
						p.nLife = 20 + int(Math.random() * ( m_lScreenHeight / 4 ));

						m_listObject.push(p);
						m_lNowSnowLevel2++;
					}
					if(m_lNowSnowLevel3 < m_lSnowLevel3)
					{
						p = new tagParticle;
						p.nID = 6 + int(Math.random() * 3);
						p.nType = PARTICLE_BIG_SNOW;
						p.nBearing = int(Math.random() * 2);// 0(LEFT) or 1(RIGHT)
						if(p.nBearing >= 2)
							p.nBearing = 0;
						p.nMaxOffsetX = int(Math.random() * 12);
						p.nMaxOffsetY = 0;
						p.nOffsetX = 0;
						p.nOffsetY = 0;
						p.nSpeed = 4 + int(Math.random() * 2);
						p.nX = int(Math.random() * m_lAppWidth);
						p.nY = int(Math.random() * 100);
						p.nLife = 50 + int(Math.random() * ( m_lScreenHeight / 4 ));

						m_listObject.push(p);
						m_lNowSnowLevel3++;
					}
				}
			}
			
			tempLength = m_listObject.length ;
			if(tempLength != 0)
			{
				again_remove_dead:
				for(i = 0; i < m_listObject.length; i ++)
				{
					if(m_listObject[i].nLife <= 0)
					{
						switch(m_listObject[i].nType)
						{
							case PARTICLE_SMALL_SNOW:
							m_lNowSnowLevel1--;
							break;
							case PARTICLE_MIDDLE_SNOW:
							m_lNowSnowLevel2--;
							break;
							case PARTICLE_BIG_SNOW:
							m_lNowSnowLevel3--;
							break;
							default:
							break;
						}
						m_listObject.splice(i, 1);
						break again_remove_dead;
					}
				}
				
				tempLength = m_listObject.length ;
				
				for(i = 0; i <  tempLength; i ++)
				{
	
		 			m_listObject[i].nLife--;
					m_listObject[i].nY += m_listObject[i].nSpeed;
					switch(m_listObject[i].nBearing)
					{
						case ParticleBearing.PARTICLE_LEFT:
						{
							m_listObject[i].nOffsetX--;
							if(m_listObject[i].nOffsetX < (-m_listObject[i].nMaxOffsetX))
							m_listObject[i].nBearing = ParticleBearing.PARTICLE_RIGHT;
						}
						break;
						case ParticleBearing.PARTICLE_RIGHT:
						{
							m_listObject[i].nOffsetX++;
							if(m_listObject[i].nOffsetX > m_listObject[i].nMaxOffsetX)
							m_listObject[i].nBearing = ParticleBearing.PARTICLE_LEFT;
						}
						break;
						default:
						break;
					}
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