# swifty-protein
 This project is to make an application that load the ligand through the [RCSB](https://www.rcsb.org/) and create 3D animated scenes using **SceneKit** frame Work.
**Mandatory :**
- Login View Controller
  - [X] Must be able to login with Touch ID using a button
  - [X] Display popup warning when login fails
  - [X] Touch ID button should be hidden if the iPhone is not compatible
  - [X] If the Home button is pressed the app will relaunch the app without quitting it
- Protein List View Controller
  - [X] Must list all the ligands provied in ligands.txt (resources were given)
  - [X] Search a ligand through the list
  - [X] Display a warning popup if the ligand cannot load from [RCSB](https://www.rcsb.org/)
  - [X] Display the spinning wheel of the activity monitor when the ligand is loading
- Protein View Controller
  - [X] Display the ligand model in 3D
  - [X] Use CPK coloring
  - [X] Represent the ligand using balls and sticks model
  - [X] Display the atom type(C, H, O, etc) when an atom is clicked
  - [X] Share modelization through a 'Share' button
  - [X] Be able to zomm, rotate, etc with the ligand in Scene Kit

**Bonus :**
- [X] Use of custom cells
- [X] Design
- [X] Custom popup
- [X] Other modelization available
- [X] Custom message when sharing screenshot
