package
{
	public class Com {
		public static  var result:Array;
		public static  var temp:Array = new Array;
		private static  var testData:Array;
		private static  var selectNumber:int;
		
		public static function getResult(data:Array, number:int) :Array{
			result  = new Array;
			testData = data;
			selectNumber = number;
			var tempNumber:int = number -1;
			for (var i:int = 0; i < data.length; i ++) {
				add(i, tempNumber);
				temp = new Array;
			}
			return result;
		}
		private static function add(index:int, number:int):void {
			if (index > testData.length) {
				return;
			}
			temp.push(testData[index]);
			var len:int = temp.length;
			if (len == selectNumber) {
				var tempArray:Array = new Array;
				for (var i:int = 0; i < len; i ++) {
					tempArray.push(temp[i]);
				}
				result.push(tempArray);
				for (var e:int = 0; e < number; e ++) {
					temp.pop();
				}
				return;
			}
			if (number == 0) {
				return;
			}
			for (var j:int = index+1; j < testData.length; j ++) {
				tempArray = new Array;
				for (var t:int = 0; t < len; t ++) {
					tempArray.push(temp[t]);
				}
				temp = tempArray;
				add(j, number -1);
			}
		}
	}
}