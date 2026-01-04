#!/usr/bin/env bash

# Git commit wrapper script for AI Agent
# Sets predefined user configuration and forwards parameters to git commit

set -euo pipefail

# Function to display help message
show_help() {
    cat << EOH
Git Commit Wrapper for AI Agent

DESCRIPTION:
    This script wraps \`git commit\`. It automatically sets 
    \`user.name\` and \`user.email\` to Agent's name and email 
    before executing commit command. It does not affect system, 
    global, or local Git configuration.

USAGE:
    $0 -m <commit_message> [other_git_commit_options]
    $0 -F <commit_file> [other_git_commit_options]
    $0 help|--help|-h

REQUIRED PARAMETERS:
    -m <message>      Commit message (required if -F not used)
    -F <file>         Read commit message from file (required if -m not used)

COMMIT MESSAGE TEMPLATE:
    # Use Markdown for emphasis, code, lists, etc.
    <One-line summary>

    ## Use explanation to clarify the reason behind the change
    ## Use explanation to document non-trivial implementation details and decisions
    ## Others will rely on your explanation when introspecting \`git log\` to understand evolution of infra, API, and code
    [Optional explanation]

EXAMPLES:
    $0 -F commit_message.txt

    $0 -a -m "Update examples in README"
    
    $0 -m "Implement user profile edit (with tests)" -- trailer "Co-authored-by: \$(git config user.name) <\$(git config user.email)>"
    
    $0 -m << 'EOF' 
    Fix Google token refresh 
    
    - Update Google token expiration check
    - Update tests to capture the edge case
    - Update documentation
    EOF --trailer "Fixes: <issue_ref>"
    
    $0 -m << 'EOF' 
    Upgrade dependencies 
    
    - Upgrade Flask from 3.0.2 to 3.1.2
    - Upgrade <dependency X> from <version A> to <version B>
    EOF
EOH
}

# Function to display error with recovery instructions
show_error() {
    local error_msg="$1"
    echo "ERROR: $error_msg" >&2
    echo "" >&2
    echo "RECOVERY INSTRUCTIONS:" >&2
    case "$error_msg" in
        *"no commit message"*)
            echo "- Set commit message using: \`$0 -F \"<file>\"\`" >&2
            echo "- OR set commit message using: \`$0 -m <message>\`" >&2
            ;;
        *"nothing to commit"*)
            echo "- Stage files for commit using: \`git add <files>\`" >&2
            echo "- OR use the \`-a\` flag to commit all modified files" >&2
            ;;
        *)
            echo "1. Consider what you want to accomplish" >&2
            echo "2. Evaluate the command you've been running. Does it match your intent?" >&2
            echo "3. Now read the error message again. Does it make sense? If not, ask how to proceed." >&2
            ;;
    esac
    exit 1
}

# Check for help parameter
if [[ $# -eq 1 && ("$1" == "help" || "$1" == "--help" || "$1" == "-h") ]]; then
    show_help
    exit 0
fi

# Check if -m or -F parameter is provided
message_param_found=false
other_args=()

# Parse arguments to find -m or -F parameter
while [[ $# -gt 0 ]]; do
    case $1 in
        -m|-F)
            if [[ $# -lt 2 ]]; then
                show_error "no commit message was provided"
            fi
            message_param_found=true
            other_args+=("$1" "$2")
            shift 2
            ;;
        *)
            other_args+=("$1")
            shift
            ;;
    esac
done

# Verify -m or -F parameter was provided
if [[ "$message_param_found" != true ]]; then
    show_error "no commit message was provided"
fi

# Set git user configuration locally and execute git commit
{
    git -c user.name="Kiro" -c user.email="kiro@kiro.ide" commit "${other_args[@]}"
} || {
    exit_code=$?
    case $exit_code in
        1)
            show_error "nothing to commit, working tree clean"
            ;;
        *)
            show_error "git commit failed with exit code $exit_code"
            ;;
    esac
}

echo "Commit completed successfully with user: Kiro <kiro@kiro.ide>"