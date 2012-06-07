package test.demo
{
	import fl.controls.Button;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import AStar;
	import MapTileModel;
	
	public class Test extends Sprite
	{
		//加载器
		private var m_loaderRes:LoadRes;		
		//房间
		private var m_house:House;
		//物品栏
		private var m_itemsColumn;
		//数据输入输出
		private var m_tileData:TileData;		
		//所选择的物品
		private var s:*;
		//按钮(消去 || 重现)
		private var m_btnPlush:Button;
		//消去 || 重现 标志
		private var m_bPlush:Boolean;
		//时间显示文本区
		private var m_timeField:TextField;
		//角色
		private var m_player : Sprite;
		//A*算法
		private var m_AStar : AStar;
		//寻路结果
		private var m_path : Array;
		private var m_mapTileModel : MapTileModel;
		var temp_path:Array;
		var testFirstTime:Number;
		var testSecondTime:Number;
		var tempLingxing:Sprite = new Sprite;
		
		//构造函数
		public function Test()
		{
			temp_path = new Array;
			temp_path.push([0, 0]);
			testFirstTime = (new Date()).getTime();
			m_bPlush = true;
			m_loaderRes = new LoadRes();
			m_house = new House();
			m_itemsColumn = new ItemsColumn();
			
			m_loaderRes.setUrlPath("res.swf");
			m_loaderRes.startLoad();
			m_loaderRes.addEventListener(LoadRes.CLASS_LOADED, handlerLoadComplete);
			this.m_mapTileModel = new MapTileModel();
			m_player = new Sprite();
			Tile(0xFF0660);
			
			m_player.x = 100;
			m_player.y = 50;
			this.m_mapTileModel.map = m_house.getDituArray();
			
			//绘制菱形快区域
			with(tempLingxing)
			{
				graphics.lineStyle(0, 0x000000, 40);
				for(var i:uint = 0; i < 20; i ++)	{
					for(var j:int = -1; j < 20; j ++)	{
						graphics.beginFill(0xFFFFFF);
						graphics.moveTo(100+(j-i)*10+10, 50+(i+j)*5);
						graphics.lineTo(100+(j-i)*10+20, 50+(i+j)*5+5);
						graphics.lineTo(100+(j-i)*10+10, 50+(i+j)*5+10);
						graphics.lineTo(100+(j-i)*10, 50+(i+j)*5 + 5);
						graphics.lineTo(100+(j-i)*10+10, 50+(i+j)*5);
						graphics.endFill();
					}
				}
			}
			addChild(tempLingxing);
			
			tempLingxing.addEventListener( MouseEvent.CLICK, clickHandle);
		}
		
		private function getPoint(p_x : Number, p_y : Number) :void // Point
		{
			/*
			p_x = Math.floor((p_x - 100) / 10);
			p_y = Math.floor((p_y - 50) / 10);
			return new Point(p_x, p_y);
			*/
		}
		
		private function Tile(p_color : uint = 0xCCCCCC, p_w : int = 10, p_h : int = 10)
		{
			with (m_player)
			{
				/*
				lineStyle(1, 0x666666);
				beginFill(p_color);
				drawRect(0, 0, p_w, p_h);
				endFill();
				*/
				graphics.beginFill(p_color);
				graphics.lineStyle(1, 0xE71D07, 20);
				for(var i:uint = 0; i < 1; i ++)	{
					for(var j:int = -1; j < 0; j ++)	{
						graphics.moveTo((j-i)*10+10, (i+j)*5);
						graphics.lineTo((j-i)*10+20, (i+j)*5+5);
						graphics.lineTo((j-i)*10+10, (i+j)*5+10);
						graphics.lineTo((j-i)*10, (i+j)*5 + 5);
						graphics.lineTo((j-i)*10+10, (i+j)*5);
					}
				}
				graphics.endFill();
			}
		}
		
		private function clickHandle(event : MouseEvent) : void
		{
			/*
			var findPiont : Point = getPoint(this.mouseX, this.mouseY);
			var playerPoint : Point = getPoint(this.m_player.x, this.m_player.y);	*/
			
			//将鼠标点击坐标和当前人物坐标准换为正视索引
			trace(this.mouseY);
			trace(this.mouseX);
			trace(((this.mouseY-50+5)*2+(this.mouseX-100))/20);
			trace(((this.mouseY-50+5)*2-(this.mouseX-100))/20);
			var findPiont : Point = new Point( int(((this.mouseY-50+5)*2+(this.mouseX-100))/20), int(((this.mouseY-50+5)*2-(this.mouseX-100))/20));
			var playerPoint: Point = new Point( int(((this.m_player.y-50)*2+(this.m_player.x-100))/20), int(((this.m_player.y-50)*2-(this.m_player.x-100))/20));
			trace( "目的地为:" + findPiont );
			trace( "当前角色位置:" + playerPoint );
			
			this.m_AStar = new AStar(this.m_mapTileModel);
			//trace(this.m_mapTileModel.map);
			
			var my_data:Date = new Date();
			var firstTime:Number = my_data.getTime();
			trace("寻路开始时间:" + firstTime + "毫秒");
			m_path = m_AStar.find(playerPoint.x, playerPoint.y, findPiont.x, findPiont.y);
			var lastData = new Date();
			var lastTime:Number = lastData.getTime();
			trace("寻路结束时间:" + lastTime + "毫秒");
			var time:Number  =  lastTime - firstTime;//my_data.getTime();
			trace("则寻路共用时间是:" + time + "毫秒");
			m_timeField.text = "A*寻路时间:"+ time + "毫秒";
			if (m_path != null && m_path.length > 0)
			{
				
				//testtest();
				
				trace("路径已找到，正在移动");
				trace(m_path);
				//trace(temp_path);
				this.addEventListener(Event.ENTER_FRAME, enterframeHandle);
			} else
			{
				trace("无法到达");
			}
		}
		
		private function enterframeHandle(event : Event) : void
		{
			/*
			if (this.m_path == null || this.m_path.length == 0)
			{
				this.removeEventListener(Event.ENTER_FRAME, enterframeHandle);
				return;
			}
			
			var note : Array = this.m_path.shift() as Array;
			*/
			if (m_path == null || m_path.length == 0)
			{
				this.removeEventListener(Event.ENTER_FRAME, enterframeHandle);
				return;
			}
			/*
			var note : Array = m_path.shift() as Array;
			this.m_player.x = 100 + note[0] * 10;
			this.m_player.y = 50 + note[1] * 10;
			*/
			var note : Array = m_path.shift() as Array;
			this.m_player.x = 100 + (note[0]-note[1])*10;
			this.m_player.y = 50 + (note[0]+note[1])*5;
		}
		
		//资源swf加载完毕的事件处理
		public function handlerLoadComplete(event:Event):void
		{
			initHouse();
			initItemsColumn();
			m_btnPlush = new Button;
			m_btnPlush.label = "消去房间显示";
			m_btnPlush.x = 100;
			m_btnPlush.y = 360;
			addChild(m_btnPlush);
			
			m_timeField = new TextField;
			m_timeField.maxChars = 15;
			m_timeField.x = 250;
			m_timeField.y = 360;
			m_timeField.text = "A*寻路时间:"
			addChild(m_timeField);
			m_btnPlush.addEventListener(MouseEvent.CLICK, handlePlushClick);
			
			testSecondTime = (new Date()).getTime();
			trace("初始化时间为:" + (testSecondTime - testFirstTime));
			
		}
		
		//初始化房间
		private function initHouse():void
		{
			m_house.name = "house";
			m_house.x = 300;
			m_house.y = 100;
			m_house.width = 300;
			m_house.height = 300;
			//m_house.addEventListener( MouseEvent.CLICK, clickHandle);
			addChild(m_house);
			addChild(m_player);
			
		}
		
		//初始化物品栏
		private function initItemsColumn():void		
		{
			m_itemsColumn.name = "wupinlan";
			m_itemsColumn.x = 200;
			m_itemsColumn.y = 300;
			m_itemsColumn.width = 50;
			m_itemsColumn.height = 150;
			
			//侦听选择物品的事件
			m_itemsColumn.addEventListener(ItemsColumn.SELECT_ITEM, handleSelectItem);
			addChild(m_itemsColumn);
			for(var i:uint = 0; i < TileData.dataArray.length; i ++)
			{
				var item:Item = new Item(m_loaderRes.getClass(TileData.dataArray[i]) as Class, TileData.dataArray[i]);
				m_itemsColumn.addItem(item);
			}
		}
		
		//处理物品选择
		public function handleSelectItem(event:Event):void
		{
			var classStr:String = m_itemsColumn.getNowSelect();
			var tempClass:Class = m_loaderRes.getClass(classStr) as Class;
			s = new Item(tempClass, classStr);
			
			addEventListener(MouseEvent.MOUSE_UP, handleSelectUp);
			s.x = m_itemsColumn.getNowSelectPointX();
			s.y = m_itemsColumn.getNowSelectPointY();
			addChild(s);
			s.startDrag();
			addEventListener(MouseEvent.MOUSE_UP, handleSelectUp);
		}
		
		//选择物品,并拖动后,释放鼠标的处理
		public function handleSelectUp(event:MouseEvent):void
		{
			s.stopDrag();
			
			if(s.x < 400 && s.x > 100 && s.y < 350 && s.y > 50)
			{
				s.x = Math.round(s.x/10)*10;
				s.y = Math.round(s.y/10)*10
				
				if (m_house.tryAddItem(s))
				{
					trace("放入成功");
					this.m_mapTileModel.map = m_house.getDituArray();
					
					for(var i:uint = 0; i < 20; i ++)	{
						for(var j:int = -1; j < 19; j ++)	{
							if(this.m_mapTileModel.map[i][j+1] != 0)	{
								with(tempLingxing)
								{
								graphics.beginFill(0x123456);
								graphics.lineStyle(0, 0x000000, 40);
								graphics.moveTo(100+(j-i)*10+10, 50+(i+j)*5);
								graphics.lineTo(100+(j-i)*10+20, 50+(i+j)*5+5);
								graphics.lineTo(100+(j-i)*10+10, 50+(i+j)*5+10);
								graphics.lineTo(100+(j-i)*10, 50+(i+j)*5 + 5);
								graphics.lineTo(100+(j-i)*10+10, 50+(i+j)*5);
								graphics.endFill();
								}
							}
						}
					}
				}	else
				{
					trace("此位置不能放入");
					removeChild(s);
					s = null;
				}
			}
			else
			{
				removeChild(s);
				s = null;
			}
			removeEventListener(MouseEvent.MOUSE_UP, handleSelectUp);
		}
		
		//消去 && 重现 按钮点击事件处理
		private function handlePlushClick(event:MouseEvent):void
		{
			if(m_bPlush)
			{
				m_btnPlush.label = "重现房间摆设"; 
				//消去房间显示
				m_house.plushHouse();
			}
			else
			{
				m_btnPlush.label = "消去房间显示"; 
				//重现房间显示
				m_house.showHouse(m_loaderRes);
			}
			/*
			var sm:Matrix = new Matrix();
			m_house.content.transform.matrix = 
			*/
			m_house.rotation = 45;
			m_bPlush = !m_bPlush;
		}
	}
}