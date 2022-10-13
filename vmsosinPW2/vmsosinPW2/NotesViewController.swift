//
//  NotesViewController.swift
//  vmsosinPW2
//
//  Created by Sosin Vladislav on 06.10.2022.
//

import UIKit

extension NotesViewController: UITableViewDataSource {
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        return 2
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(
                withIdentifier: AddNoteCell.reuseIdentifier,
                for: indexPath
            ) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(
                withIdentifier: NoteCell.reuseIdentifier,
                for: indexPath
            ) as? NoteCell {
                noteCell.configure(note: note)
                return noteCell
            }
        }
        return UITableViewCell()
    }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        if indexPath.section > 0 {
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
        return nil
    }
}

extension NotesViewController: AddNoteDelegate {
    func newNoteAdded(note: ShortNote) {
        dataSource.insert(note, at: 0)
        var addStringDataSource = [String]()
        for item in dataSource {
            addStringDataSource.append(item.text)
        }
        userDefaults.setValue(addStringDataSource, forKey: "dataSource")
        tableView.reloadData()
    }
}

final class NotesViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource = [ShortNote]()
    private let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let data = userDefaults.value(forKey: "dataSource") as? [String] {
            for item in data {
                let shortNote = ShortNote(text: item)
                dataSource.append(shortNote)
            }
        }
        tableView.alwaysBounceVertical = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        setupView()
    }
    
    private func setupView() {
        setupTableView()
        setupNavBar()
    }
    
    private func setupTableView() {
        tableView.register(
            AddNoteCell.self,
            forCellReuseIdentifier: AddNoteCell.reuseIdentifier
        )
        tableView.register(
            NoteCell.self,
            forCellReuseIdentifier: NoteCell.reuseIdentifier
        )
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.pin(to: self.view)
    }
    
    private func setupNavBar() {
        self.title = "Notes"
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(
            self,
            action: #selector(dismissViewController(_:)),
            for: .touchUpInside
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    @objc
    func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        var deleteStringDataSource = [String]()
        for item in dataSource {
            deleteStringDataSource.append(item.text)
        }
        userDefaults.setValue(deleteStringDataSource, forKey: "dataSource")
        tableView.reloadData()
    }
}
