var numberField;

window.onload = function() {
    var numbers = document.getElementsByClassName('number');
    numberField = document.getElementById('numberField');

    for (var i = 0; i < numbers.length; i++)
    {
        numbers[i].addEventListener('click', function() { 
            if (numberField.value === "0") {
                numberField.value = this.innerHTML;
            } 
            else {
                numberField.value += this.innerHTML;
            }
        });
    }

    var value = 0;
    var operand;
    var operands = document.getElementsByClassName('operand');
    for (var i = 0; i < operands.length; i++)
    {
        operands[i].addEventListener('click', function() {
            switch (this.innerHTML) {
                case '+':
                    value = numberField.value - 0;
                    numberField.value = 0;
                    operand = '+';
                    break;
                case '-':
                    value = numberField.value - 0;
                    numberField.value = 0;
                    operand = '-';
                    break;
                case '*':
                    value = numberField.value - 0;
                    numberField.value = 0;
                    operand = '*';
                    break;
                case '/':
                    value = numberField.value - 0;
                    numberField.value = 0;
                    operand = '/';
                    break;
                case '.':
                    numberField.value += '.';
                    break;
                case '**':
                    value = numberField.value - 0;
                    numberField.value = 0;
                    operand = '**';
                    break;
                case '±':
                    operand = '±';
                    numberField.value = (numberField.value - 0) * -1;
                    break;
                case 'SIN':
                    value = numberField.value - 0;
                    numberField.value = Math.sin(value);
                    break;
                case 'COS':
                    value = numberField.value - 0;
                    numberField.value = Math.cos(value);
                    break;
                case 'ABS':
                    value = numberField.value - 0;
                    numberField.value = Math.abs(value);
                    break;
                case 'SQRT':
                    value = numberField.value - 0;
                    numberField.value = Math.sqrt(value);
                    break;
                case 'SQRTN':
                    value = numberField.value - 0;
                    numberField.value = 0;
                    operand = 'SQRTN';
                    break;
                case 'HEX':
                    value = numberField.value - 0;
                    numberField.value = value.toString(16).toUpperCase();
                    break;
                case 'DEC':
                    value = numberField.value - 0;
                    numberField.value = value.toString(10).toUpperCase();
                    break;
                case 'OCT':
                    value = numberField.value - 0;
                    numberField.value = value.toString(8).toUpperCase();
                    break;
                case 'BIN':
                    value = numberField.value - 0;
                    numberField.value = value.toString(2).toUpperCase();
                    break;
                case '=':
                    var value2 = numberField.value - 0;
                    if (operand === '+') {
                        numberField.value = value + value2;
                    }
                    else if (operand === '-') {
                        numberField.value = value - value2;
                    }
                    else if (operand === '*') {
                        numberField.value = value * value2;
                    }
                    else if (operand === '/') {
                        numberField.value = value / value2;
                    }
                    else if (operand === '**') {
                        numberField.value = Math.pow(value, value2);
                    }
                    else if (operand === 'SQRTN') {
                        numberField.value = Math.pow(value, 1.0 / value2);
                    }
            }
        });
    }

    document.getElementById("clear").addEventListener('click', function() {
        numberField.value = 0;
    });
}