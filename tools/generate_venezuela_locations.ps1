param(
  [string]$OutputPath = (
    Join-Path $PSScriptRoot '..\configurations\venezuela\locations_venezuela_hxl.csv'
  )
)

$ErrorActionPreference = 'Stop'

$sourceUrl = 'https://raw.githubusercontent.com/zokeber/venezuela-json/master/venezuela.json'
$states = Invoke-RestMethod -Uri $sourceUrl

$normalizeName = {
  param([string]$Value)

  $normalized = $Value.Normalize([Text.NormalizationForm]::FormD)
  -join @(
    $normalized.ToCharArray() |
      Where-Object { [Globalization.CharUnicodeInfo]::GetUnicodeCategory($_) -ne 'NonSpacingMark' }
  )
}

$stateCodeByName = [ordered]@{
  'Distrito Capital' = 'A'
  'Anzoategui' = 'B'
  'Apure' = 'C'
  'Aragua' = 'D'
  'Barinas' = 'E'
  'Bolivar' = 'F'
  'Carabobo' = 'G'
  'Cojedes' = 'H'
  'Falcon' = 'I'
  'Guarico' = 'J'
  'Lara' = 'K'
  'Merida' = 'L'
  'Miranda' = 'M'
  'Monagas' = 'N'
  'Nueva Esparta' = 'O'
  'Portuguesa' = 'P'
  'Sucre' = 'R'
  'Tachira' = 'S'
  'Trujillo' = 'T'
  'Yaracuy' = 'U'
  'Zulia' = 'V'
  'Vargas' = 'X'
  'Delta Amacuro' = 'Y'
  'Amazonas' = 'Z'
}

$rows = foreach ($stateName in $stateCodeByName.Keys) {
  $state = $states | Where-Object { (& $normalizeName $_.estado) -eq $stateName }
  if ($null -eq $state) {
    throw "State not found in source data: $stateName"
  }

  $stateCode = 'VE' + $stateCodeByName[$stateName]
  $stateDisplayName = if ($stateName -eq 'Vargas') { 'La Guaira' } else { $state.estado }
  $municipalityNumber = 0

  foreach ($municipality in $state.municipios) {
    $municipalityNumber += 1
    [PSCustomObject]@{
      countryName = 'Venezuela'
      countryNameEs = 'Venezuela'
      countryCode = 'VE'
      stateName = $stateDisplayName
      stateNameEs = $stateDisplayName
      stateCode = $stateCode
      municipalityName = $municipality.municipio
      municipalityNameEs = $municipality.municipio
      municipalityCode = $stateCode + $municipalityNumber.ToString('000')
    }
  }
}

if (@($rows).Count -ne 335) {
  throw "Expected 335 municipalities, generated $(@($rows).Count)"
}

$hxlTags = [PSCustomObject]@{
  countryName = '#country+name'
  countryNameEs = '#country+name+es'
  countryCode = '#country+code'
  stateName = '#adm1+name'
  stateNameEs = '#adm1+name+es'
  stateCode = '#adm1+code'
  municipalityName = '#adm2+name'
  municipalityNameEs = '#adm2+name+es'
  municipalityCode = '#adm2+code'
}

$outputDirectory = Split-Path -Parent $OutputPath
New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null
@($hxlTags) + @($rows) |
  ConvertTo-Csv -NoTypeInformation |
  Set-Content -Encoding UTF8 -Path $OutputPath

Write-Output "Generated $(@($rows).Count) municipality rows at $OutputPath"
