param (
    [string]$prAction = "not_defined",
    [string]$prUrl = "not_defined"
)

$tempEnvFile = "qodo-merge-agent/temp.env"
if (Test-Path $tempEnvFile) {
    Remove-Item $tempEnvFile -Force
}

Add-Content -Path $tempEnvFile -Value "GITHUB_PR_URL=$prUrl"
Add-Content -Path $tempEnvFile -Value "PR_ACTION=$prAction"

$dockerComposeFile = "qodo-merge-agent/docker-compose.yml"
docker compose --env-file $tempEnvFile -f $dockerComposeFile up --remove-orphans

if (Test-Path $tempEnvFile) {
    Remove-Item $tempEnvFile -Force
}
