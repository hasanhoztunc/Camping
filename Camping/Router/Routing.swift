//
//  Routing.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

typealias NavigationBackClosure = (() -> ())

protocol Routing {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack: NavigationBackClosure?)
    func pop(_ isAnimated: Bool)
    func popToRoot(_ isAnimated: Bool)
    func present(_ drawable: Drawable, isAnimated: Bool, onDismiss: NavigationBackClosure?)
}
