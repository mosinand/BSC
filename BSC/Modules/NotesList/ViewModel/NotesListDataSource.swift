//
//  NotesListDataSource.swift
//  BSC
//
//  Created by Andrey Mosin on 17/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation
import UIKit

class NotesListDataSouce: NSObject, UITableViewDataSource {
    
    private let removeCallback: ((Note) -> Void)
    
    init(removeCallback: @escaping ((Note) -> Void)) {
        self.removeCallback = removeCallback
    }
    
    private var notes = [Note]()
    
    func set(notes: [Note]) {
        self.notes = notes
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let note = notes[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NotesListCell", for: indexPath) as? NotesListCell {
            cell.configureWith(title: note.title)
            cell.tag = note.id
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        removeCallback(notes[indexPath.row])
    }
}
