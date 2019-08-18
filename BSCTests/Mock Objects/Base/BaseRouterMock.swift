//
//  BaseRouterMock.swift
//  BSCTests
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation
import UIKit
@testable import BSC

class BaseRouterMock: BaseRouter {
    init() {
        super.init(navigationController: UINavigationController(navigationBarClass: nil, toolbarClass: nil))
    }
}
