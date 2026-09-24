function _aerospace_53
    set 1 $argv[1]
    aerospace list-workspaces --monitor all --empty no
end

function _aerospace_66
    set 1 $argv[1]
    true
end

function _aerospace_32
    set 1 $argv[1]
    aerospace list-apps --format '%{app-pid}%{tab}%{app-name}'
end

function _aerospace_39
    set 1 $argv[1]
    aerospace config --get mode --keys | xargs -I{} aerospace config --get mode.{}.binding --keys
end

function _aerospace_65
    set 1 $argv[1]
    aerospace list-windows --all --format '%{window-id}%{tab}%{app-name} - %{window-title}'
end

function _aerospace_22
    set 1 $argv[1]
    aerospace config --major-keys
end

function _aerospace_46
    set 1 $argv[1]
    aerospace config --get mode --keys
end

function _aerospace_20
    set 1 $argv[1]
    aerospace list-apps --format '%{app-bundle-id}%{tab}%{app-name}'
end

function _aerospace_48
    set 1 $argv[1]
    aerospace list-monitors --format '%{monitor-id}%{tab}%{monitor-name}'
end

function _aerospace_subword_cmd_0
    true
end

function _aerospace_subword_1
    set mode $argv[1]
    set word $argv[2]

    set --local literals "-" "+"

    set --local descriptions

    set --local literal_transitions
    set literal_transitions[1] "set inputs 1 2; set tos 2 2"

    set --local match_anything_transitions_from 1 2
    set --local match_anything_transitions_to 3 3

    set --local state 1
    set --local char_index 1
    set --local matched 0
    while true
        if test $char_index -gt (string length -- "$word")
            set matched 1
            break
        end

        set --local subword (string sub --start=$char_index -- "$word")

        if set --query literal_transitions[$state] && test -n $literal_transitions[$state]
            set --local --erase inputs
            set --local --erase tos
            eval $literal_transitions[$state]

            set --local literal_matched 0
            for literal_id in (seq 1 (count $literals))
                set --local literal $literals[$literal_id]
                set --local literal_len (string length -- "$literal")
                set --local subword_slice (string sub --end=$literal_len -- "$subword")
                if test $subword_slice = $literal
                    set --local index (contains --index -- $literal_id $inputs)
                    set state $tos[$index]
                    set char_index (math $char_index + $literal_len)
                    set literal_matched 1
                    break
                end
            end
            if test $literal_matched -ne 0
                continue
            end
        end

        if set --query match_anything_transitions_from[$state] && test -n $match_anything_transitions_from[$state]
            set --local index (contains --index -- $state $match_anything_transitions_from)
            set state $match_anything_transitions_to[$index]
            set --local matched 1
            break
        end

        break
    end

    if test $mode = matches
        return (math 1 - $matched)
    end


    set --local unmatched_suffix (string sub --start=$char_index -- $word)

    set --local matched_prefix
    if test $char_index -eq 1
        set matched_prefix ""
    else
        set matched_prefix (string sub --end=(math $char_index - 1) -- "$word")
    end
    if set --query literal_transitions[$state] && test -n $literal_transitions[$state]
        set --local --erase inputs
        set --local --erase tos
        eval $literal_transitions[$state]
        for literal_id in $inputs
            set --local unmatched_suffix_len (string length -- $unmatched_suffix)
            if test $unmatched_suffix_len -gt 0
                set --local literal $literals[$literal_id]
                set --local slice (string sub --end=$unmatched_suffix_len -- $literal)
                if test "$slice" != "$unmatched_suffix"
                    continue
                end
            end
            if test -n $descriptions[$literal_id]
                printf '%s%s\t%s\n' $matched_prefix $literals[$literal_id] $descriptions[$literal_id]
            else
                printf '%s%s\n' $matched_prefix $literals[$literal_id]
            end
        end
    end

    set command_states 1 2
    set command_ids 0 0
    if contains $state $command_states
        set --local index (contains --index $state $command_states)
        set --local function_id $command_ids[$index]
        set --local function_name _aerospace_subword_cmd_$function_id
        set --local --erase inputs
        set --local --erase tos
        $function_name "$matched_prefix" | while read --local line
            printf '%s%s\n' $matched_prefix $line
        end
    end

    return 0
end


function _aerospace
    set COMP_LINE (commandline --cut-at-cursor)

    set COMP_WORDS
    echo $COMP_LINE | read --tokenize --array COMP_WORDS
    if string match --quiet --regex '.*\s$' $COMP_LINE
        set COMP_CWORD (math (count $COMP_WORDS) + 1)
    else
        set COMP_CWORD (count $COMP_WORDS)
    end

    set --local literals "move-mouse" "--count" "mode-changed" "-v" "smart" "macos-native-fullscreen" "mute-toggle" "height" "toggle" "all-monitors-outer-frame" "h_accordion" "--stdin" "all" "--window-id" "monitor-force-center" "list-apps" "--fail-if-fullscreen" "flatten-workspace-tree" "mode" "width" "summon-workspace" "focus-back-and-forth" "list-monitors" "h_tiles" "prev" "window-force-center" "trigger-binding" "-h" "move-node-to-workspace" "wrap-around-the-workspace" "enable" "focused-monitor-changed" "=" "--ignore-floating" "--visible" "close-all-windows-but-current" "--fail-if-macos-native-fullscreen" "--help" "--macos-native-hidden" "test-not" "--stderr" "off" "move-workspace-to-monitor" "--no-send-initial" "--boundaries" "set" "workspace-back-and-forth" "on-focused-monitor-changed" "--quit-if-last-window" "window-lazy-center" "workspace" "--major-keys" "accordion" "--focused" "tiling" "run-callback" "--app-bundle-id" "--mouse" "balance-sizes" "opposite" "on" "--auto-back-and-forth" "--version" "test" "--json" "join-with" "reload-config" "--workspace" "floating" "--swap-focus" "--root" "--mode" "--boundaries-action" "resize" "~=" "visible" "close" "false" "--no-stdin" "up" "layout" "--fail-if-noop" "list-exec-env-vars" "fail" "on-window-detected" "--focus-follows-window" "split" "--monitor" "--pid" "true" "mute-on" "eval" "v_tiles" "--keys" "monitor-lazy-center" "wrap-around-all-monitors" "--wrap-around" "subscribe" "--for-every-window" "config" "horizontal" "create-implicit-container" "--no-outer-gaps" "focused" "mute-off" "--all-keys" "--all" "left" "right" "on-focus-changed" "swap" "--config-path" "binding-triggered" "--get" "--empty" "tiles" "dfs-next" "--no-gui" "smart-opposite" "--format" "list-modes" "focus-changed" "--dry-run" "window-detected" "move-node-to-monitor" "--window" "dfs-prev" "move" "focus" "down" "list-workspaces" "volume" "no" "stop" "debug-windows" "macos-native-minimize" "list-windows" "mouse" "next" "--dfs-index" "echo" "fullscreen" "focus-monitor" "focused-workspace-changed" "--current" "--" "vertical" "v_accordion"

    set --local descriptions

    set --local literal_transitions
    set literal_transitions[1] "set inputs 1 4 66 67 43 6 47 74 111 77 78 121 16 51 81 83 18 125 19 23 87 22 90 128 21 27 28 92 29 56 129 131 132 31 98 135 136 137 59 100 141 36 63 142 38 64 143 40; set tos 119 18 69 129 106 64 18 130 95 14 18 99 38 131 42 18 2 114 40 36 123 18 18 21 125 51 18 132 133 134 22 135 80 136 101 32 32 126 2 70 16 79 18 89 18 137 138 137"
    set literal_transitions[2] "set inputs 68; set tos 3"
    set literal_transitions[4] "set inputs 84 102 134; set tos 5 5 5"
    set literal_transitions[5] "set inputs 45 17 37 73 14; set tos 115 5 5 4 128"
    set literal_transitions[7] "set inputs 89 2 57 68 65 88 120; set tos 109 7 6 10 7 111 110"
    set literal_transitions[9] "set inputs 103 82 14 61; set tos 9 144 8 73"
    set literal_transitions[10] "set inputs 76 104; set tos 11 11"
    set literal_transitions[11] "set inputs 89 2 76 68 120 57 65 104 88; set tos 109 7 11 10 110 6 7 11 111"
    set literal_transitions[13] "set inputs 108 109 130 80; set tos 18 18 18 18"
    set literal_transitions[14] "set inputs 14 49; set tos 15 14"
    set literal_transitions[16] "set inputs 41 126 146; set tos 16 17 18"
    set literal_transitions[19] "set inputs 97; set tos 18"
    set literal_transitions[21] "set inputs 14 130 80 45 17 37 73 108 109; set tos 20 5 5 96 21 21 97 5 5"
    set literal_transitions[22] "set inputs 97 127 130 14 34 80 45 140 117 17 37 73 108 109; set tos 27 26 23 25 27 23 28 24 26 29 29 30 23 23"
    set literal_transitions[23] "set inputs 45 17 37 73 34 97; set tos 122 23 23 105 23 23"
    set literal_transitions[26] "set inputs 73 34 97; set tos 47 26 26"
    set literal_transitions[27] "set inputs 130 117 34 80 45 17 37 73 108 109 97 127; set tos 23 26 27 23 28 29 29 30 23 23 27 26"
    set literal_transitions[28] "set inputs 10 51; set tos 29 29"
    set literal_transitions[29] "set inputs 130 34 80 45 17 37 73 108 109 97; set tos 23 29 23 28 29 29 31 23 23 29"
    set literal_transitions[30] "set inputs 134 30 84 96; set tos 27 27 27 27"
    set literal_transitions[31] "set inputs 134 30 84 96; set tos 29 29 29 29"
    set literal_transitions[32] "set inputs 14; set tos 25"
    set literal_transitions[34] "set inputs 82; set tos 18"
    set literal_transitions[36] "set inputs 2 120 65 58 54; set tos 36 35 36 76 76"
    set literal_transitions[38] "set inputs 2 120 65 39; set tos 38 37 38 78"
    set literal_transitions[39] "set inputs 72; set tos 40"
    set literal_transitions[42] "set inputs 11 147 68 69 14 71 24 55 93 82 53 148 101 116; set tos 60 60 41 60 77 42 60 60 60 42 60 60 60 60"
    set literal_transitions[43] "set inputs 13 2 138 115 120 35 65 104; set tos 43 44 43 45 46 45 44 43"
    set literal_transitions[44] "set inputs 35 2 115 120 65; set tos 45 44 45 46 44"
    set literal_transitions[45] "set inputs 35 2 133 115 120 65; set tos 45 44 44 45 46 44"
    set literal_transitions[47] "set inputs 134 30 84 96; set tos 26 26 26 26"
    set literal_transitions[48] "set inputs 97; set tos 18"
    set literal_transitions[49] "set inputs 65 94; set tos 49 49"
    set literal_transitions[51] "set inputs 72; set tos 52"
    set literal_transitions[53] "set inputs 108 109 130 25 139 80; set tos 48 48 48 48 48 48"
    set literal_transitions[54] "set inputs 20 5 8 119; set tos 55 55 55 55"
    set literal_transitions[57] "set inputs 3 44 107 122 124 144 32 113; set tos 57 18 18 57 57 57 57 57"
    set literal_transitions[58] "set inputs 14 99; set tos 59 58"
    set literal_transitions[60] "set inputs 11 147 68 69 14 71 24 55 93 82 53 148 101 116; set tos 60 60 62 60 61 63 60 60 60 63 60 60 60 60"
    set literal_transitions[63] "set inputs 82 14 68 71; set tos 63 61 62 63"
    set literal_transitions[64] "set inputs 82 14 42 61; set tos 64 65 66 66"
    set literal_transitions[66] "set inputs 14 82; set tos 100 66"
    set literal_transitions[68] "set inputs 82 14 97 86; set tos 68 67 68 68"
    set literal_transitions[69] "set inputs 108 109 14 130 80; set tos 18 18 12 18 18"
    set literal_transitions[70] "set inputs 106 52 94 65 114 112; set tos 18 18 71 71 56 18"
    set literal_transitions[71] "set inputs 65 114 94; set tos 71 56 71"
    set literal_transitions[73] "set inputs 14 103 82; set tos 72 73 73"
    set literal_transitions[75] "set inputs 14 99 85; set tos 74 75 58"
    set literal_transitions[76] "set inputs 133 2 120 65 58 54; set tos 36 36 35 36 76 76"
    set literal_transitions[78] "set inputs 133 2 120 65 39; set tos 38 38 37 38 78"
    set literal_transitions[79] "set inputs 49; set tos 18"
    set literal_transitions[80] "set inputs 118 46 80 130 7 91 105; set tos 83 82 81 81 81 81 81"
    set literal_transitions[81] "set inputs 118; set tos 18"
    set literal_transitions[83] "set inputs 80 46 7 91 130 105; set tos 81 82 81 81 81 81"
    set literal_transitions[85] "set inputs 14 82 86; set tos 84 85 85"
    set literal_transitions[86] "set inputs 12 139 79 25 97 86; set tos 86 87 86 87 86 86"
    set literal_transitions[87] "set inputs 12 79 97 86; set tos 87 87 87 87"
    set literal_transitions[89] "set inputs 103 82 14 42 61; set tos 9 143 88 66 73"
    set literal_transitions[91] "set inputs 35 2 115 120 65 88; set tos 147 91 147 90 91 116"
    set literal_transitions[92] "set inputs 120 2 65; set tos 93 92 92"
    set literal_transitions[95] "set inputs 130 14 117 70 80 108 109 97 127; set tos 140 94 140 95 140 140 140 95 140"
    set literal_transitions[96] "set inputs 10 51; set tos 21 21"
    set literal_transitions[97] "set inputs 84 102 134; set tos 21 21 21"
    set literal_transitions[98] "set inputs 62 82; set tos 98 98"
    set literal_transitions[99] "set inputs 145 2 65; set tos 99 99 99"
    set literal_transitions[101] "set inputs 3 44 107 122 124 144 32 113; set tos 57 102 102 57 57 57 57 57"
    set literal_transitions[102] "set inputs 3 122 124 144 32 113; set tos 57 57 57 57 57 57"
    set literal_transitions[103] "set inputs 12 139 79 25 97; set tos 103 104 103 104 103"
    set literal_transitions[104] "set inputs 79 97 12; set tos 104 104 104"
    set literal_transitions[105] "set inputs 134 30 84 96; set tos 23 23 23 23"
    set literal_transitions[106] "set inputs 139 130 25 80 108 109 97; set tos 48 48 48 48 48 48 53"
    set literal_transitions[107] "set inputs 82 14 86; set tos 107 108 107"
    set literal_transitions[111] "set inputs 13 138 104; set tos 149 149 149"
    set literal_transitions[112] "set inputs 42 61; set tos 34 34"
    set literal_transitions[114] "set inputs 139 14 25 130 80 108 109 82 97 86; set tos 68 113 68 68 68 68 68 114 117 114"
    set literal_transitions[115] "set inputs 10 51; set tos 5 5"
    set literal_transitions[116] "set inputs 13 138 104; set tos 43 43 43"
    set literal_transitions[117] "set inputs 139 14 25 130 80 108 109 82 97 86; set tos 68 118 68 68 68 68 68 117 117 117"
    set literal_transitions[119] "set inputs 82 50 15 26 95; set tos 120 34 34 34 34"
    set literal_transitions[120] "set inputs 95 50 15 26; set tos 34 34 34 34"
    set literal_transitions[122] "set inputs 10 51; set tos 23 23"
    set literal_transitions[123] "set inputs 60 14 101 147; set tos 32 124 32 32"
    set literal_transitions[125] "set inputs 82; set tos 33"
    set literal_transitions[126] "set inputs 89 2 68 120 54 107 57 65 88; set tos 109 126 10 127 92 92 6 126 111"
    set literal_transitions[129] "set inputs 118 123; set tos 129 129"
    set literal_transitions[130] "set inputs 20 5 8 14 119; set tos 55 55 55 152 55"
    set literal_transitions[131] "set inputs 12 139 79 25 62 82 97; set tos 103 104 103 104 153 153 103"
    set literal_transitions[132] "set inputs 12; set tos 18"
    set literal_transitions[133] "set inputs 12 79 14 25 139 82 97 86; set tos 86 86 108 87 87 107 86 133"
    set literal_transitions[134] "set inputs 99 14 110 48 85; set tos 75 74 18 18 58"
    set literal_transitions[135] "set inputs 2 115 120 54 35 107 65 88; set tos 135 147 141 92 147 92 135 116"
    set literal_transitions[136] "set inputs 82 42 9 61; set tos 112 34 18 34"
    set literal_transitions[138] "set inputs 139 130 25 80 108 109 97; set tos 48 48 48 48 48 48 142"
    set literal_transitions[140] "set inputs 14 70 97; set tos 139 140 140"
    set literal_transitions[142] "set inputs 108 109 139 130 25 80; set tos 48 48 48 48 48 48"
    set literal_transitions[143] "set inputs 103 82 14 42 61; set tos 144 143 146 66 73"
    set literal_transitions[144] "set inputs 103 82 14 61; set tos 144 144 151 73"
    set literal_transitions[145] "set inputs 101 147 60; set tos 32 32 32"
    set literal_transitions[147] "set inputs 35 2 133 115 120 65 88; set tos 147 91 91 147 90 91 116"
    set literal_transitions[148] "set inputs 82 14 86; set tos 85 84 85"
    set literal_transitions[149] "set inputs 13 2 89 138 68 120 104 57 65 88; set tos 149 7 109 149 10 110 149 6 7 111"
    set literal_transitions[150] "set inputs 75 33; set tos 24 24"
    set literal_transitions[153] "set inputs 62 82; set tos 153 153"

    set --local match_anything_transitions_from 24 40 131 37 128 125 127 146 88 133 11 46 106 82 10 43 25 153 65 6 20 56 94 114 33 111 108 139 118 152 50 109 53 3 61 138 124 137 51 77 116 59 67 41 72 52 93 149 100 151 19 107 62 84 113 121 15 74 8 90 35 110 12 148 17 141
    set --local match_anything_transitions_to 18 18 98 38 5 34 126 143 89 85 11 44 19 81 11 43 18 98 64 7 21 49 95 148 34 149 107 140 117 54 18 7 19 18 63 121 145 150 39 42 43 58 68 42 73 50 92 149 66 144 19 85 63 85 114 121 14 75 9 91 36 7 13 148 16 135
    set subword_transitions[55] "set subword_ids 1; set tos 32"

    set --local state 1
    set --local word_index 2
    while test $word_index -lt $COMP_CWORD
        set --local -- word $COMP_WORDS[$word_index]

        if set --query literal_transitions[$state] && test -n $literal_transitions[$state]
            set --local --erase inputs
            set --local --erase tos
            eval $literal_transitions[$state]

            if contains -- $word $literals
                set --local literal_matched 0
                for literal_id in (seq 1 (count $literals))
                    if test $literals[$literal_id] = $word
                        set --local index (contains --index -- $literal_id $inputs)
                        set state $tos[$index]
                        set word_index (math $word_index + 1)
                        set literal_matched 1
                        break
                    end
                end
                if test $literal_matched -ne 0
                    continue
                end
            end
        end

        if set --query subword_transitions[$state] && test -n $subword_transitions[$state]
            set --local --erase subword_ids
            set --local --erase tos
            eval $subword_transitions[$state]

            set --local subword_matched 0
            for subword_id in $subword_ids
                if _aerospace_subword_$subword_id matches "$word"
                    set subword_matched 1
                    set state $tos[$subword_id]
                    set word_index (math $word_index + 1)
                    break
                end
            end
            if test $subword_matched -ne 0
                continue
            end
        end

        if set --query match_anything_transitions_from[$state] && test -n $match_anything_transitions_from[$state]
            set --local index (contains --index -- $state $match_anything_transitions_from)
            set state $match_anything_transitions_to[$index]
            set word_index (math $word_index + 1)
            continue
        end

        return 1
    end

    if set --query literal_transitions[$state] && test -n $literal_transitions[$state]
        set --local --erase inputs
        set --local --erase tos
        eval $literal_transitions[$state]
        for literal_id in $inputs
            if test -n $descriptions[$literal_id]
                printf '%s\t%s\n' $literals[$literal_id] $descriptions[$literal_id]
            else
                printf '%s\n' $literals[$literal_id]
            end
        end
    end


    if set --query subword_transitions[$state] && test -n $subword_transitions[$state]
        set --local --erase subword_ids
        set --local --erase tos
        eval $subword_transitions[$state]

        for subword_id in $subword_ids
            set --local function_name _aerospace_subword_$subword_id
            $function_name complete "$COMP_WORDS[$COMP_CWORD]"
        end
    end

    set command_states 50 24 40 109 53 3 124 61 138 137 131 37 51 128 77 125 127 146 116 88 59 67 72 41 133 11 52 46 106 93 149 100 151 62 19 107 84 82 10 43 25 113 121 15 74 153 90 8 65 35 6 20 56 94 114 110 33 111 12 108 148 152 17 139 118 141
    set command_ids 39 66 46 32 66 53 65 65 66 66 53 66 39 65 65 53 66 65 48 65 65 65 65 53 53 53 46 66 66 66 48 65 65 53 66 53 65 66 53 48 65 65 66 65 65 53 66 65 65 66 20 65 22 65 66 66 53 48 65 65 66 65 65 65 65 66
    if contains $state $command_states
        set --local index (contains --index $state $command_states)
        set --local function_id $command_ids[$index]
        set --local function_name _aerospace_$function_id
        set --local --erase inputs
        set --local --erase tos
        $function_name "$COMP_WORDS[$COMP_CWORD]"
    end

    return 0
end

complete --command aerospace --no-files --arguments "(_aerospace)"
