EPiServer.CMS.UI.Core


Installation
============


Starting from release 7.6, EPiServer CMS UI components has been converted to a standard nuget package. 
This means that content files and assemblies will be added to the project. As a part of the conversion 
the previously installed add-on package needs to be removed.

There are several project configuration steps performed as part of the package installation; these
are documented below. If any of the configuration steps fail during the installation a message box
will be displayed describing the issue.


Remove add-on assemblies
------------------------

This step removes EPiServer.Shell.UI.dll, EPiServer.Cms.Shell.UI.dll and EPiServer.Cms.Shell.UI.Sources.dll 
(if installed) from the modulesbin folder. If you have reconfigured the probing path for your site, then 
these assemblies will be removed from the configured location.

If you receive an error during this step, then the process installing the nuget package does not
have permission to delete the files. In this case, a user with the appropriate permissions will
need to delete EPiServer.Shell.UI.dll, EPiServer.Cms.Shell.UI.dll and EPiServer.Cms.Shell.UI.Sources.dll 
(if installed) from the modulesbin folder manually.

Update packages.config
----------------------

This step removes the Shell, CMS, CMS.Sources and EPiServer.Suite package entries from the packages.config 
file in order to unregister them from the add-on system.

If you receive an error during this step, then the process installing the nuget package does not
have permission to read or write the file. In this case, a user with the appropriate permissions
will need to remove the Shell, CMS, CMS.Sources, EPiServer.Suite package entries manually. By default, 
the packages.config file is located inside the modules folder in appdata.

Remove add-on folders
---------------------

This step removes the Shell, CMS, CMS.Sources, EPiServer.Suite folders and their contents from the modules folder.

If you receive an error during this step, then the process installing the nuget package does not
have permission to delete the folders or their contents. In this case, a user with the appropriate
permissions will need to remove the Shell, CMS, CMS.Sources, EPiServer.Suite folders manually. By default, 
these folders are located inside the modules folder in appdata.