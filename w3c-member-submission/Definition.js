function paintButton() {
	function setClass(elements, display) {
		for ( var i in elements)
			try {
				elements[i].style.display = display;
			} catch (err) {
			}
	}

	var z = {
		display : null,
		control : null,
		sources : null,
		label : " LaTeX for Z notation (or press 'z')",
		toggle : function() {
			if (!this.display) {
				setClass(this.sources, "block");
				this.control.removeChild(this.control.childNodes[0]);
				this.control.appendChild(document.createTextNode("Hide"
						+ this.label));
				this.display = true;
			} else {
				setClass(this.sources, "none");
				this.control.removeChild(this.control.childNodes[0]);
				this.control.appendChild(document.createTextNode("Display"
						+ this.label));
				this.display = false;
			}
		},
		prepare : function() {
			var intro = document.getElementById("intro");
			var p = document.createElement("p");
			this.control = document.createElement("button");
			this.control.appendChild(document.createTextNode("Display"
					+ this.label));
			p.appendChild(this.control);
			intro.appendChild(p);
			this.control.addEventListener("click", function() {
				z.toggle();
			}, false);
			this.sources = document.getElementsByClassName("Z-source");
			this.display = false;
			setClass(this.sources, "none");
		}
	};

	var g = {
		display : null,
		sources : null,
		toggle : function() {
			if (!this.display) {
				setClass(this.sources, "block");
				this.display = true;
			} else {
				setClass(this.sources, "none");
				this.display = false;
			}
		},
		prepare : function() {
			this.sources = document.getElementsByClassName("math-display");
			this.display = false;
			setClass(this.sources, "none");
		}
	};

	z.prepare();
	// g.prepare();
	window.onkeypress = function(evt) {
		var code = evt.keyCode ? evt.keyCode : evt.charCode
		if (code == 90 || code == 122)
			z.toggle();
		// else if (code == 71 || code == 103)
		// g.toggle();
	}
}
