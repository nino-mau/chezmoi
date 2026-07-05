---
description: Suggest a commit message for the current staged changes
model: openai/gpt-5.5:minimal
---

# Workflow

1. Read the guidelines
2. Obtain staged diff
3. Obtain the previous commit messages
4. Load the commit skill (currently caveman-commit, if not there then use next most relevant skill)
5. Suggest a commit message for the current changes following the skill

# Guidelines

- Guideline of this prompt override guideline of the commit skill
- Take into account previous commit message to write the commit
- Output should be be the commit content only, no explanations or markdown formatting
