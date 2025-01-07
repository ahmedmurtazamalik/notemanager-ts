create database notesManager;
use notesManager;

-- Users Table
CREATE TABLE Users (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    pass VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Notes Table
CREATE TABLE Notes (
    noteId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    noteType ENUM('text', 'list', 'reminder') NOT NULL,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    isTrashed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (userId) REFERENCES Users(userId) ON DELETE CASCADE
);

-- TextNote Table
CREATE TABLE TextNotes (
    textNoteId INT PRIMARY KEY,
    content TEXT NOT NULL,
    FOREIGN KEY (textNoteId) REFERENCES Notes(noteId) ON DELETE CASCADE
);

-- ListNote Table
CREATE TABLE ListNotes (
    listNoteId INT PRIMARY KEY,
    FOREIGN KEY (listNoteId) REFERENCES Notes(noteId) ON DELETE CASCADE
);

-- ListItems Table
CREATE TABLE ListItems (
    listItemId INT AUTO_INCREMENT PRIMARY KEY,
    listNoteId INT NOT NULL,
    itemTitle TEXT NOT NULL,
    isChecked BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (listNoteId) REFERENCES ListNotes(listNoteId) ON DELETE CASCADE
);

-- ReminderNote Table
CREATE TABLE ReminderNotes (
    reminderNoteId INT PRIMARY KEY,
    description TEXT NOT NULL,
    rDate DATE NOT NULL,
    rtime TIME NOT NULL,
    FOREIGN KEY (reminderNoteId) REFERENCES Notes(noteId) ON DELETE CASCADE
);

-- Tags Table
CREATE TABLE Tags (
    tagId INT AUTO_INCREMENT PRIMARY KEY,
    tagName VARCHAR(50) UNIQUE NOT NULL
);

-- NoteTags Table (Junction Table)
CREATE TABLE NoteTags (
    noteId INT NOT NULL,
    tagId INT NOT NULL,
    PRIMARY KEY (noteId, tagId),
    FOREIGN KEY (noteId) REFERENCES Notes(noteId) ON DELETE CASCADE,
    FOREIGN KEY (tagId) REFERENCES Tags(tagId) ON DELETE CASCADE
);

-- Trash Table
CREATE TABLE Trash (
    trashItemId INT AUTO_INCREMENT PRIMARY KEY,
    noteId INT NOT NULL UNIQUE,
    deletedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (noteId) REFERENCES Notes(noteId) ON DELETE CASCADE
);

