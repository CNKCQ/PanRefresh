//
//  RefreshHeader.swift
//  Elegant
//
//  Created by Steve on 01/12/2017.
//  Copyright © 2017 KingCQ. All rights reserved.
//

import UIKit

public class DefaultRefreshHeader: RefreshComponent {
    
    var insetTop: CGFloat = 0
    
    override func setup() {
        super.setup()
        self.height = Const.Header.height
        setupSubviews()
    }
    
    override func scrollViewContentOffset(did change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffset(did: change)
        guard let scrollView = self.scrollView else {
            return
        }
        if self.state == .refreshing {
            var tempInsetTop: CGFloat = -scrollView.offsetY > self.scrollViewOriginalInset.top ? -scrollView.offsetY : self.scrollViewOriginalInset.top
            tempInsetTop = tempInsetTop > self.height + self.scrollViewOriginalInset.top ? self.height + self.scrollViewOriginalInset.top : tempInsetTop
            self.insetTop = self.scrollViewOriginalInset.top - tempInsetTop
            return
        }
        //        self.scrollViewOriginalInset = scrollView.contentInset
        //        let currentOffsetY = scrollView.offsetY
        //        let beginOffsetY = -self.scrollViewOriginalInset.top
        //        if currentOffsetY > beginOffsetY { return }
        //        let normalOffsetY = beginOffsetY - self.height - 20
        //        let pullingPercent = (beginOffsetY - currentOffsetY) / self.height
        
        if scrollView.isDragging == true {
            self.pullingPercent = pullingPercent
            if self.state == .nomal {

            }
            if self.state == .nomal && scrollView.offsetY < -64-44 {
                self.state = .pulling
            } else if self.state == .pulling && scrollView.offsetY >= -64-44 {
                self.state = .nomal
            }
        } else if self.state == .pulling {
            if self.isRefreshing == false && (scrollView.offsetY <= -CGFloat(108)) {
                self.beginRefreshing()
            }
        } else if pullingPercent < 1 {
            self.pullingPercent = pullingPercent
        }
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
    }
    
    public override func beginRefreshing(_ action: (() -> Void)?) {
        super.beginRefreshing(action)
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        print("🌹--")
        if self.state == .refreshing {
            self.state = .nomal
        } else {
            
        }
    }
    
    public override func endRefreshing(_ action: (() -> Void)?) {
        super.endRefreshing(action)
    }
    
    override func setState(_ state: RefreshState) {
        super.setState(state)
        switch state {
        case .nomal:
            self.scrollView?.contentInsetTop += self.insetTop
            break
        case .pulling:
            break
        case .willRefresh:
            break
        case .refreshing:
            let top = self.scrollViewOriginalInset.top + self.height
            self.scrollView?.contentInsetTop = top
            self.scrollView?.offsetY = -top
            break
        case .nomore:
            break
        }
        DispatchQueue.main.async { [weak self] in
            self?.setNeedsLayout()
        }
    }
    
    func delay(after: TimeInterval, execute: @escaping () -> Void) {
        let delayTime = DispatchTime.now() + after
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            execute()
        }
    }
    
    func setupSubviews() {
        
        
      self.y = -self.height
    }
}
