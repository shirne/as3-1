package 
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class CThread
	{
		private var _threadFunc:Function;
		private var _time:Timer;
		
		public function CThread(threadFunc:Function = null, deley:Number = 20, repeatCount:int = 0)
		{
			_threadFunc = (threadFunc == null) ? function (){} : threadFunc;
			_time = new Timer(deley, repeatCount);
		}
		
		private function onTimer(event:TimerEvent):void
		{
			_threadFunc.call();
		}
		
		public function start():void
		{
			_time.addEventListener(TimerEvent.TIMER, onTimer);
			_time.start();
		}
		
		public function pause():void
		{
			_time.stop();
			_time.removeEventListener(TimerEvent.TIMER, onTimer);
		}
	}
}