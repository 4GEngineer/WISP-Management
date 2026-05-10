#Requires -Version 5.1
<#
.SYNOPSIS
  Deploy this folder to Firebase Hosting site agenticops-production (wisptools-production),
  where custom domain agenticop.io is usually attached.

.DESCRIPTION
  Primary firebase.json targets project agenticops-io-web. agenticop.io often still
  points at the multi-site target on wisptools-production — run this script after
  normal deploy so the public domain matches the dark multi-page site.

.EXAMPLE
  .\scripts\deploy-custom-domain-hosting.ps1
#>
$ErrorActionPreference = "Stop"
$siteDir = Split-Path $PSScriptRoot -Parent
Set-Location $siteDir
if (-not (Test-Path "firebase.hosting-wisptools-agenticop.json")) {
  Write-Error "firebase.hosting-wisptools-agenticop.json missing."
}
$bak = "firebase.__deploy_wisptools__.json.bak"
try {
  Copy-Item -Force "firebase.json" $bak
  Copy-Item -Force "firebase.hosting-wisptools-agenticop.json" "firebase.json"
  firebase deploy --only hosting:agenticops --project wisptools-production
} finally {
  if (Test-Path $bak) {
    Copy-Item -Force $bak "firebase.json"
    Remove-Item -Force $bak
  }
}
