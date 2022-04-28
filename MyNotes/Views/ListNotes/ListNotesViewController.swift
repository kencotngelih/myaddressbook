//
//  ListNotesViewController.swift
//  MyNotes
//
//  Created by Emmanuel Okwara on 19/08/2021.
//

import UIKit
import CoreData

//dipake di video 028, namun video 029 diremove
//protocol ListNotesDelegate: class {
//    func refreshNotes()
//    func deleteNote(with id: UUID)
//}

class ListNotesViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var notesCountLbl: UILabel!
    private let searchController = UISearchController()
    
    //dipake di video 028, namun video 029 diremove
//    private var allNotes: [Note] = [] {
//        didSet {
//            notesCountLbl.text = "\(allNotes.count) \(allNotes.count == 1 ? "Note" : "Notes")"
//            filteredNotes = allNotes
//        }
//    }
//    private var filteredNotes: [Note] = []
    
    //di video 029
    private var fetchedResultsController: NSFetchedResultsController<Note>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        tableView.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        configureSearchBar()
        
        //dipake di video 028, namun video 029 diremove
        //fetchNotesFromStorage()
        
        //video029
        setupFetchedResultsController()
        
        //video 029
        refreshCountLbl()
    }
    //video029
    func refreshCountLbl() {
        
        //copy dari baris 26 untuk si 29, tapi ada modifikasi
        //notesCountLbl.text = "\(allNotes.count) \(allNotes.count == 1 ? "Note" : "Notes")"
        
        //video 029, copy dari atas dan mengganti allNotes menjadi count
        let count = fetchedResultsController.sections![0].numberOfObjects
        notesCountLbl.text = "\(count) \(count == 1 ? "Customer" : "Customers")"
    }
    
    //video 029
    func setupFetchedResultsController(filter: String? = nil) {
        fetchedResultsController = CoreDataManager.shared.createNotesFetchedResultsController(filter: filter)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        refreshCountLbl()
    }
    
    //dipake di video 028, namun video 029 diremove
//    private func indexForNote(id: UUID, in list: [Note]) -> IndexPath {
//        let row = Int(list.firstIndex(where: { $0.id == id }) ?? 0)
//        return IndexPath(row: row, section: 0)
//    }
    
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
    }
    
    @IBAction func createNewNoteClicked(_ sender: UIButton) {
        goToEditNote(createNote())
    }
    
    private func goToEditNote(_ note: Note) {
        let controller = storyboard?.instantiateViewController(identifier: EditNoteViewController.identifier) as! EditNoteViewController
        controller.note = note
        
        //dipake di video 028, namun video 029 diremove
        //controller.delegate = self
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK:- Methods to implement
    private func createNote() -> Note {
        let note = CoreDataManager.shared.createNote()
        // TODO Save note in database
        
        //dipake di video 028, namun video 029 diremove
        // Update table
        //allNotes.insert(note, at: 0)
        //tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        
        return note
    }
    
    //dipake di video 028, namun video 029 diremove
//    private func fetchNotesFromStorage() {
//        allNotes = CoreDataManager.shared.fetchNotes()
//    }
    
    private func deleteNoteFromStorage(_ note: Note) {
        
        //dipake di video 028, namun video 029 diremove
        //deleteNote(with: note.id)
        
        CoreDataManager.shared.deleteNote(note)
    }
    
    //dipake di video 028, namun video 029 diremove
//    private func searchNotesFromStorage(_ text: String) {
//        allNotes = CoreDataManager.shared.fetchNotes(filter: text)
//        tableView.reloadData()
//    }
}

// MARK: TableView Configuration
extension ListNotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    //video 029
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //dipake di video 028, namun video 029 diremove
        //return filteredNotes.count
        
        //video029
        let notes = fetchedResultsController.sections![section]
        return notes.numberOfObjects
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListNoteTableViewCell.identifier) as! ListNoteTableViewCell
        
        //dipake di video 028, namun video 029 diremove
        //cell.setup(note: filteredNotes[indexPath.row])
        //return cell
        
        //video 029
        let note = fetchedResultsController.object(at: indexPath)
        cell.setup(note: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //dipake di video 028, namun video 029 diremove
        //goToEditNote(filteredNotes[indexPath.row])
        
        //video 029
        let note = fetchedResultsController.object(at: indexPath)
        goToEditNote(note)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //dipake di video 028, namun video 029 diremove
            //deleteNoteFromStorage(filteredNotes[indexPath.row])
            
            //video 029
            let note = fetchedResultsController.object(at: indexPath)
            deleteNoteFromStorage(note)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK:- Search Controller Configuration
extension ListNotesViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search("")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //dipake di video 028, namun video 029 diremove
//        guard let query = searchBar.text, !query.isEmpty else { return }
//        searchNotesFromStorage(query)
        
        //video 029
        search(searchBar.text ?? "")
    }
    
    func search(_ query: String) {
        
        //dipake di video 028, namun video 029 diremove
//        if query.count >= 1 {
//            filteredNotes = allNotes.filter { $0.text.lowercased().contains(query.lowercased()) }
//        } else{
//            filteredNotes = allNotes
//        }
        
        if query.count >= 1 {
            setupFetchedResultsController(filter: query)
        } else{
            setupFetchedResultsController()
        }
        
        tableView.reloadData()
    }
}

//dipake di video 028, namun video 029 diremove
// MARK:- ListNotes Delegate
//extension ListNotesViewController: ListNotesDelegate {
//
//    func refreshNotes() {
//        allNotes = allNotes.sorted { $0.lastUpdated > $1.lastUpdated }
//        tableView.reloadData()
//    }
//
//    func deleteNote(with id: UUID) {
//        let indexPath = indexForNote(id: id, in: filteredNotes)
//        filteredNotes.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//
//        // just so that it doesn't come back when we search from the array
//        allNotes.remove(at: indexForNote(id: id, in: allNotes).row)
//    }
//}

//video029
//MARK:- NSFetchedResultsController Delegates
extension ListNotesViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        default: tableView.reloadData()
        }
        refreshCountLbl()
    }
}
