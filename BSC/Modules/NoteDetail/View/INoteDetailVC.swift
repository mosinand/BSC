//
//  INoteDetailVC.swift
//  BSC
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

protocol INoteDetailVC: class {
    func set(text: String)
    func set(loading: Bool)
}
