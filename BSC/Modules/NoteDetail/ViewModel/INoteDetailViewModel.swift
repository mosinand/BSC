//
//  INoteDetailViewModel.swift
//  BSC
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

protocol INoteDetailViewModel: BaseViewModel {
    func textDidChange(text: String)
}
