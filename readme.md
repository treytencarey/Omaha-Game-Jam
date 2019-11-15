# About This Application
Our project will be the go-to hub for everything related to InsertGameHere game jams: game archival, new curation, profile creation, social networking, and so on. 

The main role of our site is to act as a submission portal, from which game jam participants can create pages for their creations. Besides the basic title and description, game pages will allow teams to include their game’s source repo, list other participants as contributors along with their roles, upload screenshots, and more.

Like social media sites, our application offers a robust profile system that will allow participants to customize their profile and display their contributions. Game contributions are like movie credits, listing which participants worked on which game and what role they had. Contributions will be tracked and displayed both on particpants' profiles as well as on the game pages.

Registration is also a major feature. Participants can register for a profile on the website as well as RSVP for the upcoming game jam event. By RSVPing for events, participants can opt into email announcements and stay up to date about upcoming event news. For game jam coordinators, our project will act as a single pane of glass through which to push announcements and moderate participant submissions. Batch emails can be curated and sent to participants.


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
In the search filter, type "Tomcat". Under Apache, select "Tomcat v9.0 Server", then change the Server Name input to "Tomcat", then press "Next >"
Press the "Browse..." button, go to the directory you installed Tomcat to in the Install Tomcat section, then in the tomcat folder, select "Select Folder".
Press "Finish".

In Eclipse, in the Project Explorer section, right-click "Capstone" then select "Properties".
In "Project Facets", select the "Runtimes" tab (on the right-hand side) and make sure that "Apache Tomcat v9.0" is checked. Press "Apply and Close".

## Starting the Server
In Eclipse, under the Project Explorer, right-click "Capstone", select "Run As" > "Run on Server". Then, select "Finish"

# **Generating Documentation with Doxygen**

## Installing Doxygen

http://www.doxygen.nl/download.html

Scroll down to "Sources and Binaries" to install Doxygen.
Since it's open-source, you may also build it yourself using their github. However, this isn't necessary and I just installed using the binaries.

## Generating doxygen

Start the Doxygen GUI after the installation.
You may press File > Open..., then select the "docs/Capstone.doxy" file to use my values. However, these values likely contain my folder structure and will need to be changed.

In the "Wizard" tab in Doxygen under "Project" of the "Topics" treeview (left), set the "Project name" to "Capstone". Set the "Source code ddirectory" to the "Capstone/src/" folder. Set the "Destination directory" to the "docs/" folder.
Select "Mode" on the "Topics" treeview (left). Select the "Optimize for Java or C# output" radio.

Click "Next" until the tab switches to "Run" (or simply select the "Run" tab yourself). Press the "Run doxygen" button. Finally, press the "Show HTML output" button to see the doxygen output.
