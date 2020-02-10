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
    
    /// Change the root view controller of the window
    ///
    /// - Parameters:
    ///   - controller: controller to set
    ///   - options: options of the transition
    func setRootViewController(_ controller: UIViewController, options: TransitionOptions = TransitionOptions()) {
        var transitionWnd: UIWindow?
        if let background = options.background {
            transitionWnd = UIWindow(frame: UIScreen.main.bounds)
            switch background {
            case .customView(let view):
                transitionWnd?.rootViewController = UIViewController.newController(withView: view, frame: transitionWnd!.bounds)
            case .solidColor(let color):
                transitionWnd?.backgroundColor = color
            }
            transitionWnd?.makeKeyAndVisible()
        }
        
        // Make animation
        self.layer.add(options.animation, forKey: kCATransition)
        self.rootViewController = controller
        self.makeKeyAndVisible()
        
        if let wnd = transitionWnd {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 + options.duration) {
                wnd.removeFromSuperview()
            }
        }
    }
    
    /// Transition Options
    struct TransitionOptions {
        /// Curve of animation
        ///
        /// - linear: linear
        /// - easeIn: ease in
        /// - easeOut: ease out
        /// - easeInOut: ease in - ease out
        public enum Curve {
            case linear
            case easeIn
            case easeOut
            case easeInOut
            
            /// Return the media timing function associated with curve
            internal var function: CAMediaTimingFunction {
                let key: String!
                switch self {
                case .linear: key = CAMediaTimingFunctionName.linear.rawValue
                case .easeIn: key = CAMediaTimingFunctionName.easeIn.rawValue
                case .easeOut: key = CAMediaTimingFunctionName.easeOut.rawValue
                case .easeInOut: key = CAMediaTimingFunctionName.easeInEaseOut.rawValue
                }
                return CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: key!))
            }
        }
        
        /// Direction of the animation
        ///
        /// - fade: fade to new controller
        /// - toTop: slide from bottom to top
        /// - toBottom: slide from top to bottom
        /// - toLeft: pop to left
        /// - toRight: push to right
        public enum Direction {
            case fade
            case toTop
            case toBottom
            case toLeft
            case toRight
            
            /// Return the associated transition
            ///
            /// - Returns: transition
            internal func transition() -> CATransition {
                let transition = CATransition()
                transition.type = CATransitionType.push
                switch self {
                case .fade:
                    transition.type = CATransitionType.fade
                    transition.subtype = nil
                case .toLeft:
                    transition.subtype = CATransitionSubtype.fromLeft
                case .toRight:
                    transition.subtype = CATransitionSubtype.fromRight
                case .toTop:
                    transition.subtype = CATransitionSubtype.fromTop
                case .toBottom:
                    transition.subtype = CATransitionSubtype.fromBottom
                }
                return transition
            }
        }
        
        /// Background of the transition
        ///
        /// - solidColor: solid color
        /// - customView: custom view
        public enum Background {
            case solidColor(_: UIColor)
            case customView(_: UIView)
        }
        
        /// Duration of the animation (default is 0.20s)
        public var duration: TimeInterval = 0.20
        
        /// Direction of the transition (default is `toRight`)
        public var direction: TransitionOptions.Direction = .toRight
        
        /// Style of the transition (default is `linear`)
        public var style: TransitionOptions.Curve = .linear
        
        /// Background of the transition (default is `nil`)
        public var background: TransitionOptions.Background?
        
        /// Initialize a new options object with given direction and curve
        ///
        /// - Parameters:
        ///   - direction: direction
        ///   - style: style
        public init(direction: TransitionOptions.Direction = .toRight, style: TransitionOptions.Curve = .linear) {
            self.direction = direction
            self.style = style
        }
        
        public init() {}
        
        /// Return the animation to perform for given options object
        internal var animation: CATransition {
            let transition = self.direction.transition()
            transition.duration = self.duration
            transition.timingFunction = self.style.function
            return transition
        }
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

