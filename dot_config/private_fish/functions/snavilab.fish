# Start a tmux session for navilab project
function snavilab --d "Start a tmux session for navilab project"
    set session_name navilab
    set project_root ~/Documents/dev/projects/navilab

    # Check if tmux session exists
    tmux has-session -t $session_name 2>/dev/null
    if test $status -eq 0
        tmux attach-session -t $session_name
        return
    end

    if test -z "$TMUX"
        # outside any tmux
        tmux new-session -d -s $session_name

        tmux new-window -t $session_name:1 -c $project_root -n editor
        tmux send-keys -t $session_name:1 "lvim $project_root" C-m
        tmux new-window -t $session_name:2 -c $project_root -n shell

        tmux select-window -t $session_name:1
        tmux attach-session -t $session_name
    else
        # inside tmux
        TMUX= tmux new-session -d -s $session_name
        tmux switch-client -t $session_name

        tmux new-window -t $session_name:1 -c $project_root -n editor lvim .
        tmux send-keys -t $session_name:1 "lvim $project_root" C-m
        tmux new-window -t $session_name:2 -c $project_root -n shell

        tmux select-window -t $session_name:1
    end
end
