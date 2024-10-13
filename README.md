# Flutter Explorer
A Windows Explorer-like web page.
- The page is split horizontally into two panels.
- The left panel contains the folder structure
- The right panel contains the direct sub folders for the selected folder on the left panel.

The application should contain the following items:
- **Database**
	- Contains the folder and file data.
	- Must be an SQL database (not a NoSQL one), EXCEPT SQLite.
- **Backend**
	- Serves an API for the frontend.
	- Loads data from the database upon API request.
	- Can use any language, any framework, any library.
- **Frontend**
	- Consumes the backend API to display the page.
	- Uses frontend a web framework such as Vue, React, Angular, Svelte, Solid, etc.
	- Can use any libraries, EXCEPT the library to display folder structures or similar. You must build the folder structure display from scratch.

- **Upon load**, the frontend requests the data from the backend and displays the complete folder structure (all folders) on the left panel with nothing on the right panel.
- **Upon clicking one of the folders on the left panel**, the right panel displays the list of direct sub folders of the clicked folder.


## Implemented Features
- **Refresh button**
- **Up one level button**
- **Full path indicator**
- **List and Grid view option**