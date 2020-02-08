//
//  UIWindow+Extension.swift
//  MemberAwards
//
//  Created by Chris Ferdian on 08/02/20.
//  Copyright © 2020 Chrizers. All rights reserved.
//
import UIKit

public extension UIWindow {
    
    /**
     
     Returns the top-most view controller that can present other view controllers modally.
     
     **Examples:**
     
     - `UINavigationController0` -> `UIViewController0` -> `UIViewController1` will return `UINavigationController0`.
     
     - `UINavigationController0` -> `UIViewController0` -(modally)-> `UIViewController1` will return `UIViewController1`.
     
     */
    var currentViewController: UIViewController? {
        
        var viewController: UIViewController? = rootViewController
        
        while true {
            
            if let presentedViewController = viewController?.presentedViewController {
                viewController = presentedViewController
            } else {
                break
            }
        }
        
        return viewController
    }
    
    /**
     See [Stack Overflow](http://stackoverflow.com/a/27153956)
     
     Usage with transition:
     
     ```
     let transition = CATransition()
     transition.type = kCATransitionFade
     window.setRootViewControllerTo(destinationViewController, withTransition: transition)
     ```
     */
    func setRootViewController(to newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {
        
        let previousViewController = rootViewController
        
        if let transition = transition {
            // Add the transition
            layer.add(transition, forKey: kCATransition)
        }
        
        rootViewController = newRootViewController
        
        // Update status bar appearance using the new view controllers appearance - animate if needed
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration(), animations: {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            })
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }
        
        /// The presenting view controllers view doesn't get removed from the window as it's currently transitioning and presenting a view controller
        if let transitionViewClass = NSClassFromString("UITransitionView") {
            for subview in subviews where subview.isKind(of: transitionViewClass) {
                subview.removeFromSuperview()
            }
        }
        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismiss(animated: false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
    
    func setRootViewController(to newRootViewController: UIViewController, withTransitionType transitionType: TransitionType, andSubtype transitionSubtype: TransitionSubType? = nil) {
        
        setRootViewController(to: newRootViewController, withTransition: transitionType.transition(with: transitionSubtype))
    }
    
    /**
     Instantiates initial view controller of given storyboard and sets it using UIWindow.setRootViewControllerTo(_:withTransition:)
     */
    func setRootViewController(toInitialViewControllerOf storyboard: UIStoryboard, withTransition transition: CATransition? = nil) {
        
        let vc = storyboard.instantiateInitialViewController()!
        setRootViewController(to: vc, withTransition: transition)
    }
    func setRootViewController(toInitialViewControllerOf storyboard: UIStoryboard, withTransitionType transitionType: TransitionType? = nil, andSubtype transitionSubtype: TransitionSubType? = nil) {
        
        setRootViewController(toInitialViewControllerOf: storyboard, withTransition: transitionType?.transition(with: transitionSubtype))
    }
}

public enum TransitionType {
    
    case fade
    case moveIn
    case push
    case reveal
    
    var identifier: String {
        
        switch self {
        case .fade: return CATransitionType.fade.rawValue
        case .moveIn: return CATransitionType.moveIn.rawValue
        case .push: return CATransitionType.push.rawValue
        case .reveal: return CATransitionType.reveal.rawValue
        }
    }
    
    func transition(with subtype: TransitionSubType?) -> CATransition {
        
        return CATransition(type: self, subtype: subtype)
    }
    
}

public enum TransitionSubType {
    
    case fromBottom
    case fromLeft
    case fromRight
    case fromTop
    
    var identifier: String {
        
        switch self {
        case .fromBottom: return CATransitionSubtype.fromBottom.rawValue
        case .fromLeft: return CATransitionSubtype.fromLeft.rawValue
        case .fromRight: return CATransitionSubtype.fromRight.rawValue
        case .fromTop: return CATransitionSubtype.fromTop.rawValue
        }
    }
    
}

private extension CATransition {
    
    convenience init(type: TransitionType, subtype: TransitionSubType?) {
        self.init()
        
        self.type = CATransitionType(rawValue: type.identifier)
        self.subtype = (subtype?.identifier).map { CATransitionSubtype(rawValue: $0) }
    }
}

