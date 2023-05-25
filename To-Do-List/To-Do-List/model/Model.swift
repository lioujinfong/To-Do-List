//
//  Model.swift
//  To-Do-List
//
//  Created by Mac2_iparknow on 2023/5/25.
//

import Foundation
import SwiftUI

struct Quotable_Model: Codable {
    let _id: String
    let content: String
    let author: String
    let tags: [String]
    let authorSlug: String
    let length: Int
    let dateAdded: String
    let dateModified: String
}

func DateToString(Date:Date) -> (String){
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "en")
    let dateString = formatter.string(from: Date)
    return dateString
}


struct NavigationUtil1 {
    static func popToRootView() {
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popToRootViewController(animated: true)
    }

    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }

        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }

        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }

        return nil
    }
}
