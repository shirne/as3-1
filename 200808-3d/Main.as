package
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import dzw.data.*;
	import flash.geom.Point;
	import dzw.base.*;
	import Fps.Fps;

	//测试文件 
	
	public class Main extends Sprite
	{
		var r:Weather;
		private var eye:Line = null;
		private var aspect:DVector = new DVector(-300,0, 0);
		private var point:DPoint = new DPoint(300, 0,0);
		private var oldTime:Number = 0;
		var d:DSprite;
		//private var showFps
		private var modelArr:Array = new Array;
		private var isDownMouse:Boolean = false;
		private var firstPoint:Point = new Point;
		
		
		public function Main()
		{
			r = new Snow();
			addChild(r);
			var f:Fps = new Fps;
			addChild(f);
			
			eye = new Line(aspect, point);
			
			d = new DSprite("airplane4 2.x");

			var d1:DSprite = new DSprite("airplane 2.x");
			addChild(d1);
			modelArr.push(d1);
			
			var d10:DSprite = new DSprite("tiger.x");
			addChild(d10);
			modelArr.push(d10);
			
			var d6:DSprite = new DSprite("airplane 2.x");
			addChild(d6);
			modelArr.push(d6);
			
			var d7:DSprite = new DSprite("airplane 2.x");
			addChild(d7);
			modelArr.push(d7);
			
			var d9:DSprite = new DSprite("airplane 2.x");
			addChild(d9);
			modelArr.push(d9);
			
			var d17:DSprite = new DSprite("tiger.x");
			addChild(d17);
			modelArr.push(d17);
			/*var d2:DSprite = new DSprite("airplane 2.x");
			addChild(d2);
			modelArr.push(d2);
			
			
			var d3:DSprite = new DSprite("airplane 2.x");
			addChild(d3);
			modelArr.push(d3);
			
			var d4:DSprite = new DSprite("airplane 2.x");
			addChild(d4);
			modelArr.push(d4);
			
			var d5:DSprite = new DSprite("airplane 2.x");
			addChild(d5);
			modelArr.push(d5);
			
			
			
			var d8:DSprite = new DSprite("airplane 2.x");
			addChild(d8);
			modelArr.push(d8);
			
			var d9:DSprite = new DSprite("airplane 2.x");
			addChild(d9);
			modelArr.push(d9);
			
			var d10:DSprite = new DSprite("tiger.x");
			addChild(d10);
			modelArr.push(d10);*/
			/*
			var d11:DSprite = new DSprite("tiger.x");
			addChild(d11);
			modelArr.push(d11);
			
			var d12:DSprite = new DSprite("tiger.x");
			addChild(d12);
			modelArr.push(d12);
			
			var d13:DSprite = new DSprite("tiger.x");
			addChild(d13);
			modelArr.push(d13);
			
			var d14:DSprite = new DSprite("tiny.x");
			addChild(d14);
			modelArr.push(d14);
			
			var d15:DSprite = new DSprite("tiny.x");
			addChild(d15);
			modelArr.push(d15);*/
			
			
			initEsprite();
			addChild(d);
			modelArr.push(d);
			//oldTime = getTimer();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDownKey);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onDownMouse);
			stage.addEventListener(MouseEvent.MOUSE_UP, onUpMouse);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMoveMouse);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheelMouse);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onWheelMouse(event:MouseEvent):void
		{
			point.X = point.X - event.delta * 5;
		}
		
		private function onDownMouse(event:MouseEvent):void
		{
			isDownMouse = true;
			firstPoint.x = mouseX;
			firstPoint.y = mouseY;
		}
		
		private function onMoveMouse(event:MouseEvent):void
		{
			if(isDownMouse)
			{
				var tempX:Number = (mouseX - firstPoint.x) % point.X;
				var tempY:Number = (mouseY - firstPoint.y) % point.X;
				var distance:Number = Math.sqrt(tempX * tempX + tempY * tempY);
				var cos:Number = Math.asin(tempX / point.X);
				var sin:Number = Math.asin(tempY / point.X);
				for(var i:int = 0; i < modelArr.length; i ++)
				{
					modelArr[i].rotateY(sin);
					modelArr[i].rotateZ(cos);
				}
			}
		}
		
		private function onUpMouse(event:MouseEvent):void
		{
			isDownMouse = false;
		}
		
		private function initEsprite():void
		{
			var points:Array = new Array;
			points[0] = new  DPoint( -50, -250, -50);
			points[1] = new  DPoint( 50, -250, -50);
			points[2] = new  DPoint( 200, 250, -50);
			points[3] = new  DPoint( 100, 250, -50);
			points[4] = new  DPoint( 50, 100, -50);
			points[5] = new  DPoint( -50, 100, -50);
			points[6] = new  DPoint(-100, 250, -50);
			points[7] = new  DPoint(-200, 250, -50);
			points[8] = new  DPoint( 0, -150, -50);
			points[9] = new  DPoint( 50, 0, -50);
			points[10] = new  DPoint( -50, 0, -50);
			points[11] = new  DPoint( -50, -250, 50);
			points[12] = new  DPoint( 50, -250, 50);
			points[13] = new  DPoint( 200, 250, 50);
			points[14] = new  DPoint( 100, 250, 50);
			points[15] = new  DPoint( 50, 100, 50);
			points[16] = new  DPoint( -50, 100, 50);
			points[17] = new  DPoint(-100, 250, 50);
			points[18] = new  DPoint(-200, 250, 50);
			points[19] = new  DPoint( 0, -150, 50);
			points[20] = new  DPoint( 50, 0, 50);
			points[21] = new  DPoint( -50, 0, 50);
			var triangles:Array = new Array;
			triangles[0] =new Triangle(points[0], points[1], points[8], 0xFF6666cc);
			triangles[1] =new Triangle(points[1], points[9], points[8], 0xFF6666cc);
			triangles[2] =new Triangle(points[1], points[2], points[9], 0xFf6666cc);
			triangles[3] =new Triangle(points[2], points[4], points[9], 0xFf6666cc);
			triangles[4] =new Triangle(points[2], points[3], points[4], 0xFF6666cc);
			triangles[5] =new Triangle(points[4], points[5], points[9], 0xFF6666cc);
			triangles[6] =new Triangle(points[9], points[5], points[10], 0xFF6666cc);
			triangles[7] =new Triangle(points[5], points[6], points[7], 0xFF6666cc);
			triangles[8] =new Triangle(points[5], points[7], points[10], 0xFF6666cc);
			triangles[9] =new Triangle(points[0], points[10], points[7], 0xFF6666cc);
			triangles[10] = new Triangle(points[0], points[8], points[10], 0xFF6666cc);
			triangles[11] = new Triangle(points[11], points[19], points[12], 0xFFcc6666);
			triangles[12] = new Triangle(points[12], points[19], points[20], 0xFFcc6666);
			triangles[13] = new Triangle(points[12], points[20], points[13], 0xFFcc6666);
			triangles[14] = new Triangle(points[13], points[20], points[15], 0xFFcc6666);
			triangles[15] = new Triangle(points[13], points[15], points[14], 0xFFcc6666);
			triangles[16] = new Triangle(points[15], points[20], points[16], 0xFFcc6666);
			triangles[17] = new Triangle(points[20], points[21], points[16], 0xFFcc6666);
			triangles[18] = new Triangle(points[16], points[18], points[17], 0xFFcc6666);
			triangles[19] = new Triangle(points[16], points[21], points[18], 0xFFcc6666);
			triangles[20] = new Triangle(points[11], points[18], points[21], 0xFFcc6666);
			triangles[21] = new Triangle(points[11], points[21], points[19], 0xFFcc6666);
			triangles[22] = new Triangle(points[0], points[11], points[1], 0xFFcccc66);
			triangles[23] = new Triangle(points[11], points[12], points[1], 0xFFcccc66);
			triangles[24] = new Triangle(points[1], points[12], points[2], 0xFFcccc66);
			triangles[25] = new Triangle(points[12], points[13], points[2], 0xFFcccc66);
			triangles[26] = new Triangle(points[3], points[2], points[14], 0xFFcccc66);
			triangles[27] = new Triangle(points[2], points[13], points[14], 0xFFcccc66);
			triangles[28] = new Triangle(points[4], points[3], points[15], 0xFFcccc66);
			triangles[29] = new Triangle(points[3], points[14], points[15], 0xFFcccc66);
			triangles[30] = new Triangle(points[5], points[4], points[16], 0xFFcccc66);
			triangles[31] = new Triangle(points[4], points[15], points[16], 0xFFcccc66);
			triangles[32] = new Triangle(points[6], points[5], points[17], 0xFFcccc66);
			triangles[33] = new Triangle(points[5], points[16], points[17], 0xFFcccc66);
			triangles[34] = new Triangle(points[7], points[6], points[18], 0xFFcccc66);
			triangles[35] = new Triangle(points[6], points[17], points[18], 0xFFcccc66);
			triangles[36] = new Triangle(points[0], points[7], points[11], 0xFFcccc66);
			triangles[37] = new Triangle(points[7], points[18], points[11], 0xFFcccc66);
			triangles[38] = new Triangle(points[8], points[9], points[19], 0xFFcccc66);
			triangles[39] = new Triangle(points[9], points[20], points[19], 0xFFcccc66);
			triangles[40] = new Triangle(points[9], points[10], points[20], 0xFFcccc66);
			triangles[41] = new Triangle(points[10], points[21], points[20], 0xFFcccc66);
			triangles[42] = new Triangle(points[10], points[8], points[21], 0xFFcccc66);
			triangles[43] = new Triangle(points[8], points[19], points[21], 0xFFcccc66);

			var data:Array = new Array;
			data.push(points);
			data.push(triangles);
			var esprite:ThreeSprite = new ESprite(data);
			addChild(esprite);
			modelArr.push(esprite);
			var t:CThread = new CThread(this.haha);
			t.start();
		}
		
		private function haha():void
		{
			for(var i:int = 0; i < modelArr.length; i ++)
			{
				modelArr[i].rotateY(-0.2);
				modelArr[i].rotateZ(-0.2);
			}
		}
		private function onEnterFrame(event:Event):void
		{
			r.Show(0, 0);
			for(var i:int = 0; i < modelArr.length; i ++)
			{
				//modelArr[i].rotateY(-0.2);
				//modelArr[i].rotateZ(-0.2);
				modelArr[i].render(eye);
			}
			/*for(i = 0; i < modelArr.length; i ++)
			{
				var m:Sprite = modelArr[i]
				for(var j:int = i+1; j < modelArr.length; j ++)
				{
					if(m.hitTestObject(modelArr[j]))
					{
						modelArr.splice(i, 1);
						removeChild(m);
						m = null;
						i--;
						break;
					}
				}
			}*/
			
		}
		
		private function onDownKey(event:KeyboardEvent):void
		{
			//trace(event.keyCode);
			switch (event.keyCode)
			{
				case 38:				//上
					point.X -= 20;
					/*for(var i:int = 0; i < modelArr.length; i ++)
					{
						modelArr[i].rotateY(-0.2);
					}*/
				
				break;
					
				case 40:
					point.X += 20;
					/*for( i = 0; i < modelArr.length; i ++)
					{
						modelArr[i].rotateY(0.2);
					}*/
				break;
				case 37:				//左
					point.Y += 20;
					/*for( i = 0; i < modelArr.length; i ++)
					{
						modelArr[i].rotateZ(0.2);
					}*/
					
				break;
				
				case 39:				//右
					point.Y -= 20;
					/*for( i = 0; i < modelArr.length; i ++)
					{
						modelArr[i].rotateZ(-0.2);
					}*/
					
				break;
				
				case 87:				//W
					aspect.X += 20;
				break;
				
				case 83:				//S
					aspect.X -= 20;
				break;
				
				case 65:				//A
					aspect.Y -= 20;
					/*for( i = 0; i < modelArr.length; i ++)
					{
						modelArr[i].rotateX(0.2);
					}*/
					
				break;
					
				case 68:				//D
					aspect.Y += 20;
					/*for( i = 0; i < modelArr.length; i ++)
					{
						modelArr[i].rotateX(-0.2);
					}*/
				case 32:
					point.Z += 20;
				break;
			}
		}
	}
}