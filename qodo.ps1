param (
    [string]$prAction = "not_defined",
    [string]$prUrl = "not_defined",
    [string]$prompt = "not_defined"
)

$tempEnvFile = "qodo-merge-agent/temp.env"
if (Test-Path $tempEnvFile) {
    Remove-Item $tempEnvFile -Force
}

Add-Content -Path $tempEnvFile -Value "GITHUB_PR_URL=$prUrl"
Add-Content -Path $tempEnvFile -Value "PR_ACTION=$prAction"

$tcpDumpFolder = "qodo-merge-agent/tcpdump"
if (-not (Test-Path $tcpDumpFolder)) {
    New-Item -ItemType Directory -Path $tcpDumpFolder | Out-Null
}

if ($prAction -eq "ask") {
    Add-Content -Path $tempEnvFile -Value "ASK_PROMPT=$prompt"
}

$dockerComposeFile = "qodo-merge-agent/docker-compose.yml"
docker compose --env-file $tempEnvFile -f $dockerComposeFile up --build --remove-orphans

if (Test-Path $tempEnvFile) {
    Remove-Item $tempEnvFile -Force
}
