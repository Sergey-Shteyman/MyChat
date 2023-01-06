//
//  Make.swift
//  MyChat
//
//  Created by Сергей Штейман on 15.12.2022.
//


func make<T>(_ object: T, using closure: (inout T) -> Void) -> T {
    var object = object
    closure(&object)
    return object
}
