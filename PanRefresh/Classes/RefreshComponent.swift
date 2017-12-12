//
//  RefreshComponent.swift
//  Elegant
//
//  Created by Steve on 01/12/2017.
//  Copyright © 2017 KingCQ. All rights reserved.
//

import UIKit


public class RefreshComponent: UIView {
    
    public var scrollView: UIScrollView?
    var scrollViewOriginalInset: UIEdgeInsets = .zero
    
    public var state: RefreshState = RefreshState.nomal {
        willSet {
            if state == newValue {return}
        }
        didSet {
            setState(state)
        }
    }
    
    var pullingPercent: CGFloat = 1.0 {
        didSet {
        }
    }
    
    var pan: UIPanGestureRecognizer?
    
    var hasObservers: Bool = false
    
    var isRefreshing: Bool {
        return self.state == .willRefresh || self.state == .refreshing
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        autoresizingMask = .flexibleWidth
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if hasObservers { self.removeObservers()}
        if let superview = newSuperview as? UIScrollView {
            self.scrollView?.alwaysBounceVertical = true
            self.x = superview.contentInsetLeft
            self.width = superview.width
            self.scrollViewOriginalInset = superview.contentInset
            self.addObservers()
            hasObservers = true
        }
    }
    
    func addObservers() {
        [
            Const.Observers.Keypath.contentOffset,
            Const.Observers.Keypath.contentSize,
        ].forEach {
            self.scrollView?.addObserver(
                self,
                forKeyPath: $0,
                options: [.new],
                context: nil
            )
        }
        self.pan = self.scrollView?.panGestureRecognizer
        self.pan?.addObserver(
            self,
            forKeyPath: Const.Observers.Keypath.panState,
            options: [.new],
            context: nil
        )
    }
    
    func removeObservers() {
        self.scrollView?.removeObserver(
            self,
            forKeyPath: Const.Observers.Keypath.contentSize
        )
        self.scrollView?.removeObserver(
            self,
            forKeyPath: Const.Observers.Keypath.contentOffset
        )
        self.pan?.removeObserver(
            self,
            forKeyPath: Const.Observers.Keypath.panState
        )
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if self.isUserInteractionEnabled == false { return }
        switch keyPath! {
        case Const.Observers.Keypath.contentOffset:
            if self.isHidden {return}
            scrollViewContentOffset(did: change)
        case Const.Observers.Keypath.contentSize:
            scrollViewContentSize(did: change)
        case Const.Observers.Keypath.panState:
            if self.isHidden {return}
            scrollViewPanState(did: change)
        default:
            break
        }
    }
    
    func scrollViewContentOffset(did change: [NSKeyValueChangeKey : Any]?){}
    func scrollViewContentSize(did change: [NSKeyValueChangeKey : Any]?) {}
    func scrollViewPanState(did change: [NSKeyValueChangeKey : Any]?) {}
    
    func setState(_ state: RefreshState) {
        switch state {
        case .nomal:
            break
        case .pulling:
            break
        case .willRefresh:
            break
        case .refreshing:
            break
        case .nomore:
            break
        }
    }
    
    func beginRefreshing() {
        if self.window != nil {
            self.state = .refreshing
        } else {
            if self.state != .refreshing {
                self.state = .willRefresh
                self.setNeedsDisplay()
            }
        }
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if self.state == .willRefresh {
            self.state = .refreshing
        }
    }
    
    public func beginRefreshing(_ action: (()->Void)? = nil) {
        beginRefreshing()
    }
    
    func endRefreshing() {
        
    }
    
    public func endRefreshing(_ action: (()->Void)? = nil) {
        endRefreshing()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


public enum RefreshState {
    case nomal
    case pulling
    case willRefresh
    case refreshing
    case nomore
}

struct Const {
    static let animationDuration = 0.25
    struct Header {
        static let height: CGFloat = 54.0
    }
    
    struct Footer {
        static let height: CGFloat = 44.0
    }
    
    struct Observers {
        struct Keypath {
            static let contentOffset = "contentOffset"
            static let contentSize = "contentSize"
            static let panState = "panState"
        }
    }
}
