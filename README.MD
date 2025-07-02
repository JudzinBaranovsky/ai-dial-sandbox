# Qodo Merge - automated code review

How to run:
- one-time setup:
  - create a GitHub personal access token with `repo` scope
  - create a `qodo-merge-agent/secrets.env` file with the following content:
    ```
    OPENAI__KEY=<DIAL API KEY>
    GITHUB.USER_TOKEN=<GITHUB TOKEN>
    ```
- from the project root, run `./qodo.ps1 <action> <pr_url>`
- here `<action>` can be `review` or `describe`
