
# iOS Pre-Commit Hook

A Git pre-commit hook for iOS projects that prevents large commits and encourages smaller, focused changes for better code review and maintainability.

## 🎯 Purpose
This pre-commit hook helps maintain code quality by:
- Preventing large commits that are difficult to review
- Encouraging smaller, focused commits that represent single concerns
- Providing clear feedback about the size of changes being committed
- Promoting better development practices with incremental commits

## 📊 What It Checks
The hook analyzes your commit against the main branch and checks:
- Committed changes since branching from main
- Staged changes (what you're about to commit)
- Total lines added/removed compared to a configurable threshold (default: 100 lines)

> Note: The hook excludes unstaged changes from the analysis, focusing only on what's actually being committed.

## 🚀 Installation
### Manual Installation
From the project root, run:
```sh
sh ./scripts/setup-hooks.sh
```

This will:
- Create a symlink from `.git/hooks/pre-commit` to `scripts/pre-commit` (so updates to the script are automatically reflected)
- Ensure the target script is executable (`chmod +x scripts/pre-commit`)
- Display the current threshold setting

## 🧩 Xcode Integration: Ensuring the Hook is Installed
To ensure every developer has the pre-commit hook installed, you can add a Run Script Phase in your Xcode build process:

```sh
if [ ! -x "${SRCROOT}/.git/hooks/pre-commit" ]; then
   echo "error: .git/hooks/pre-commit hook is missing or not executable. Please run 'sh ./scripts/setup-hooks.sh' to install it."
   exit 1
fi
```

This script checks if the pre-commit hook exists and is executable. If not, it stops the build and displays an error message, prompting you to run the setup script. This helps enforce the use of the pre-commit hook across your team.

## 📋 Demo: How It Works
### Scenario 1: Small Commit (Allowed)
```sh
// Make a small change
git add .
git commit -m "Add small comment"
```
Output:
```
🔍 Checking commit size against main branch...
📊 Analyzing changes since branching from main...
📈 Change Statistics:
   Committed changes since main:
      Lines added: +0
      Lines removed: -0
      Net change: 0 lines

   Staged changes (about to commit):
      Lines added: +1
      Lines removed: -0
      Net change: 1 lines

   Total branch changes (no double counting):
      Lines added: +1
      Lines removed: -0
      Net change: 1 lines

✅ Change size looks good! (under 100 lines threshold)
```

### Scenario 2: Large Commit (Warning + Prompt)
```sh
// Make a large change (e.g., add 150 lines of code)
git add .
git commit -m "Add large feature"
```
Output:
```
🔍 Checking commit size against main branch...
📊 Analyzing changes since branching from main...
📈 Change Statistics:
   Committed changes since main:
      Lines added: +50
      Lines removed: -10
      Net change: 40 lines

   Staged changes (about to commit):
      Lines added: +120
      Lines removed: -5
      Net change: 115 lines

   Total branch changes (no double counting):
      Lines added: +170
      Lines removed: -15
      Net change: 155 lines

⚠️  WARNING: Large code change detected!
Your branch has significant changes compared to main:
   - Added lines: 170 (threshold: 100)
   - Removed lines: 15 (threshold: 100)

💡 Consider breaking your changes into smaller commits:
   1. Split your changes into logical, focused commits
   2. Each commit should represent a single concern or feature
   3. Smaller commits are easier to review and debug
   4. Consider using 'git add -p' for selective staging

Do you want to continue with this large commit? (y/N):
```

### Scenario 3: Main Branch (Always Allowed)
```sh
git checkout main
git commit -m "Any change on main"
```
Output:
```
🔍 Checking commit size against main branch...
✅ You're on the main branch. Commit allowed.
```

## ⚙️ Configuration
### Changing the Threshold
Edit the `THRESHOLD` variable in `scripts/pre-commit` to change the allowed lines threshold.

## 🛠️ Development Tips
### Using Selective Staging
Break large changes into smaller commits using selective staging:
```sh
git add -p
```
### Viewing Changes Before Commit
See what will be committed:
```sh
git diff --cached --stat
```

## 🤔 Why This Approach?
### Benefits of Smaller Commits:
- Easier code review: Reviewers can focus on specific changes
- Better git history: Clear progression of feature development
- Easier debugging: `git bisect` is more effective with smaller commits
- Safer rollbacks: Can revert specific changes without affecting others
- Better collaboration: Reduces merge conflicts

### What Constitutes a "Large" Change:
- 100+ lines is the default threshold (configurable)
- Mixed concerns: Multiple unrelated changes in one commit
- Refactoring + features: Should be separate commits

## 🚫 When to Override
You might want to bypass the hook for:
- Generated code: Large auto-generated files
- Initial project setup: First commit with boilerplate
- Dependency updates: Large lock file changes
- Emergency fixes: Critical production issues

Use `--no-verify` sparingly and consider breaking the change into smaller commits afterward.

---

Demo how to add a git precommit hook to check for large branch vs main
