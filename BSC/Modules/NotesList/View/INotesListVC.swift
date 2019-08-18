//
//  INotesListVC.swift
//  BSC
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

protocol INotesListViewController: class {
    func set(loading: Bool)
    func show(notes: [Note])
    func endEditing()
}
