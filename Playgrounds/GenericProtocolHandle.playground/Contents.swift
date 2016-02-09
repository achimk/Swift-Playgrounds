//: Playground - noun: a place where people can play

import UIKit

protocol PresentationItem { }

protocol AnyPresenter {
    func _present(item: Any)
}

protocol Presenter: AnyPresenter {
    typealias PresenterType
    func present(item: PresenterType)
}

extension Presenter {
    func _present(item: Any) {
        if let typed = item as? PresenterType {
            present(typed)
        }
    }
}

struct UserPresentationItem: PresentationItem {
    var name = "Chuck"
    var surname = "Norris"
}

class View: Presenter {
    func present(item: UserPresentationItem) {
        print("\(item.name) \(item.surname)")
    }
}

let item = UserPresentationItem()
let anyPresenter: AnyPresenter = View()

anyPresenter._present(item)