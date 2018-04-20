//
//  AnimationListViewController.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/13.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class AnimationListViewController: UITableViewController {
    
    let animationArray = ["基础动画", "关键帧动画", "动画组", "过渡动画", "仿射动画", "动画案例"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "核心动画"
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animationArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = self.animationArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(CommonAnimationViewController(), animated: true)
            break
        case 1:
            self.navigationController?.pushViewController(KeyframeAnimationViewController(), animated: true)
            break
        case 2:
            self.navigationController?.pushViewController(GroupAnimationViewController(), animated: true)
            break
        case 3:
            self.navigationController?.pushViewController(TransitionViewController(), animated: true)
            break
        case 4:
            self.navigationController?.pushViewController(UIViewAnimationViewController(), animated: true)
            break
        case 5:
            self.navigationController?.pushViewController(CaseViewController(), animated: true)
            break
        default:
            break
        }
    }
}
