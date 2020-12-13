window.onload = function() 
{
    var funcs = [];
    const WINDOW = {
        left: -10,
        bottom: -10,
        width: 20,
        height: 20
    }
    var graph = new Graph({
        id: "canvas",
        width: 800, 
        height: 800,
        WINDOW,
        callbacks: {
            mouseUp,
            mouseDown,
            mouseMove,
            mouseWheel,
            mouseOut
        }
    });
    var ui = new UI({
        callbacks: {
            enterFunction,
            removeFunction,
            setIntegral
        }
    });
    var canDragGraph = false;
    var mouseX = 0;

    function mouseWheel(event) {
        var zoomStep = 1;
        var delta = event.deltaY > 0 ? zoomStep : -zoomStep;
        if (WINDOW.width + delta > 0)
        {
            WINDOW.width += delta;
            WINDOW.height += delta;
            WINDOW.left -= delta / 2;
            WINDOW.bottom -= delta / 2;
        }
        render();
    }

    function mouseMove(event) {
        if (canDragGraph)
        {
            WINDOW.left += -event.movementX / graph.getUnitPixelSizeX();
            WINDOW.bottom += event.movementY / graph.getUnitPixelSizeY();
        }
        mouseX = WINDOW.left + (event.offsetX / graph.getUnitPixelSizeX());
        render();
    }

    function mouseDown() {
        canDragGraph = true;
    }

    function mouseUp() {
        canDragGraph = false;
    }

    function mouseOut() {
        canDragGraph = false;
    }

	function findFuncZero(func, start, end, eps = 0.01) {
		var x;
		var a = start;
		var b = end;
		eps *= 2; 
		while (Math.abs(a - b) > eps)
		{
			x = (a + b) / 2;
			if (func(a) * func(x) < 0) {
                b = x;
            }
			else {
                a = x;
            }
		}
		x = (a + b) / 2;
		if (Math.abs(func(x) - 0) > eps)
			return null;
		else
			return x;
	}

    function markFuncZeros(func, a, b) {
		var iterCount = 10;
		var delta = Math.abs(b - a) / iterCount;
		var startX = a;
		for (var i = 0; i < iterCount; ++i)
		{
			var endX = startX + delta;
			var zeroX = findFuncZero(func, startX, endX, 0.001);
			if (zeroX != null) {
				graph.drawPoint(zeroX, func(zeroX), "red", 1);
			}
			startX = endX;
		}
	}

    function getTangentFunc(f)
    {
        return function(x) {
            var x0 = mouseX;
            var k = getDerivative(f, x0);
            var b = f(x0);
            return k * (x - x0) + b;
        }
    }

    function getTangentIntersectX(f)
    {
        var x0 = mouseX;
        var k = getDerivative(f, x0);
        var b = f(x0);
        return -b / k + x0; 
    }

    function getDerivative(func, x)
    {
        var deltaX = 0.001;
        var deltaY = func(x + deltaX) - func(x);
        return deltaY / deltaX;
    }

    function calcIntegral(f, a, b) {
        var dx = (b - a) / 1000;
        var x = a;
        var sum = 0;
        while (x <= b) {
            sum += (Math.abs(f(x)) + Math.abs(f(x + dx))) / 2 * dx;
            x += dx;
        }
        return sum;
    }

    function enterFunction(func, num, color, width) {
        funcs[num] = {
            func,
            color,
            width
        };
        render();
    }

    function removeFunction(num) {
        funcs[num] = null;
        render();
    }

    function setIntegral(isChecked, num) {
        if (funcs[num]) {
            funcs[num].integral = isChecked;
            render();
        }
    }

    function drawFuncGraph(func, color, lineWidth, subdivCount = 1000) {
		var startX = WINDOW.left;
		var deltaX = WINDOW.width / subdivCount;
		for (var i = 0; i < subdivCount - 1; ++i)
		{
			var x = startX + deltaX * i;
			graph.drawLine(x, func(x), x + deltaX, func(x + deltaX), color, lineWidth);
		}
	}

    function drawFuncIntegral(f) {
        const values = ui.getAB();
        const a = values.a;
        const b = values.b;
		const divCount = 100;
		
        if (!isNaN(a) && !isNaN(b) && a != b) 
        {
            if (a > b) 
            {
                var tmp = b;
                b = a;
                a = temp;
            }
            var dx = (b - a) / divCount;
            var x = a;
            var points = [];
            points.push({x: a, y: 0});
            while (x <= b) {
                points.push({x, y: f(x)});
                x += dx;
            }
            points.push({x: b, y: 0});
            graph.drawPolygon(points);
        }
    }

	function drawDerivAngle(intersectX, derValue)
	{
		var arcAngle = Math.atan(derValue);
		var text = "tg a = " + derValue.toFixed(2);
		
		if (arcAngle < 0)
			arcAngle -= Math.PI;

		graph.drawText(intersectX, 0, text, 12, 25, 0, "#7b917b", true);
		graph.drawArc(intersectX, 0, 25, 0, arcAngle);
	}
	
    function render() {
        graph.clear();
        graph.drawAxes();
        
        for (var i = 0; i < funcs.length; ++i)
        {
            if (funcs[i]) {
                drawFuncGraph(funcs[i].func, funcs[i].color, funcs[i].width);
                drawFuncGraph(getTangentFunc(funcs[i].func), "green", funcs[i].width);

                if (funcs[i].integral) {
                    drawFuncIntegral(funcs[i].func);
                }

                var intersectX = getTangentIntersectX(funcs[i].func);
				drawDerivAngle(intersectX, getDerivative(funcs[i].func, mouseX));
                markFuncZeros(funcs[i].func, 0, 4);
            }
        }
    }
    render();
}
