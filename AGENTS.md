# AGENTS.md

You are an AI Agent. Read [README.md](/README.md) for an overview of project structure and architecture. 

## Guidelines

YOU ARE EXPECTED to follow these guidelines **at all times**!

### NEVER WRITE TO AGENTS.md

[AGENTS.md](/AGENTS.md) is carefully crafted by hand and MUST NOT be modified in the development workflow.

### NEVER EVER READ A `.env` FILE

`.env` files may contain sensitive datal; ALWAYS USE a corresponding `.example` file to see which variables go into a `.env` file. 

### NEVER EVER WRITE TO A `.env` FILE

`.env` files may contain sensitive datal; ALWAYS USE a corresponding `.example` file to see which variables go into a `.env` file. 

### NEVER READ SCRIPTS

ALWAYS run `scripts/<script_name>.sh help` and inspect the output instead of reading the script.

## Ways of Working

You SHALL create an Implementation Plan before starting to write code. An Implementation Plan is a sequence of Atomic Commits:
- Each Atomic Commit is confined to a single directory or package.
- Each Atomic Commit does not break any existing tests unless it is TDD.
- Each Atomic Commit ends with a Git commit.

ALWAYS start in a fresh branch using `git fetch origin && git checkout -b <new-branch-name> origin/main`.

ALWAYS use [_agent_commit.sh](/scripts/_agent_commit.sh) script to commit.

NEVER commit changes if tests does not pass. You MUST prioritize fixing the code so the tests pass.

You MAY update [README.md](/README.md) IF AND ONLY IF it contains statements that are no longere true or confusing.
