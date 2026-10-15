# Fill in company details across the site, then delete nothing else.
# Usage: powershell -File fill-placeholders.ps1 -Company "Acme Labs, Inc." -Domain "acmelabs.com" -Email "support@acmelabs.com"
param([Parameter(Mandatory)][string]$Company,[Parameter(Mandatory)][string]$Domain,[Parameter(Mandatory)][string]$Email)
$enc = New-Object Text.UTF8Encoding $false
Get-ChildItem -Path $PSScriptRoot -Filter *.html -Recurse | ForEach-Object {
  $t = [IO.File]::ReadAllText($_.FullName)
  $n = $t.Replace('__COMPANY__',$Company).Replace('__DOMAIN__',$Domain).Replace('__EMAIL__',$Email)
  if ($n -ne $t) { [IO.File]::WriteAllText($_.FullName,$n,$enc); "filled $($_.Name)" }
}
[IO.File]::WriteAllText((Join-Path $PSScriptRoot 'CNAME'),$Domain,$enc)