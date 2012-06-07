package {

	/**
	 *	全排列
	 */
	public class Node {

		private var nowValue:*;
		private var childArr:Array = new Array;

		public static function getResult(sourceArr:Array):Array {
			var result:Array = new Array;
			for (var i:int = 0; i < sourceArr.length; i ++) {
				var tempArray:Array = sourceArr.concat();
				var temp:* = tempArray[i];
				tempArray.splice(i , 1);
				var n:Node = new Node(temp, tempArray);
				var t:Array = n.Data;
				for (var j:int = 0; j < t.length; j ++) {
					result.push(t[j]);
				}
			}
			return result;
		}
		public function Node(nowValue:*, value:Array) {

			this.nowValue = nowValue;

			if (value.length == 0) {
				return;
			}

			for (var i:int = 0; i < value.length; i ++) {

				var tempArray:Array = value.concat();
				var temp:* = value[i];
				tempArray.splice(i , 1);
				childArr.push(new Node(temp, tempArray));
			}
		}
		public function get Data():Array {

			var result:Array = new Array;

			if (childArr.length == 0) {
				result.push([nowValue]);
				return result;
			}
			for (var i:int = 0; i < childArr.length; i ++) {
				var tempArr:Array = [nowValue];

				var tempRes:Array = childArr[i].Data;

				for (var j:int = 0; j < tempRes.length; j ++) {
					for (var p:int = 0; p< tempRes[j].length; p ++) {
						tempArr.push(tempRes[j][p]);
					}
					result.push(tempArr.concat());
					tempArr = [nowValue];
				}
			}
			return result;
		}
	}
}