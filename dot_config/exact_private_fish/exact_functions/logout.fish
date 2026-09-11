function logout --description "Logout from system"
    switch (uname)
        case Darwin
            command noctalia msg session logout
        case Linux
            if command -q noctalia; and noctalia msg status >/dev/null 2>&1
                command noctalia msg session logout
            else
                switch ($XDG_SESSION_DESKTOP)
                    case Hyprland
                        command dispatch "hl.dsp.exit()"
                    case Niri
                        command niri msg action logout 
                end

                # Fallback if noctalia isn't running
                command loginctl terminate-session "$XDG_SESSION_ID"
            end
    end
end
