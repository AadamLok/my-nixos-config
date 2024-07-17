{ config, pkgs, inputs, ... }:
{
	programs.wofi = {
		enable = true;
		settings = {
			location = "center";
			width = "60%";
			height = "40%";
			prompt = "What program do you want to run?";
			allow_images = true;
			allow_markup = true;
			matching = "fuzzy";
			insensitive = true;
			gtk_dark = true;
			halign = "fill";
			content_halign = "fill";
			key_expand = "Shift_R";
			hide_scroll = true;
		};
		style = ''
			* {
				font-family: monospace;
				font-size: 1rem;
			}

			window {
				background-color: rgba(29,29,29,0.92);
				border-radius: 10px;
				border: 2px solid rgba(51,204,255,0.92); 
			}
			
			#input {
				margin: 5px;
				border-radius: 10px;
				border: none;
				background-color: rgba(29,29,29,0.92);
				color: white;
				font-size: 1.25rem;
			}

			/* search icon */
			#input:first-child > :nth-child(1) {
				min-height: 1.25em;
				min-width: 1.25em;
			}

			/* clear icon */
			#input:first-child > :nth-child(4){
				min-height: 1.25em;
				min-width: 1.25em;
			}

			#inner-box {
				padding: 2px;
			}

			#outer-box {
				margin: 2px;
			}

			#entry {
				border-radius: 10px;
			}

			#entry:selected {
				background-color: rgba(82,145,226,0.92);
			}

			#img {
				margin-right: 5px;
			}	
		'';
	};
}
