
import UIKit

final class NotesViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource = [ShortNote]()
    //private var dataSource = [ ShortNote(text: "a"), ShortNote(text: "b"),ShortNote(text: "c")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTableView()
        setupView()
    }
    private func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        //???
        tableView.pin(to: self.view,  [.left: 16, .top: 16, .right: 16, .bottom: 16])
        
    }
    
    private func setupView() {
        setupTableView()
        setupNavBar()
    }
    
    private func setupNavBar() {
        self.title = "Notes"
        
    }
    
    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
}


//???
extension NotesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        print(2)
        switch indexPath.section {
        case 0:
            print(4)
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier:
                                                                AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                print(1)
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            print(3)
            let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier:
                                                                NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                noteCell.configure(note)
                return noteCell
            }
        }
        print(5)
        return UITableViewCell()
    }
}


extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
                   indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: .none
        ) { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(
            systemName: "trash.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
        )?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension NotesViewController: AddNoteDelegate {
    func newNoteAdded(note: ShortNote) {
        dataSource.insert(note, at: 0)
        tableView.reloadData()
    }
    
}
