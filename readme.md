# Initial Development Environment Setup
## Install Eclipse 
https://www.eclipse.org/downloads/
Install the latest 64-bit Eclipse version.
During setup, you will need the Enterprise edition.
## Download Repository - Git
### Installing Git
https://git-scm.com/downloads
### Downloading Repository
`git clone https://github.com/treytencarey/Capstone.git`
## Install Tomcat
Download the latest Tomcat version from
https://tomcat.apache.org/download-90.cgi

This will be under Binary Distributions > Core > zip

Save this to the directory where you cloned the repository in the Downloading Repository step (where readme.md is located).

Extract it.

## Setting Up Eclipse
### Workspace
Open Eclipse. The workspace location will be wherever you cloned the repository in the Downloading Repository step (where readme.md is located). Launch here.

### Create Project
In Eclipse, select File > New > Other... > Dynamic Web Project.
Project name: Capstone
Press "Finish".
Select "Open Perspective" only if a popup opens asking.

Close the initial tab. You sshould now see the "Project Explore" section on the left side of the screen.

### Setup Tomcat
In Eclipse, select Window > Show View > Other...
In the filter text, type "Servers". Select the one under Server > Servers.

In this new Servers tab, select the hyperlink ("No servers are available. Click this link to create a new server...").
In the search filter, type "Tomcat". Under Apache, select "Tomcat v9.0 Server", then press "Next >"
Press the "Browse..." button, go to the directory you installed Tomcat to in the Install Tomcat section, then in the tomcat folder, select "Select Folder".
Press "Finish".

In Eclipse, in the Project Explorer section, right-click "Capstone" then select "Properties".
In "Project Facets", select the "Runtimes" tab (on the right-hand side) and make sure that "Apache Tomcat v9.0" is checked. Press "Apply and Close".

In Eclipse, in the Project Explorer section, under Servers > Tomcat, open "web.xml".
Add the following to the very bottom of this file (before `</web-app>`):


        <listener>
            <listener-class>
                project.Main
            </listener-class>
        </listener>


## Starting the Server
In Eclipse, under the Project Explorer, right-click "Capstone", select "Run As" > "Run on Server". Then, select "Finish"