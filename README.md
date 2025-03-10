# MyToDo

A simple and elegant Flutter to-do list app with local storage. This app allows users to add, edit, complete, and delete tasks, with all data persisted locally using `shared_preferences`.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Releases](#releases)
- [License](#license)

## Features
- **Add Tasks**: Easily add new tasks with a simple form.
- **Edit Tasks**: Modify existing tasks without deleting them.
- **Complete Tasks**: Mark tasks as completed with a checkbox.
- **Delete Tasks**: Remove tasks you no longer need.
- **Local Storage**: Tasks are saved locally using `shared_preferences`, so they persist even after the app is closed.

## Screenshots
<img src="screenshots/home.png" alt="Home Screen" width="250">
<p><em>Add tasks and manage your to-do list.</em></p>

<img src="screenshots/addition.png" alt="Adding Tasks" width="250">
<p><em>Adding tasks to the list.</em></p>

<img src="screenshots/editFunctionality.gif" alt="Editing Tasks" width="250">
<p><em>Editing an existing task.</em></p>

## Installation
Follow these steps to run the app locally:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/zaki-mj/MyToDo.git
   ```
2. **Navigate to the project directory**:
   ```bash
   cd MyToDo
   ```
3. **Install dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```

## Usage
- **Add a Task**: Tap the `+` button to open the add task dialog. Enter the task name and press "Add".
- **Edit a Task**: Long press on a task to modify its content, then save the changes.
- **Complete a Task**: Tap the checkbox next to a task to mark it as completed.
- **Delete a Task**: Swipe left on a task or tap the delete icon to remove it.

## Dependencies
This app uses the following packages:
- [`shared_preferences`](https://pub.dev/packages/shared_preferences): For local storage.

## Releases
Check out the latest releases and download the APK:
[GitHub Releases](https://github.com/zaki-mj/MyToDo/releases)

## License
This project was made for the purpose of learning Flutter and is free to use by anyone.

---

Made with ❤️ by **Zakaria**