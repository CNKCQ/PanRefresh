//
//  UIScrollView+Refresh.swift
//  PanRefresh
//
//  Created by Steve on 02/12/2017.
//

public extension UIScrollView {
    
    private struct AssociatedKeys {
        static var headerKey = "UIScrollView.refreshHeader"
        static var footerKey = "UIScrollView.loadMoreFooter"
        static var dataCountKey = "UIScrollView.dataCountKey"
    }
    
    var refreshHeader: RefreshComponent? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.headerKey) as? RefreshComponent
        }
        set (header) {
            refreshHeader?.removeFromSuperview()
            willChangeValue(forKey: AssociatedKeys.headerKey)
            objc_setAssociatedObject(self, &AssociatedKeys.headerKey, header, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            didChangeValue(forKey: AssociatedKeys.headerKey)
            refreshHeader?.scrollView = self
            insertSubview(refreshHeader!, at: 0)
        }
    }
    
    var loadMoreFooter: RefreshComponent? {
        
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.footerKey) as? RefreshComponent
        }
        
        set (footer) {
            loadMoreFooter?.removeFromSuperview()
            willChangeValue(forKey: AssociatedKeys.footerKey)
            objc_setAssociatedObject(self, &AssociatedKeys.footerKey, footer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            didChangeValue(forKey: AssociatedKeys.footerKey)
            loadMoreFooter?.scrollView = self
            insertSubview(loadMoreFooter!, at: 0)
        }
    }
    
    var dataCount: Int {
        var count = 0
        switch self {
        case is UITableView:
            count = (self as! UITableView).numberOfItems
        case is UICollectionView:
            count = (self as! UICollectionView).numberOfItems
        default:
            break
        }
        return count
    }
    
}

public extension UITableView {
    
    /// Returns the items of the tableView
    var numberOfItems: Int {
        return (0 ..< numberOfSections).reduce(0) {
            $0 + numberOfRows(inSection: $1)
        }
    }
}

public extension UICollectionView {
    
    /// Returns the items of the collectionView
    var numberOfItems: Int {
        return (0 ..< numberOfSections).reduce(0) {
            $0 + numberOfItems(inSection: $1)
        }
    }
}

public extension UIScrollView {
    
    /// `set` `get` the content's offsetX
    var offsetX: CGFloat {
        get {
            return contentOffset.x
        } set {
            contentOffset = CGPoint(x: newValue, y: contentOffset.y)
        }
    }
    
    /// `set` `get` the content's offsetY
    var offsetY: CGFloat {
        get {
            return contentOffset.y
        } set {
            contentOffset = CGPoint(x: contentOffset.x, y: newValue)
        }
    }
    
    /// `set` `get` the content's height
    var contentHeight: CGFloat {
        get {
            return contentSize.height
        } set {
            contentSize = CGSize(width: contentSize.width, height: newValue)
        }
    }
    
    /// `set` `get` the content's width
    var contentWidth: CGFloat {
        get {
            return contentSize.height
        } set {
            contentSize = CGSize(width: newValue, height: contentSize.height)
        }
    }
    
    
    /// `set` `get` the contentInset's top
    var contentInsetTop: CGFloat {
        get {
            return contentInset.top
        } set {
            contentInset = UIEdgeInsets(top: newValue, left: contentInset.left, bottom: contentInset.bottom, right: contentInset.right)
        }
    }
    
    /// `set` `get` the contentInset's bottom
    var contentInsetBottom: CGFloat {
        get {
            return contentInset.bottom
        } set {
            contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: newValue, right: contentInset.right)
        }
    }
    
    /// `set` `get` the contentInset's left
    var contentInsetLeft: CGFloat {
        get {
            return contentInset.left
        } set {
            contentInset = UIEdgeInsets(top: contentInset.top, left: newValue, bottom: contentInset.bottom, right: contentInset.right)
        }
    }
    
    /// `set` `get` the contentInset's top
    var contentInsetRight: CGFloat {
        get {
            return contentInset.right
        } set {
            contentInset = UIEdgeInsets(top: top, left: contentInset.left, bottom: contentInset.bottom, right: newValue)
        }
    }
    
}



