package
{
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Test extends MovieClip
	{
		private var houxuan:Array = new Array;
		private var rightNumber:int = 0;
		private var wrongNumber:int = 0;
		private var isCanCue:Boolean  = true;
		
		public function Test()
		{
			makeNumber();
			input.addEventListener(InputBoard.V, handleInputV);
			input.addEventListener(InputBoard.S, handleInputS);
			input.addEventListener(InputBoard.N, handleInputN);
		}
		
		
		private function makeNumber():void
		{
			var a = int(Math.random() * 13 + 1);
			var b = int(Math.random() * 13 + 1);
			var c = int(Math.random() * 13 + 1);
			var d = int(Math.random() * 13 + 1);
			houxuan = [a, b, c, d];
			input.Hou = houxuan.concat();
		}
		
		private function handleInputV(event:Event):void		//查看结果
		{
			var r:Array = Validate.getGameResult(houxuan);
	
			if(r.length == 0)	result.text = "没有答案";
			else	result.text = r.toString();
			isCanCue = false;
		}
		
		private function handleInputS(event:Event):void		//提交校验
		{
			if(!isCanCue) return ;
			
			var r:Array = Validate.getGameResult(houxuan);
			var sta:Array = input.Statement;
			trace(r);
			if(r.length == 0)	
			{
				if(sta.length == 0)
				{
					result.text = "回答正确,没有答案";
					rightNumber++;
					right.text = rightNumber.toString();
				}
				else
				{
					result.text = "回答错误,应该没有答案的";
					wrong.text = (++wrongNumber).toString();
				}
			}
			else
			{
				if(sta.length == 0)
				{
					if(r.length == 0)
					{
						result.text = "回答正确,没有答案";
						rightNumber++;
						right.text = rightNumber.toString();
					}
				}
				var jieguo:int = Validate.getResult([sta[0], sta[2], sta[4], sta[6]], [sta[1], sta[3], sta[5]]);
				if(jieguo == 24)
				{
					result.text = "回答正确";
					rightNumber++;
					right.text = rightNumber.toString();
				}else
				{
					result.text = "回答错误";
					wrong.text = (++wrongNumber).toString();
				}
			}
			
			isCanCue = false;
		}
		
		private function handleInputN(event:Event):void		//重新游戏
		{
			makeNumber();
			result.text = "";
			isCanCue = true;
		}
	}
}