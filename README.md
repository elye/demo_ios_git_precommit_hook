# iOSPreCommitHook

This iOS project includes a custom Git pre-commit hook to help maintain code quality and encourage incremental changes.

## Features
- **Pre-commit hook**: Prevents committing large chunks of code by comparing staged changes to the `main` branch.
- **Easy setup**: Includes a setup script to install the pre-commit hook automatically.

## How It Works
The pre-commit hook checks the size of your staged changes against the `main` branch. If your changes are too large, the commit is blocked and you are prompted to make smaller, incremental commits.

## Setup Instructions
1. **Clone the repository**
2. **Install the pre-commit hook**
   
   From the project root, run:
   ```sh
   sh ./scripts/setup-hooks.sh
   ```
   This will copy the `pre-commit` script from `scripts/pre-commit` to `.git/hooks/pre-commit` and make it executable.

3. **Commit as usual**
   The hook will automatically run before each commit. If your changes are too large, you will see an error and the commit will be blocked.

## Troubleshooting
- If you see an error during build or commit: 
  > Please run 'sh ./scripts/setup-hooks.sh' to install it.
  
  Make sure you have run the setup script and that `.git/hooks/pre-commit` exists and is executable.

## Customization
- You can modify the logic in `scripts/pre-commit` to adjust the threshold for what is considered a "large" change.

## Why Use This?
- Encourages smaller, more manageable commits
- Makes code review easier
- Helps maintain a clean and understandable commit history

---

For questions or improvements, feel free to open an issue or pull request.
