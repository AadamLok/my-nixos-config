{ pkgs, ... }:
{
	programs.waybar = {
		enable = true;
		settings = {
			mainbar = {
				layer = "top";
				position = "top";
				margin = "8 20 0 20";
				modules-left = [
					"hyprland/workspaces"
				];
				modules-center = [
					"clock"
				];
				modules-right = [
					"pulseaudio"
					"memory"
					"cpu"
					"battery"
					"tray"
				];

				"hyprland/workspaces" = {
					disable-scroll = true;
					format = "{name} {icon}";
					format-icons = {
						active =  " ";
						default = " ";
					};
					persistent_workspaces = {
						"1" = [];
						"2" = [];
						"3" = [];
						"4" = [];
						"5" = [];
					};
				};
				
				"pulseaudio" = {
					reverse-scrolling = 1;
					format = "{volume}% {icon} {format_source}";
					format-bluetooth = "{volume}% {icon} {format_source}";
					format-bluetooth-muted = " {icon} {format_source}";
					format-muted = " {format_source}";
					format-source = "{volume}% ";
					format-source-muted = "";
					format-icons = {
						headphone = "";
						default = [
							""
							""
						];
					};
					on-click = "pavucontrol";
					min-length = 13;
				};

				"memory" = {
					format = "{percentage}% ";
				};

				"clock" = {
					timezone = "America/New_York";
        				tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
					format =  "{:%a, %d %b, %I:%M %p}";
				};
				"cpu" = {
					interval = 5;
					format = "{usage:2}% {icon}";
					format-icons = [
						""
						""
						""
						""
						""
						""
					];
				};
				battery = {
					states = {
						good = 95;
						warning = 30;
						critical = 15;
					};
					format = "{capacity}% {icon}";
					format-charging = "{capacity}% ";
					format-plugged = "{capacity}% ";
					format-alt = "{time} {icon}";
					format-icons = [
						""
						""
						""
						""
						""	
					];
				};
				tray = {
					icon-size = 16;
					spacing = 0;
				};
			};
		};
		style = ''
			* {
				border: none;
				border-radius: 0;
				/* `otf-font-awesome` is required to be installed for icons */
				font-family: Liberation Mono, "Font Awesome 6 Free";
				min-height: 20px;
			}

			window#waybar {
				background: transparent;
			}

			window#waybar.hidden {
				opacity: 0.2;
			}

			#workspaces {
				margin-right: 8px;
				border-radius: 10px;
				transition: none;
				background: #383c4a;
			}

			#workspaces button {
				transition: none;
				color: #7c818c;
				background: transparent;
				padding: 5px;
				font-size: 18px;
			}

			#workspaces button.persistent {
				color: #7c818c;
				font-size: 12px;
			}

			/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
			#workspaces button:hover {
				transition: none;
				box-shadow: inherit;
				text-shadow: inherit;
				border-radius: inherit;
				color: #383c4a;
				background: #7c818c;
			}

			#workspaces button.focused {
				color: white;
			}

			#clock {
				padding-left: 16px;
				padding-right: 16px;
				border-radius: 10px 10px 10px 10px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

			#pulseaudio {
				margin-right: 8px;
				padding-left: 16px;
				padding-right: 16px;
				border-radius: 10px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

			#pulseaudio.muted {
				background-color: #90b1b1;
				color: #2a5c45;
			}

			#memory {
				margin-right: 8px;
				padding-left: 16px;
				padding-right: 16px;
				border-radius: 10px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

			#cpu {
				margin-right: 8px;
				padding-left: 16px;
				padding-right: 16px;
				border-radius: 10px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

			#battery {
				margin-right: 8px;
				padding-left: 16px;
				padding-right: 16px;
				border-radius: 10px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

			#battery.charging {
				color: #ffffff;
				background-color: #26A65B;
			}

			#battery.warning:not(.charging) {
				background-color: #ffbe61;
				color: black;
			}

			#battery.critical:not(.charging) {
				background-color: #f53c3c;
				color: #ffffff;
				animation-name: blink;
				animation-duration: 0.5s;
				animation-timing-function: linear;
				animation-iteration-count: infinite;
				animation-direction: alternate;
			}

			#tray {
				padding-left: 16px;
				padding-right: 16px;
				border-radius: 10px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

			@keyframes blink {
				to {
					background-color: #ffffff;
					color: #000000;
				}
			}
		'';
	};
}
