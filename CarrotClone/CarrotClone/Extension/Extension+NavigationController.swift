//
//  Extension+NavigationController.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/07.
//

import UIKit

extension UINavigationController {
    func showNavigationBar() {
        navigationBar.isHidden = false
    }
    
    // 완전 안보임
    func hideNavigationBar() {
        navigationBar.isHidden = true
    }
    
    // 투명하게 만들기 (버튼 등은 보임)
    func changeNavigationBar(isClear: Bool) {
        navigationBar.isHidden = false
        if isClear {
            navigationBar.shadowImage = UIImage()
            navigationBar.setBackgroundImage(UIImage(), for: .default)
        } else {
            navigationBar.shadowImage = nil
            navigationBar.setBackgroundImage(nil, for: .default)
        }
    }
    
    private func doAfterAnimatingTransition(animated: Bool, completion: @escaping (() -> Void)) {
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil, completion: { _ in
                completion()
            })
        } else {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func popViewController(animated: Bool, completion: @escaping (() -> Void)) {
        popViewController(animated: animated)
        doAfterAnimatingTransition(animated: animated, completion: completion)
    }
}
