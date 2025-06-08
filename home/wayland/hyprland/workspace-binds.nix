with builtins;

concatLists
  (
    genList
      (
        x:
        [
          "$mod, ${toString x}, workspace, ${toString x}"
          "$mod SHIFT, ${toString x}, movetoworkspace, ${toString x}"
        ]
      )    
      10
  )

  
