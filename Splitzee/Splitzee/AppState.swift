//
//  File.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/17/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import Foundation
import UIKit

class AppState: NSObject {

    static let sharedInstance = AppState()
    
    var signedIn = false
}
