function get_github_repo_size -d 'Show GitHub repository sizes from the GitHub API'
    if test (count $argv) -gt 0
        switch $argv[1]
            case --help -h
                printf '%s\n' \
                    'Usage: get_github_repo_size [OPTIONS] {GITHUB_REPO_URLS...}' \
                    '' \
                    'Retrieve and display the sizes of GitHub repositories.' \
                    "The function will automatically use the GITHUB_TOKEN if it's set as an environment variable." \
                    '' \
                    'Warning: GitHub API repository size information may not be reliable.' \
                    '' \
                    'Explanation:' \
                    '' \
                    '- GitHub support has indicated that due to Git Alternates and the way files are stored in GitHub repositories,' \
                    '  the numbers returned from the GitHub API cannot be relied upon for the actual size' \
                    '- Therefore, the size values returned by this script should not be considered' \
                    '  a reliable or accurate representation of the true repository size' \
                    '- The API size values may differ significantly from the actual repository size' \
                    '' \
                    'Options:' \
                    '' \
                    '  -h, --help     Display this help message.' \
                    '' \
                    'Environment variables:' \
                    '' \
                    '  GITHUB_TOKEN   Use the provided GitHub token for authentication.' \
                    '' \
                    'Exit codes:' \
                    '' \
                    '  0              Success' \
                    '  1              Fail'
                return 0
        end
    end

    set -l _err 0

    for _url in $argv
        set -l _owner (basename (dirname "$_url"))
        set -l _repo (basename "$_url")
        set -l _domain (basename (dirname (dirname "$_url")))
        set -l _api_url "https://api.$_domain/repos/$_owner/$_repo"

        set -l _headers
        if set -q GITHUB_TOKEN; and test -n "$GITHUB_TOKEN"
            set _headers -H "Authorization: Bearer $GITHUB_TOKEN"
        end

        set -l _response (curl -sS $_headers "$_api_url" | string collect)
        set -l _curl_status $pipestatus[1]

        if test $_curl_status -ne 0
            printf 'error %s Failed to retrieve information about the GitHub repository: %s\n' \
                "$_domain/$_owner/$_repo" 'dns or http connection error' >&2
            set _err 1
            continue
        end

        if printf '%s\n' "$_response" | jq -e '.message' >/dev/null 2>&1
            set -l _message (printf '%s\n' "$_response" | jq -r '.message')
            printf 'error %s Failed to retrieve information about the GitHub repository: %s\n' \
                "$_domain/$_owner/$_repo" "$_message" >&2
            set _err 1
            continue
        end

        set -l _size (printf '%s\n' "$_response" | jq -r '.size // empty' 2>/dev/null)
        if test -n "$_size"
            set -l _formatted_size (printf '%s\n' "$_size" | numfmt --to=iec --from-unit=1024)
            if test $status -eq 0
                printf '%s %s\n' "$_formatted_size" "$_domain/$_owner/$_repo"
            else
                printf 'error %s Invalid size data retrieved.\n' "$_domain/$_owner/$_repo" >&2
                set _err 1
            end
        else
            printf 'error %s Invalid size data retrieved.\n' "$_domain/$_owner/$_repo" >&2
            set _err 1
        end
    end

    printf '\nWarning: GitHub API repository size information may not be reliable (see --help for details).\n' >&2
    return $_err
end
