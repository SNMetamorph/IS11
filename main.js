
function getArray()
{
	var arrayStr = document.getElementById("inputArray").value;
	if (arrayStr) {
		var numArray = arrayStr.trim().split(" ");
		for (var i = 0; i < numArray.length; ++i) {
			numArray[i] -= 0;
		}
		return numArray;
	}
	return [];
}

function printArray(arr)
{
	document.getElementById("inputArray").value = arr.join(" ");
}

function sortArray1()
{
	var arr = getArray();
	arr.sort(function(a, b) {
		return a - b;
	});
	printArray(arr);
}

function sortArray2()
{
	var arr = getArray();
	var arrInv = [];

	for (var i = 1; i < (arr.length + 1); ++i)
	{
		arrInv.push(arr[arr.length - i]);
	}

	printArray(arrInv);
}

function sortArray3()
{
	var arr = getArray();
	var arrOdd = [];
	var arrEven = [];

	for (var i = 0; i < arr.length; ++i)
	{
		if (arr[i] % 2 == 0) {
			arrEven.push(arr[i]);
		}
		else {
			arrOdd.push(arr[i]);
		}
	}
	printArray(arrEven.concat(arrOdd));
}

function sortArray4()
{
	var arr = getArray();
	var arrOutput = [];
	var index = 0;
	var indexInv = arr.length - 1;

	for (var i = 0; i < arr.length; ++i)
	{
		if (i % 2 == 0) {
			arrOutput[i] = arr[index];
			++index;
		} else {
			arrOutput[i] = arr[indexInv];
			--indexInv;
		}
	}

	printArray(arrOutput);
}

function sortArray5()
{
	var arr = getArray();
	var arrOutput = [];
	var evenNum = document.getElementById("evenNumInput").value - 0;

	for (var i = 0; i < arr.length; ++i)
	{
		if (arr[i] % evenNum == 0) {
			arrOutput.push(arr[i]);
		}
	}

	printArray(arrOutput);
}

document.getElementById("sortArray").addEventListener("click", sortArray1);
document.getElementById("sortArray2").addEventListener("click", sortArray2);
document.getElementById("sortArray3").addEventListener("click", sortArray3);
document.getElementById("sortArray4").addEventListener("click", sortArray4);
document.getElementById("sortArray5").addEventListener("click", sortArray5);
// д/з страница с вводом 2х векторов, кнопки для действий с векторами (+, -, скалярн. произведение, вычисление угла)
// результат выводить в 3й input
// добавить проверку что векторы должны быть одинаковой длины