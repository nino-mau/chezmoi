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

        # Create session
        tmux new-session -d -s $session_name

        # Create lvim window and open project in lvim
        tmux new-window -t $session_name:1 -c $project_root -n editor
        tmux send-keys -t $session_name:1 "cd $project_root && lvim ." C-m

        # Create shell window and launch project container
        tmux new-window -t $session_name:2 -c $project_root -n shell
        tmux send-keys -t $session_name:2 "docker compose up --build -d" C-m

        # Create opencode window and launch opencode at project root
        tmux new-window -t $session_name:3 -c $project_root -n opencode
        tmux send-keys -t $session_name:3 "cd $project_root && opencode" C-m

        # Go to lvim window and attach session 
        tmux select-window -t $session_name:1
        tmux attach-session -t $session_name
    else
        # inside tmux

        # Create session
        TMUX= tmux new-session -d -s $session_name
        tmux switch-client -t $session_name

        # Create lvim window and open project in lvim
        tmux new-window -t $session_name:1 -c $project_root -n editor
        tmux send-keys -t $session_name:1 "cd $project_root && lvim ." C-m

        # Create shell window and launch project container
        tmux new-window -t $session_name:2 -c $project_root -n shell
        tmux send-keys -t $session_name:2 "docker compose up --build -d" C-m

        # Create opencode window and launch opencode at project root
        tmux new-window -t $session_name:3 -c $project_root -n opencode
        tmux send-keys -t $session_name:3 "cd $project_root && opencode" C-m

        # Go to lvim window
        tmux select-window -t $session_name:1
    end
end
