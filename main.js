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
	return Math.sqrt(x * x + y * y) <= radius;
}

// квадратная мишень
function ShootRectTarget(x, y, radius)
{
	if (Math.abs(x) <= radius && Math.abs(y) <= radius)
		return true;
	else
		return false;
}

function GetElementNumber(elementId)
{
	return document.getElementById(elementId).value - 0;
}

function PrintShootResult(isSuccess)
{
	var textStatus = document.getElementById("textStatus");
	textStatus.innerHTML = (isSuccess) ? "Попал в мишень" : "Промахнулся";
}

function ShootTarget(targetFunc)
{
	var shootX 			= GetElementNumber("inputShootCoordX");
	var shootY 			= GetElementNumber("inputShootCoordY");
	var targetX 		= GetElementNumber("inputTargetCoordX");
	var targetY 		= GetElementNumber("inputTargetCoordY");
	var targetRadius 	= GetElementNumber("inputTargetRadius");

	var relX = shootX - targetX;
	var relY = shootY - targetY;
	PrintShootResult(
		targetFunc(relX, relY, targetRadius)
	);
}

document.getElementById("buttonShoot1").addEventListener("click", function() {
	ShootTarget(ShootRoundTarget);
});

document.getElementById("buttonShoot2").addEventListener("click", function() {
	ShootTarget(ShootRotRectTarget);
});

document.getElementById("buttonShoot3").addEventListener("click", function() {
	ShootTarget(ShootHyperbTarget);
});

document.getElementById("buttonShoot4").addEventListener("click", function() {
	ShootTarget(ShootRectTarget);
});
