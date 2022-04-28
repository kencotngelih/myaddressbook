//
//  EditNoteViewController.swift
//  MyNotes
//
//  Created by Emmanuel Okwara on 19/08/2021.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    static let identifier = "EditNoteViewController"
    
    var note: Note!
    
    //dipake di video 028, namun video 029 diremove
    //weak var delegate: ListNotesDelegate?

    @IBOutlet weak private var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = note?.text
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK:- Methods to implement
    private func updateNote() {
        // TODO update the note in database
        print("Updating note")
        CoreDataManager.shared.save()
        note.lastUpdated = Date()
        
        //dipake di video 028, namun video 029 diremove
        //delegate?.refreshNotes()
    }
    
    private func deleteNote() {
        
        //dipake di video 028, namun video 029 diremove
        //delegate?.deleteNote(with: note.id)
        
        CoreDataManager.shared.deleteNote(note)
    }
}

// MARK:- UITextView Delegate
extension EditNoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.text = textView.text
        if note?.title.isEmpty ?? true {
            deleteNote()
        } else {
            updateNote()
        }
    }
}
