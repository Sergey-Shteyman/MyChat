//
//  LocalError.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import Foundation

enum LocalError: Error {
    case networkCode
    case networkRefresh
    case networkIsRefreshing

    case refresh

    case keychainSave
    case keychainFetch
    case keychainDelete

    case imageCacheDocumentsDirectory
    case imageCacheData
    case imageCacheFetch

    case regular(Error)
}
