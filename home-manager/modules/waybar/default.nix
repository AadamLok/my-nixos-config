{ pkgs, ... }:
let
	wofi-power = pkgs.pkgs.writeShellScriptBin "wofi-power" ''
		entries = "⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⏻ Shutdown"

		selected=$(echo -e "⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⏻ Shutdown" | wofi -i --dmenu | awk '{print tolower($2)}')
		
		case $selected in
			logout)
				notify-send -u normal "Loging Out!"
				exec hyprctl dispatch exit;;
			suspend)
				notify-send -u normal "Going to sleep!"
				exec systemctl suspend;;
			reboot)
				notify-send -u normal "Starting Reboot!"
				exec systemctl reboot;;
			shutdown)
				notify-send -u normal "See you later my friend!"
				exec systemctl poweroff -i;;
		esac
	'';

	quotes = pkgs.stdenvNoCC.mkDerivation {
		name = "quotes";
		src = ./quotes;
		propagatedBuildInputs = [
			(pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
				# packages to install
			]))
		];
		dontUnpack = true;
		installPhase = ''install -Dm755 $src/quotes.py $out/bin/quotes'';
		postInstall = ''cp -vr $src/. $out'';
	};
in
{
	programs.waybar = {
		enable = true;
		settings = {
			mainbar = {
				layer = "top";
				position = "top";
				margin = "4 10 0 10";
				modules-left = [
					"hyprland/workspaces"
					"wlr/taskbar"
				];
				modules-center = [
					"clock"
				];
				modules-right = [
					"pulseaudio"
					"backlight"
					"memory"
					"cpu"
					"battery"
					"custom/power"
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


				"wlr/taskbar" = {
					format = "{icon}";
					icon-size = 14;
					icon-theme = "Numix-Circle";
					tooltip-format = "{title}";
					on-click = "activate";
					on-click-middle = "close";
					ignore-list = [
						
					];
				};
				
				"pulseaudio" = {
					reverse-scrolling = 1;
					format = "{volume}% {icon} {format_source}";
					format-bluetooth = "{volume}% {icon} {format_source}";
					format-bluetooth-muted = " {icon} {format_source}";
					format-muted = " {format_source}";
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
				};

				"backlight" = {
					device = "intel_backlight";
					format = "{percent}% {icon}";
					format-icons = [
						""
						""
					];
				};

				"memory" = {
					format = "{percentage}% ";
				};

				"clock" = {
					#timezone = "America/New_York";
        				tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
					format =  "{:%a, %d %b, %I:%M %p}";
				};
				"cpu" = {
					interval = 5;
					format = "{usage:2}% {icon}";
					format-icons = [
						"▁"
						"▂"
						"▃"
						"▄"
						"▅"
						"▆"
						"▇"
						"█"
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

				"custom/power" = {
					format = "";
					on-click = ''${wofi-power}/bin/wofi-power'';
				};

			};

			bottombar = {
				layer = "bottom";
				position = "bottom";
				exclusive = false;
				margin = "0 0 12 0";
				modules-left = [];
				modules-center = ["custom/splash"];
				modules-right = [];

				"custom/splash" = {
					exec = ''${quotes}/bin/quotes''; #"hyprctl splash";
					interval = "once";
					tooltip = false;
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
				margin-right: 4px;
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
			
			#taskbar {
				border-radius: 10px;
				background: #383c4a;
			}

			#clock {
				padding-left: 8px;
				padding-right: 8px;
				border-radius: 10px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

			#custom-touchscreen {
				margin-right: 4px;
				padding-left: 8px;
				padding-right: 8px;
				border-radius: 10px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

			#pulseaudio {
				margin-right: 4px;
				padding-left: 8px;
				padding-right: 8px;
				border-radius: 10px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

			#pulseaudio.muted {
				background-color: #90b1b1;
				color: #2a5c45;
			}

			#backlight {
				margin-right: 4px;
				padding-left: 8px;
				padding-right: 8px;
				border-radius: 10px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

			#memory {
				margin-right: 0px;
				padding-left: 8px;
				padding-right: 4px;
				border-radius: 10px 0px 0px 10px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

			#cpu {
				margin-right: 4px;
				padding-left: 4px;
				padding-right: 8px;
				border-radius: 0px 10px 10px 0px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

			#battery {
				margin-right: 4px;
				padding-left: 8px;
				padding-right: 8px;
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

			@keyframes blink {
				to {
					background-color: #ffffff;
					color: #000000;
				}
			}

			#custom-power {
				margin-right: 0px;
				padding-left: 8px;
				padding-right: 8px;
				border-radius: 10px;
				transition: none;
				color: #ffffff;
				background: #383c4a;
			}

		'';
	};
}
