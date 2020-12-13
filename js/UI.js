function UI(options) {
    var num = 0;
    var callbacks = options.callbacks;
    var elemToggleMenu = document.getElementById("toggleMenu");
    var elemDivMenu = document.getElementById("menu");

    function createFuncBlock() {
        var block = document.createElement("div");
        block.appendChild(createFuncInput());
        block.appendChild(createColorInput());
        block.appendChild(createWidthInput());
        block.appendChild(createRemoveButton());
        createIntegralCheckbox(block, num, "Интеграл");
        block.appendChild(document.createElement("br"));
        block.dataset.num = num;
        num++;

        block.addEventListener("keyup", function() {
            try {
                var f = null;
                var funcInput = this.childNodes[0];
                var colorInput = this.childNodes[1];
                var widthInput = this.childNodes[2];
                eval(`f = function(x) { return ${funcInput.value}; }`);
                callbacks.enterFunction(f, this.dataset.num, colorInput.value, widthInput.value);
                funcInput.style.color = "";
            }
            catch (e) {
                //console.log(e);
                funcInput.style.color = "red";
            }
        });
        return block;
    }

    function createFuncInput() {
        var input = document.createElement("input");
        input.setAttribute("placeholder", "f(x) #" + num);
        //input.classList.add("graphFuncInput");
        input.style.maxWidth = 130;
        return input;
    }

    function createColorInput() {
        var input = document.createElement("input");
        input.value = "red";
        input.placeholder = "color";
        input.classList.add("graphFuncInput");
        return input;
    }

    function createWidthInput() {
        var input = document.createElement("input");
        input.value = "2";
        input.placeholder = "width"
        input.classList.add("graphFuncInput");
        return input;
    }

    function createRemoveButton() {
        var button = document.createElement("button");
        button.innerHTML = "-";
        button.addEventListener("click", function() {
            var parentDiv = this.parentElement;
            callbacks.removeFunction(parentDiv.dataset.num);
            parentDiv.remove();
        })
        return button;
    }

    function createIntegralCheckbox(parentElement, number, text) {
        var input = document.createElement("input");
        var label = document.createElement("label");
        input.type = "checkbox";
        input.setAttribute("id", "checkbox__" + number);
        label.setAttribute("id", "checkbox__" + number);
        label.innerHTML = text;
        parentElement.appendChild(input);
        parentElement.appendChild(label);

        input.addEventListener("click", function() {
            var parentDiv = this.parentElement;
            callbacks.setIntegral(this.checked, parentDiv.dataset.num);
        });
    }

    this.getAB = function() {
        const a = document.getElementById("a").value - 0;
        const b = document.getElementById("b").value - 0;
        return {a, b}
    }

    document.getElementById("addFunction").addEventListener("click", function() {
        var divFuncs = document.getElementById("functions");
        var block = createFuncBlock();
        divFuncs.appendChild(block);
    });

    elemToggleMenu.addEventListener("click", function() {
        if (elemDivMenu.style.visibility == "visible")
            elemDivMenu.style.visibility = "hidden";
        else
            elemDivMenu.style.visibility = "visible";
    });
}

function sin(x) {
    return Math.sin(x)
}

function cos(x) {
    return Math.cos(x);
}

function tg(x) {
    return Math.tg(x);
}