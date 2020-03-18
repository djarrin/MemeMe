//
//  MemeHistoryDelegate.swift
//  MemeMe
//
//  Created by David Jarrin on 3/18/20.
//  Copyright © 2020 David Jarrin. All rights reserved.
//

import UIKit

class MemeHistoryDelegate: UIResponder, UIApplicationDelegate {
    
    func getNumberOfMemes(elements: [Meme]) -> Int {
        return elements.count
    }
}
