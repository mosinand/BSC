//
//  NotesListVC.swift
//  BSC
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import UIKit

class NotesListVC: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    private let edititngDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finishEditing))
    private let viewModel: INotesListViewModel
    private let dataSource: NotesListDataSouce

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = dataSource
            
            tableView.register(UINib(nibName: "NotesListCell", bundle: nil), forCellReuseIdentifier: "NotesListCell")
        }
    }

    @IBOutlet private weak var createNewNoteButton: UIButton!
    
    @IBAction private func createNewNotePressed() {
        viewModel.createNote()
    }
    
    init(viewModel: INotesListViewModel) {
        self.viewModel = viewModel
        self.dataSource = NotesListDataSouce(removeCallback: viewModel.remove(note:))
        
        super.init(nibName: "NotesListVC", bundle: nil)
        
        self.title = "Notes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.willAppear()
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        switchButtons(isEditingEnabled: false)
        addActivityIndicator()
    }
    
    private func addActivityIndicator() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: activityIndicator)
    }
    
    private func switchButtons(isEditingEnabled: Bool) {
        let barButton = UIBarButtonItem(barButtonSystemItem: isEditingEnabled ? .done : .edit,
                                     target: self,
                                     action: isEditingEnabled ? #selector(finishEditing) : #selector(enableEditing))
        navigationItem.rightBarButtonItem = barButton
        createNewNoteButton.isHidden = isEditingEnabled
    }
    
    @objc
    private func enableEditing() {
        tableView.setEditing(true, animated: true)
        switchButtons(isEditingEnabled: true)
    }
    
    @objc
    private func finishEditing() {
        tableView.setEditing(false, animated: true)
        switchButtons(isEditingEnabled: false)
    }
}

extension NotesListVC: INotesListViewController {
    
    func show(notes: [Note]) {
        dataSource.set(notes: notes)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func set(loading: Bool) {
        DispatchQueue.main.async {
            loading ? self.activityIndicator.startAnimating()
                : self.activityIndicator.stopAnimating()
        }
    }
    
    func endEditing() {
        finishEditing()
    }
}

extension NotesListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        viewModel.selectNoteWith(id: cell.tag)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
