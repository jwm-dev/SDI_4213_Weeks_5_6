# Instructor GitHub Setup

## Option A – Create a new repository from the GitHub website

1. Create a new empty GitHub repository.
2. Do **not** initialize it with another README, .gitignore, or license.
3. Extract this ZIP to a local folder.
4. Open a terminal in the extracted folder.
5. Run:

```bash
git init
git branch -M main
git add .
git commit -m "Add Weeks 5-6 starter project"
git remote add origin <YOUR-REPOSITORY-URL>
git push -u origin main
```

## Option B – Use as a GitHub template repository

After pushing the starter files:

1. Open **Settings** for the GitHub repository.
2. Enable **Template repository**.
3. Give students the repository link.
4. Each student selects **Use this template** to create an individual copy.

This is a good approach for an individual assignment because every student begins with identical files and their own independent Git history.

## Recommended Repository Settings

- Keep `main` as the default branch.
- Require students to work through branches and pull requests.
- Consider requiring a passing GitHub Actions check before merging.
- Do not place instructor solution files in the student template repository.
