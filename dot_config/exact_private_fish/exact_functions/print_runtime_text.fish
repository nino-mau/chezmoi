function print_runtime_text --description "Print runtime prompt as plain text"
    set -l p (pwd)
    set -l cfg ~/.config/starship-runtime.toml
    test -f $cfg; or return 1
    set -l out (env STARSHIP_CONFIG=$cfg starship prompt --path $p 2>/dev/null \
        | string replace -ra '\x1b\[[0-9;?]*[ -/]*[@-~]' '' \
        | string trim)
    test -n "$out"; or return 1
    echo $out
end
