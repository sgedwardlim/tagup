//
//  NoteTagViewModel.swift
//  tagup
//
//  Created by Edward on 4/21/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class NoteTagViewModel {
    
    var titleText: String {
        guard let title = noteTag?.title else {
            return ""
        }
        return title
    }
    
    var notesText: String {
        guard let notes = noteTag?.notes else {
            return ""
        }
        return notes
    }
    
    var noteTag: NoteTag?
    
    init(noteTag: NoteTag?) {
        self.noteTag = noteTag
    }
    
    func saveNoteTag(_ title: String?, _ notes: String?) {
        let delegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = delegate.persistentContainer.viewContext
        // Check to see if the imageTag variable is set, if set,
        // then edit the current tag, else create a new tag to be saved
        if noteTag == nil {
            noteTag = NoteTag(context: context)
        }
        
        noteTag?.title = title
        noteTag?.notes = notes

        // usually the saving of the data should be handled by DataManager,
        // but coredata dosent allow for saving of data in such a way
        delegate.saveContext()
    }
    
    func deleteNoteTag() {
        guard let tag = noteTag else { return }
        DataManager.shared.deleteTag(tag)
    }
}
