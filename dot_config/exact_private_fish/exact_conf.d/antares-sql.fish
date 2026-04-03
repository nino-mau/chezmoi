if set -q ELECTRON_RUN_AS_NODE
    set -e ELECTRON_RUN_AS_NODE
end

function antares-sql --wraps /usr/bin/antares-sql --description "Launch Antares SQL with sane Electron defaults"
    set use_wayland 0
    if contains -- --wayland $argv
        set use_wayland 1
    end

    if test $use_wayland -eq 0
        if test "$XDG_SESSION_TYPE" = "wayland"
            env -u ELECTRON_RUN_AS_NODE ELECTRON_OZONE_PLATFORM_HINT=wayland /usr/bin/antares-sql --wayland $argv
            return $status
        end

        if test -n "$WAYLAND_DISPLAY"
            env -u ELECTRON_RUN_AS_NODE ELECTRON_OZONE_PLATFORM_HINT=wayland /usr/bin/antares-sql --wayland $argv
            return $status
        end
    end

    env -u ELECTRON_RUN_AS_NODE ELECTRON_OZONE_PLATFORM_HINT=auto /usr/bin/antares-sql $argv
end
