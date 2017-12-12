//
//  ViewController.swift
//  PanRefresh
//
//  Created by wangchengqvan@gmail.com on 12/02/2017.
//  Copyright (c) 2017 wangchengqvan@gmail.com. All rights reserved.
//

import UIKit
import PanRefresh

class ViewController: UITableViewController {
    var refreshHeader: DefaultRefreshHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        refreshHeader = DefaultRefreshHeader(frame: .zero)
        refreshHeader.backgroundColor = UIColor.random
        tableView.refreshHeader = refreshHeader
        let loadMoreFooter = DefaultLoadMoreFooter(frame: .zero)
        loadMoreFooter.backgroundColor = UIColor.random
        tableView.loadMoreFooter = loadMoreFooter
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.refreshHeader.scrollView?.offsetY = -200
        
        if indexPath.section == 0  {
            refreshHeader.beginRefreshing { [weak self] in
                print("🌹--🌹---\(self)")
            }
        } else {
            refreshHeader.endRefreshing({
                
            })
        }
    }
}

// MARK: - convenience Initializers
public extension UIColor {
    
    /// Returns random UIColor with random alpha(default: 1.0)
    static var random: UIColor {
        return UIColor(
            red: CGFloat(arc4random_uniform(256)) / CGFloat(255),
            green: CGFloat(arc4random_uniform(256)) / CGFloat(255),
            blue: CGFloat(arc4random_uniform(256)) / CGFloat(255),
            alpha: 1.0
        )
    }
    
}



