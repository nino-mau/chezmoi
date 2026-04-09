function ask -d 'Ask something to ai through pi coding agent'
    set -l thinking minimal

    if set -q argv[1]; and test "$argv[1]" = -l
        set thinking high
        set -e argv[1]
    end

    if test -z "$argv"
        echo "Usage: ask [-l] <your_prompt>"
        return 1
    end

    pi --model openai-codex/gpt-5.4-mini:$thinking -p (string join ' ' -- $argv)
end
