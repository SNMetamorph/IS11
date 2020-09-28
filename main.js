// гиперболическая мишень
function ShootHyperbTarget(x, y, radius)
{
	if (x >= 0 && (y <= radius / x && y >= -radius / x)) {
		return true;
	}
	else if (x < 0 && (y <= -radius / x && y >= radius / x)) {
		return true;
	}
	return false;
}

// мишень-ромб
function ShootRotRectTarget(x, y, radius)
{
	var isRightPart = (x >= 0 && Math.abs(y) <= Math.abs(radius - x));
	var isLeftPart = (x < 0 && Math.abs(y) <= Math.abs(x + radius));
	if (isRightPart || isLeftPart)
		return true;
	else
		return false;
}

// круглая мишень
function ShootRoundTarget(x, y, radius)
{
	if (Math.sqrt(x * x + y * y) <= radius)
		return true;
	else
		return false;
}

document.getElementById("buttonShoot").addEventListener("click", function() {
	var shootX 			= document.getElementById("inputShootCoordX").value;
	var shootY 			= document.getElementById("inputShootCoordX").value;
	var targetX 		= document.getElementById("inputTargetCoordX").value;
	var targetY 		= document.getElementById("inputTargetCoordY").value;
	var targetRadius 	= document.getElementById("inputTargetRadius").value;
	var textStatus 		= document.getElementById("textStatus");

	var targetCheckFunc = ShootRoundTarget;
	var relX = shootX - targetX;
	var relY = shootY - targetY;

	if (targetCheckFunc(relX, relY, targetRadius))
		textStatus.innerHTML = "Попал в мишень";
	else
		textStatus.innerHTML = "Промахнулся";
});
