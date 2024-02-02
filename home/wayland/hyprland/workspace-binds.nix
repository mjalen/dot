# Default Workspace Bindings


# [[file:../../../Config.org::*Default Workspace Bindings][Default Workspace Bindings:1]]
(
	builtins.concatLists (builtins.genList (
		x: let 
			ws = let
				c = (x+1) / 10;
			in
				builtins.toString (x + 1 - (c * 10));
		in [
			"$mod, ${ws}, workspace, ${toString (x+1)}"
			"$mod SHIFT, ${ws}, movetoworkspace, ${toString (x+1)}"
		]
	) 10)
)
# Default Workspace Bindings:1 ends here
