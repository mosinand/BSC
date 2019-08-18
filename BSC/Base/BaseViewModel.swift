//
//  BaseViewModel.swift
//  BSC
//
//  Created by Andrey Mosin on 17/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation


protocol BaseViewModel: class {
    func didLoad()
}

extension BaseViewModel {
    func didLoad() { }
}
