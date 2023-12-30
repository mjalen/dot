{ lib, pkgs, ... }: {

    # file to separate my vscodium configuration (vscodium is a telemetry-free vscode)
    programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        extensions = with pkgs.vscode-extensions; [
            bbenoist.nix
            ms-vscode-remote.remote-ssh
            vscodevim.vim
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            { # theme of choice (light of course)
                name = "night-owl";
                publisher = "sdras";
                version = "2.0.1";
                sha256 = "sha256-AqfcVV9GYZ+GLgusXfij9z4WzrU9cCHp3sdZb0i6HzE=";
            }
            { # icons of choice
                name = "fluent-icons";
                publisher = "miguelsolorio";
                version="0.0.18";
                sha256 = "sha256-sE0A441QPwokBoLoCqtImDHmlAXd66fj8zsJR7Ci+Qs=";
            }
        ];

        userSettings = {
            "editor.fontFamily" = "Victor Mono, monospace";
            "editor.cursorBlinking" = "phase";
            "editor.cursorSmoothCaretAnimation" = "on";
            "editor.cursorStyle" = "line-thin";
            "editor.fontLigatures" = true;
            "editor.wordWrap" = "bounded";
            "editor.wordWrapColumn" = 150;
            "files.autoSave" = "afterDelay";
            "files.exclude" = {
                "**/.classpath" = true;
                "**/.factorypath" = true;
                "**/.project" = true;
                "**/.settings" = true;
            };
            "symbols.hidesExplorerArrows" = false;
            "window.titleBarStyle" = "custom";
            "workbench.colorTheme" = "Night Owl Light";
            "workbench.productIconTheme" = "fluent-icons";
            "workbench.sideBar.location" = "right";
            "vim" = {
                "autoSwitchInputMethod.enable" = true;
                "camelCaseMotion.enable" = true;
                "easymotion" = true;
            };
            "explorer.confirmDelete" = false;
        };
    };

}