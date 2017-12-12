//
//  LoadMoreFooter.swift
//  Elegant
//
//  Created by Steve on 01/12/2017.
//  Copyright © 2017 KingCQ. All rights reserved.
//

import UIKit

public class DefaultLoadMoreFooter: RefreshComponent {
    
    override func setup() {
        super.setup()
        self.height = Const.Footer.height
        setupSubviews()
    }
    
    func setupSubviews() {
        
    }
    override func scrollViewContentOffset(did change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffset(did: change)
//        guard let scrollView = self.scrollView else {
//            return
//        }
//        if self.state == .refreshing {
//        }
//        self.scrollViewOriginalInset = scrollView.contentInset
//        let currentOffsetY = scrollView.offsetY
//        let beginOffsetY = -self.scrollViewOriginalInset.top
//        if currentOffsetY > beginOffsetY { return }
//        let normalOffsetY = beginOffsetY - self.height - 20
//        let pullingPercent = (beginOffsetY - currentOffsetY) / self.height
//        print("🌹contentOffset.y==\(scrollView.contentOffset.y)", "🌹beginOffsetY==\(beginOffsetY)", "🌹normalOffsetY==\(normalOffsetY)")
        
//        if scrollView.isDragging == true {
//            self.pullingPercent = pullingPercent
//            if self.state == .nomal {
//            }
//            if self.state == .nomal && scrollView.offsetY < -64 {
//                self.state = .pulling
//            } else if self.state == .pulling && scrollView.offsetY >= -64 {
//                self.state = .nomal
//            }
//        } else if self.state == .pulling {
//            self.beginRefreshing()
//        } else if pullingPercent < 1 {
//            self.pullingPercent = pullingPercent
//        }
    }
    
    override func setState(_ state: RefreshState) {
        super.setState(state)
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
        DispatchQueue.main.async { [weak self] in
            self?.setNeedsLayout()
        }
    }
    
    override func scrollViewContentSize(did change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentSize(did: change)
        self.y = self.scrollView?.contentSize.height ?? self.y
    }
    
    
}
