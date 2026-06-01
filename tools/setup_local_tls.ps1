$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$certDir = Join-Path $repoRoot 'docker\certs\local'
$certPath = Join-Path $certDir 'cert.pem'
$keyPath = Join-Path $certDir 'key.pem'
$dhParamPath = Join-Path $certDir 'dhparam.pem'

if (-not (Get-Command mkcert -ErrorAction SilentlyContinue)) {
  throw 'mkcert is required. Install it with: choco install mkcert'
}

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
  throw 'Docker is required to generate dhparam.pem.'
}

New-Item -ItemType Directory -Force -Path $certDir | Out-Null

& mkcert -install
if ($LASTEXITCODE -ne 0) {
  throw 'mkcert could not install its local certificate authority.'
}

& mkcert -cert-file $certPath -key-file $keyPath localhost 127.0.0.1 ::1
if ($LASTEXITCODE -ne 0) {
  throw 'mkcert could not generate the localhost certificate.'
}

if (-not (Test-Path $dhParamPath)) {
  $dockerCertDir = $certDir -replace '\\', '/'
  & docker run --rm --entrypoint sh --volume "${dockerCertDir}:/certs" primeroims/nginx:latest `
    -lc 'openssl dhparam -out /certs/dhparam.pem 2048'
  if ($LASTEXITCODE -ne 0) {
    throw 'Docker could not generate dhparam.pem.'
  }
}

Write-Host "Trusted localhost certificates generated in $certDir"
