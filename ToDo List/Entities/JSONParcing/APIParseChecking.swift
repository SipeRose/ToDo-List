//
//  SecondParceChecking.swift
//  ToDo List
//
//  Created by Никита Волков on 27.01.2025.
//

import UIKit

// MARK: Checking for the first API request

func saveFirstParse() {
    let defaults = UserDefaults.standard
    defaults.set(true, forKey: "FirstParseDone")
}

func checkFirstParse() -> Bool? {
    let defaults = UserDefaults.standard
    let result = defaults.object(forKey: "FirstParseDone") as? Bool
    return result
}
