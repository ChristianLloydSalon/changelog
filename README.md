This script helps manage changelogs for projects by organizing entries into categories (added, fixed, changed) and facilitating their release.

## Installation
1. Clone the repository
```bash
git clone <repository_url>
cd changelog-script
```

2. Make the script executable
```bash
chmod +x changelog.sh
```

3. Optionally, install the script system-wide (requires sudo/root):
```bash
sudo cp changelog.sh /usr/local/bin/changelog
sudo chmod +x /usr/local/bin/changelog
```

## Usage
### Initialize the changelog folder
To initialize the changelog folder, run the following command:
```bash
./changelog.sh changelog init
```

This command sets up the necessary directory structure for managing changes. It creates a `changelog` directory with subdirectories for each category (added, fixed, changed) and a `unreleased` directory for pending changes.

### Add a new entry
To add a changelog entry under a specific category (added, fixed, changed):
```bash
./changelog.sh changelog added "Added new feature"
./changelog.sh changelog fixed "Fixed critical bug"
./changelog.sh changelog changed "Changed UI layout"
```
Replace "Added new feature", "Fixed critical bug", "Changed UI layout" with your actual changelog messages.

### Preview changelogs
To preview the current changelog entries:
```bash
./changelog.sh changelog preview
```
This command will display all the entries under each category (added, fixed, changed) along with the release version.

### Release changelogs
To release the changelog entries and move them to the `released` directory:
```bash
./changelog.sh changelog release 1.0.0
```
Replace `1.0.0` with the actual version number you are releasing. This command will move all the entries from the `unreleased` directory to the `released` directory and update the release version.
