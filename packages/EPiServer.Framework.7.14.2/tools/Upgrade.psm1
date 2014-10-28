#$installPath is the path to the folder where the package is installed
param([string]$installPath)

#	The Update-EPiDataBase and Update-EPiConfig uses by default EPiServerDB connection string name and $package\tools\epiupdates path 
#	to find sql files and transformations file but if it needed to customize the connectionStringname 
#	then a settings.config file can be created (e.g. "settings.config" file under the $package\tools\settings.config).
#	The format of the settings file is like 
#		<settings>
#			<connectionStringName/>
#		</settings>
$setting = "settings.config"
$exportRootPackageName = "EPiUpdatePackage"
$frameworkPackageId = "EPiServer.Framework"
$tools_id = "tools"
$runBatFile = "update.bat"
$updatesPattern = "epiupdates*"
$nl = [Environment]::NewLine

#	This CommandLet update DB 
#	It collects all scripts by default under $packagepath\tools\epiupdates
#   By default uses EPiServerDB connection string name and if the connection string name is different from default (EPiServerDB)
#	then it needs a settings.config (See setting for more information)
Function Update-EPiDatabase
{
	[CmdletBinding()]
    param ( )
	Update "sql" -Verbose:(GetVerboseFlag($PSBoundParameters))
}

#	This CommandLet update web config 
#	It collects all transformation config by default under $packagepath\tools\epiupdates
Function Update-EPiConfig
{
	[CmdletBinding()]
    param ( )

	Update "config" -Verbose:($PSBoundParameters["Verbose"].IsPresent -eq $true)
}

#	This command can be used in the visual studio environment
#	Try to find all packages that related to the project that needs to be updated  
#   Create export package that can be used to update to the site
Function Export-EPiUpdates 
{
 	[CmdletBinding()]
    param ($action = "sql")
	
	$params = Getparams $installPath
	$packages = $params["packages"]
	$sitePath = $params["sitePath"]
	ExportPackages  $action $params["sitePath"]  $params["packagePath"] $packages -Verbose:(GetVerboseFlag($PSBoundParameters))
}

#	This command can be used in the visual studio environment
#	Try to find all packages that related to the project that has update  
#	Find out setting for each package
#   Call epideploy with -a config for each package
Function Update 
{
 	[CmdletBinding()]
    param ($action)

	$params = Getparams $installPath
	$packages = $params["packages"]
	$sitePath = $params["sitePath"]
 
	Update-Packages $action $params["sitePath"] $params["packagePath"] $packages  -Verbose:(GetVerboseFlag($PSBoundParameters))
}


#	This command can be used in the visual studio environment
#	Export all packages that have epiupdates folder under tools path and
#	Create a bat (update.bat) that can be used to call on site
Function ExportPackages
{
 	[CmdletBinding()]
    param ($action, $sitePath, $packagesPath, $packages)

	CreateRootPackage  $exportRootPackageName
	$batFile  = AddUsage 
	$packages |foreach-object -process {
			$packageName = $_.id + "." + $_.version
			$packagePath = join-path $packagesPath $packageName
			$packageToolsPath = join-Path $packagePath $tools_id
			if (test-Path $packageToolsPath){
				$updatePackages = Get-ChildItem -path $packageToolsPath -Filter $updatesPattern
				if($updatePackages -ne $null) {
					foreach($p in $updatePackages) {
						$packageSetting = Get-PackageSetting $p.FullName
						ExportPackage $packagePath $packageName $p $packageSetting
						$des = join-path $packageName $p
						AddDeployCommand $action $batFile  $des $packageSetting
					}
				}
			}
		}
	Add-Content $batFile.FullName ") $($nl)"
	ExportFrameworkTools $packagesPath $packages
	Write-Verbose "A $($runBatFile) file has been created in the $($exportRootPackageName)"
}

Function AddDeployCommand($action, $batFile,  $des, $packageSetting)
{
	if ($action -match "config")
	{
		$command =  "epideploy.exe  -a config -s ""%~f1""  -p ""$($des)\*"" -c ""$($packageSetting["connectionStringName"])"""
		Add-Content $batFile.FullName $command
	}
	if ($action -match "sql")
	{
		$command =  "epideploy.exe  -a sql -s ""%~f1""  -p ""$($des)\*"" -c ""$($packageSetting["connectionStringName"])"""
		Add-Content $batFile.FullName $command
	}
}

Function AddUsage ()
{
	$content = "@echo off  $($nl) if '%1' ==''  ($($nl) echo  USAGE: %0  web application path ""[..\episerversitepath or c:\episerversitepath]"" $($nl)	) else ($($nl)" 
	New-Item (join-path $exportRootPackageName $runBatFile) -type file -force -value $content
}

Function CreateRootPackage ($deployPackagePath)
{
	if (test-path $deployPackagePath)
	{
		remove-Item -path $deployPackagePath -Recurse
	}
	$directory = New-Item -ItemType directory -Path $deployPackagePath
	Write-Host "An Export package is created $($directory.Fullname)"
}

Function ExportPackage($packagpath, $packageName, $updatePackage, $setting)
{
	$packageRootPath = join-path (join-Path $exportRootPackageName  $packageName) $updatePackage.Name
	write-Host "Exporting  $($updatePackage.Name) into $($packageRootPath)"
	$destinationupdatePath  = join-Path $packageRootPath  $package.Name
	copy-Item $updatePackage.FullName  -Destination $destinationupdatePath  -Recurse
	if ($setting["settingPath"])
	{
		copy-Item $setting["settingPath"]  -Destination $packageRootPath 
	}
}

Function GetEpiFrameworkFromPackages($packages)
{
	$framework = $packages | where-object  {$_.id -eq $frameworkPackageId} | Sort-Object -Property version -Descending
	if ($framework -ne $null)
	{
		return $framework.id + "." + $framework.version 
	}
}

Function ExportFrameworkTools($packagePath, $packages)
{

	$epiDeployPath = GetDeployExe $packagesPath  $packages
	copy-Item $epiDeployPath  -Destination $exportRootPackageName
}
 
Function Update-Packages
{
	[CmdletBinding()]
	param($action, $sitePath, $packagesPath, $packages)
	$epiDeployPath = GetDeployExe $packagesPath  $packages
	$packages | foreach-object -process {
					$packagePath = join-path $packagesPath ($_.id + "." + $_.version)
					$packageToolsPath = join-Path $packagePath $tools_id
					if (test-Path $packageToolsPath){
						$updatePackages = Get-ChildItem -path $packageToolsPath -Filter $updatesPattern
						if($updatePackages -ne $null) {
							foreach($p in $updatePackages) {
								$settings = Get-PackageSetting $p.FullName
								Update-Package $p.FullName $action $sitePath $epiDeployPath  $settings  -Verbose:(GetVerboseFlag($PSBoundParameters))
							}
						}
					}
				}
}
 
 Function Update-Package  
  {
	[CmdletBinding()]
    Param ($updatePath, $action, $sitePath, $epiDeployPath, $settings)
	
    if (test-Path $updatePath)
	{
        Write-Verbose "$epiDeployPath  -a $action -s $sitePath  -p $($updatePath)\* -c $($settings["connectionStringName"]) "
		&$epiDeployPath  -a $action -s $sitePath  -p $updatePath\* -c $settings["connectionStringName"]  -d (GetVerboseFlag($PSBoundParameters))
	}
}


#	Find out EPiDeploy from frameworkpackage
Function GetDeployExe($packagesPath, $packages)
 {
	$frameWorkPackage = $packages |  where-object  {$_.id -eq $frameworkPackageId} | Sort-Object -Property version -Descending
	$frameWorkPackagePath = join-Path $packagesPath ($frameWorkPackage.id + "." + $frameWorkPackage.version)
	join-Path  $frameWorkPackagePath "tools\epideploy.exe"
 }

#	Find "settings.config" condig file under the package  
#	The format of the settings file is like 
#		<settings>
#			<connectionStringName/>
#		</settings>
Function Get-PackageSetting($packagePath)
{
	$packageSettings = Get-ChildItem -Recurse $packagePath -Include $setting | select -first 1
	if ($packageSettings -ne $null)
	{
		$xml = [xml](gc $packageSettings)
		if ($xml.settings.SelectSingleNode("connectionStringName") -eq $null)
		{
			$connectionStringName = $xml.CreateElement("connectionStringName")
			$xml.DocumentElement.AppendChild($connectionStringName)
		}
		if ([String]::IsNullOrEmpty($xml.settings.connectionStringName))
		{
			$xml.settings.connectionStringName  = "EPiServerDB"
		}
	}
	else
	{
		$xml = [xml] "<settings><connectionStringName>EPiServerDB</connectionStringName></settings>"
	}
	 @{"connectionStringName" = $($xml.settings.connectionStringName);"settingPath" = $packageSettings.FullName}
}

# Get base params
Function GetParams($installPath)
{
	#Get The current Project
	$project  = Get-project
	$projectPath = Get-ChildItem $project.Fullname
	#site path
	$sitePath = $projectPath.Directory.FullName
	#Get project packages 
	$packages = Get-Package -ProjectName $project.Name
 
	if ($installPath)
	{
		#path to packages 
		$packagePath = (Get-Item -path $installPath -ErrorAction:SilentlyContinue).Parent.FullName
	}

	if (!$packagePath -or (test-path $packagePath) -eq $false)
	{
		throw "There is no 'nuget packages' directory"
	}

	@{"project" = $project; "packages" = $packages; "sitePath" = $sitePath; "packagePath" = $packagePath}
}

Function GetVerboseFlag ($parameters)
{
	($parameters["Verbose"].IsPresent -eq $true)
}

#Exported functions are Update-EPiDataBase Update-EPiConfig
export-modulemember -function  Update-EPiDatabase, Update-EPiConfig, Export-EPiUpdates 