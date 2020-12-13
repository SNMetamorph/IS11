function Graph(options)
{
    options = options || {};
    var canvasId = options.id;
    var width = options.width || 640;
    var height = options.height || 480;
	var WINDOW = options.WINDOW || {};
	var callbacks = options.callbacks || {};
    var canvas;

    if (canvasId) {
        canvas = document.getElementById(canvasId);
    } else {
        canvas = document.createElement("canvas");
        document.querySelector("body").appendChild(canvas);
    }

    canvas.width = width;
	canvas.height = height;
	canvas.addEventListener('mouseup', callbacks.mouseUp);
	canvas.addEventListener('mousedown', callbacks.mouseDown);
	canvas.addEventListener('mousemove', callbacks.mouseMove);
	canvas.addEventListener('mouseout', callbacks.mouseOut);
	canvas.addEventListener('wheel', callbacks.mouseWheel);
    var ctx = canvas.getContext('2d');

    this.xs = function(x) {
        return (x - WINDOW.left) / WINDOW.width * canvas.width;
    }
    
    this.ys = function(y) {
        return canvas.height - ((y - WINDOW.bottom) / WINDOW.height * canvas.height);
    } 

	this.getUnitPixelSizeX = function() {
		return canvas.width / WINDOW.width;
	}

	this.getUnitPixelSizeY = function() {
		return canvas.height / WINDOW.height;
	}

	this.clear = function() {
        ctx.fillStyle = 'white';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
    }
	
	this.drawLine = function(x1, y1, x2, y2, color, lineWidth) {
        ctx.beginPath();
        ctx.strokeStyle = color || "black";
        ctx.lineWidth = lineWidth || 1;
        ctx.moveTo(this.xs(x1), this.ys(y1));
        ctx.lineTo(this.xs(x2), this.ys(y2));
        ctx.stroke();
    }
	
	this.drawPoint = function(x, y, color, radius) {
		ctx.beginPath();
		ctx.strokeStyle = color;
		ctx.arc(this.xs(x), this.ys(y), radius, 0, 2 * Math.PI);
		ctx.stroke();
	}

	this.drawAxes = function() {
		var textMargin = 12;
		var textSize = 12;
		var arrowLength = 25;
		var axisLineWidth = 1;
		var markupLineWidth = 0.5;

		// y-axis line & arrow
        this.drawLine(0, WINDOW.bottom, 0, WINDOW.bottom + WINDOW.height, "#222", axisLineWidth);
		this.drawArrowVert(0, WINDOW.bottom + WINDOW.height, arrowLength);

		// x-axis line & arrow
		this.drawLine(WINDOW.left, 0, WINDOW.left + WINDOW.width, 0, "#222", axisLineWidth);
		this.drawArrowHorz(WINDOW.left + WINDOW.width, 0, arrowLength);
		
		for (var i = WINDOW.bottom; i < (WINDOW.bottom + WINDOW.height); ++i) 
		{
			// horizontal lines & y-axis markup
			var lineX = WINDOW.left;
			var lineY = Math.round(i);
			this.drawLine(lineX, lineY, lineX + WINDOW.width, lineY, "#666", markupLineWidth); 
			this.drawText(0, lineY, i.toFixed(0), textSize, 0, textMargin);
		}
		
		for (var i = WINDOW.left; i < (WINDOW.left + WINDOW.width); ++i) 
		{
			// vertical line & x-axis markup
			var lineX = Math.round(i);
			var lineY = WINDOW.bottom;
			this.drawLine(lineX, lineY, lineX, lineY + WINDOW.height, "#666", markupLineWidth);
			this.drawText(lineX, 0, i.toFixed(0), textSize, textMargin);
		}
    }
	
	this.drawArrowVert = function(x, y, length) {
		ctx.fillStyle = "black";
		ctx.beginPath();
		ctx.moveTo(this.xs(x) - length / 6, this.ys(y) + length);
		ctx.lineTo(this.xs(x) + length / 6, this.ys(y) + length);
		ctx.lineTo(this.xs(x), this.ys(y));
		ctx.fill();
	}
	
	this.drawArrowHorz = function(x, y, length) {
		ctx.fillStyle = "black";
		ctx.beginPath();
		ctx.moveTo(this.xs(x) - length, this.ys(y) - length / 6);
		ctx.lineTo(this.xs(x) - length, this.ys(y) + length / 6);
		ctx.lineTo(this.xs(x), this.ys(y));
		ctx.fill();
	}
	
	this.drawPolygon = function(points, color) {
		ctx.fillStyle = color || "#ff880055";
		ctx.beginPath();
		ctx.moveTo(this.xs(points[0].x), this.ys(points[0].y));
		for (var i = 1; i < points.length; ++i) {
			ctx.lineTo(this.xs(points[i].x), this.ys(points[i].y));
		}
		ctx.lineTo(this.xs(points[0].x), this.ys(points[0].y));
		ctx.closePath();
		ctx.fill();
	}

	this.drawText = function(x, y, text, textSize, marginUp = 0, marginRight = 0, color, addStroke = false) {
		this.drawTextPx(this.xs(x), this.ys(y), text, textSize, marginUp, marginRight, color, addStroke);
	}
	
	this.drawTextPx = function(x, y, text, textSize, marginUp = 0, marginRight = 0, color, addStroke) {
		ctx.fillStyle = color || "black";
		ctx.strokeStyle = "black";
		ctx.lineWidth = 0.5;
		ctx.textAlign = "center";
		ctx.textBaseline = "middle";
		ctx.font = (textSize || 12) + "px Consolas";
		ctx.fillText(text, x + marginRight, y - marginUp); 
		
		if (addStroke) {
			ctx.strokeText(text, x + marginRight, y - marginUp); 
		}
	}

	this.drawArc = function(x, y, radius, startAngle, endAngle) {
		ctx.strokeStyle = "blue";
		ctx.lineWidth = 2;
		ctx.beginPath();
		ctx.arc(this.xs(x), this.ys(y), radius, startAngle, (2 * Math.PI) - endAngle, true);
		ctx.stroke();
	}
}
