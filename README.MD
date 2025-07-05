# Qodo Merge - automated code review

How to run:
- one-time setup:
  - create a GitHub personal access token with `repo` scope
  - create a `qodo-merge-agent/secrets.env` file with the following content:
    ```dotenv
    OPENAI__KEY="<DIAL API KEY>"
    # if using GitHub
    GITHUB.USER_TOKEN="<GITHUB TOKEN>"
    # if using Azure DevOps
    AZURE_DEVOPS__PAT="<your PAT>"
    CONFIG__GIT_PROVIDER=azure
    AZURE_DEVOPS__ORG="<your Azure Organisation URL>"
    ```
- available commands:
  - `./qodo.ps1 review <pr_url>` - run code review for the given PR and post the results as a PR comment, the comment will include recommendations for human reviewers to focus on and any improvement suggestions
  - `./qodo.ps1 describe <pr_url>` - describe the changes in the given PR URL and post the results in the PR description (append to if not empty)
  - `./qodo.ps1 ask <pr_url> "<Free-form text prompt>"`
    - address the given prompt to the AI agent and post the answer as a PR comment
    - the prompt is free-form text, but it's recommended to make it in accordance with LLM prompt engineering best practices
    - example of a prompt: ` "List any feature flags added: a bulleted list of flag names followed by a 1-sentence description. Also, list any controllers added/removed along with all the affected API endpoint URLs."`

# Lite LLM for Brokk.AI

One-time setup:
- create a `lite-llm/secrets.env` file
  - add `AZURE_API_KEY=<your DIAL API key>`
  - add `AZURE_API_BASE=<your DIAL URL>`
- run Lite LLM - in the `lite-llm` folder, run `docker compose up -d`
- install Brokk.AI
- run Brokk.AI
  - enter your API key (you'll have to sign in with Brokk, but it's free, and you'll have to specify your Brokk API key just for the first time)
  - open some project folder
  - File > Settings > Project > Data Retention > Make Brokk better for everyone (it's needed to unlock most of the models despite the fact that they're hosted in DIAL)
  - File > Settings > Global > Service > Choose local proxy
  - restart Brokk
  - File > Settings > Global > Default Models > pick the models for each kind of task

Every time:
- first start Lite LLM - in the `lite-llm` folder, run `docker compose up -d`
- then, run Brokk

How to configure and choose models:
- you can get the list of models available with your DIAL API key by making the following HTTP request (via Postman, curl, or whatever):
```
curl <DIAL URL>/openai/deployments -H 'Api-Key: <your DIAL API key>'
```
- then adjust the `lite-llm/cfg.config.yml` to expose the models you want, for example:
```yml
model_list:
  - model_name: gpt-4.1 # this is what be visible in Brokk's model list
    litellm_params:
      model: azure/gpt-4.1-2025-04-14 # the actual model name from the DIAL deployments list
      api_base: os.environ/AZURE_API_BASE # leave as is
      api_key: os.environ/AZURE_API_KEY # leave as is
      api_version: "2025-01-01-preview" # leave as is
```
- make sure to restart Lite LLM and Brokk after these changes