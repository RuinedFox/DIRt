Param(
	[String]$Path,
	[Alias("x")]
	[Regex[]]$ExclusionPattern
)

If ($Path -eq "" -or $Path -eq $Null) {
	Write-Error "No drive or directory was provided"
	Exit
}

Function Recurse-Objects {
	Get-ChildItem -Recurse | Select-Object FullName | ForEach-Object {
		If (Select-String -inp $_ -Pattern $ExclusionPattern) { Return }
		Write-Host $_
	}
}

Get-ChildItem -Path $Path -Recurse | Recurse-Objects
