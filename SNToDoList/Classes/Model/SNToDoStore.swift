//
//  SNToDoStore.swift
//  SNToDoList
//
//  Created by 尚振兴 on 2021/6/23.
//

import Foundation

let dummy = [
    "Buy the milk",
    "Take my dog",
    "Rent a car"
]

struct ToDoStore {
    static let shared = ToDoStore()
    func getToDoItems(completionHandler: (([String]) -> Void)?){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            completionHandler?(dummy)
        }
    }
}

