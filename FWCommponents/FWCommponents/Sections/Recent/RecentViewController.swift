//
//  RecentViewController.swift
//  FWSideMenu
//
//  Created by xfg on 2018/4/8.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit
import FWPopupView

class RecentViewController: FWBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let imageArray = ["header_0", "header_1", "header_2", "header_3", "header_4", "header_5", "header_6", "header_7", "header_8", "header_9", "header_10"]
    let titleArray = ["服务号", "小甜", "怪蜀黍", "恶天使", "小鱼人", "我的其他QQ账号", "关联账号", "QQ直播", "QQ购物", "HI", "企鹅大叔"]
    let decArray = ["QQ天气：【鼓楼】多云15°/28°，08:05更新~", "[图片]", "或者由于。。。", "你们怕吗？怕你？不存在的。。。", "喂鱼咯", "关联QQ号，代收其他账号好友消息。", "关联账号就是方便，随心所欲，想收就收~", "恭喜你获得10个春暖花开红包~", "钱不够花？手机可随借1000-3000元！", "HI咯", "元宵快乐，来给好友们送上祝福吧！"]
    var timeArray: [String] = []
    
    
    let menuTitles = ["创建群聊", "加好友/群", "扫一扫", "面对面快传", "付款", "拍摄"]
    let menuImages = [UIImage(named: "right_menu_multichat"),
                      UIImage(named: "right_menu_addFri"),
                      UIImage(named: "right_menu_QR"),
                      UIImage(named: "right_menu_facetoface"),
                      UIImage(named: "right_menu_payMoney"),
                      UIImage(named: "right_menu_sendvideo")]
    
    
    lazy var tableView: UITableView = {
        
        let tableview = UITableView()
        tableview.separatorStyle = .none
        return tableview
    }()
    
    lazy var rightMenuView: FWMenuView = {
        
        let vProperty = FWMenuViewProperty()
        vProperty.popupCustomAlignment = .topRight
        vProperty.popupAnimationType = .scale
        vProperty.maskViewColor = UIColor(white: 0, alpha: 0.2)
        vProperty.touchWildToHide = "1"
        vProperty.popupViewEdgeInsets = UIEdgeInsetsMake(kStatusBarHeight + kNavBarHeight, 0, 0, 8)
        vProperty.topBottomMargin = 0
        vProperty.animationDuration = 0.3
        vProperty.popupArrowStyle = .round
        vProperty.popupArrowVertexScaleX = 1
        
        let menuView = FWMenuView.menu(itemTitles: menuTitles, itemImageNames: menuImages as? [UIImage], itemBlock: { (popupView, index, title) in
            print("Menu：点击了第\(index)个按钮")
        }, property: vProperty)
        
        return menuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "消息"
        
        self.sideMenuPanMode = .defaults
        self.isNeedBlueNav = true
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
        
        for index in 0...self.imageArray.count {
            self.timeArray.append(self.obtainRandomTime(index: index))
        }
        
        let buttonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "header"), style: .plain, target: self, action: #selector(leftBtnAction))
        buttonItem.imageInsets = UIEdgeInsetsMake(0, -6, 0, 0)
        self.navigationItem.leftBarButtonItem = buttonItem
        
        let buttonItem2: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "mqz_nav_add"), style: .plain, target: self, action: #selector(rightBtnAction))
        buttonItem2.imageInsets = UIEdgeInsetsMake(0, 0, 0, -6)
        self.navigationItem.rightBarButtonItem = buttonItem2
        
        
        self.view.addSubview(self.tableView)
        self.tableView.register(UINib(nibName: "RecentTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func updateViewConstraints() {
        
        self.tableView.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else {
                return
            }
            make.edges.equalTo(strongSelf.view)
        }
        
        super.updateViewConstraints()
    }
    
    @objc func leftBtnAction() {
        self.menuContainerViewController.toggleLeftSideMenu(completeBolck: nil)
    }
    
    @objc func rightBtnAction() {
        //        self.menuContainerViewController.toggleRightSideMenu(completeBolck: nil)
        self.rightMenuView.show()
    }
    
    func obtainRandomTime(index: Int) -> String {
        return "\(arc4random()%2 == 0 ? "上午" : "下午")" + "\(arc4random()%12):\(arc4random()%5)\(arc4random()%9)"
    }
}

extension RecentViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! RecentTableViewCell
        cell.headerImgView.image = UIImage(named: self.imageArray[indexPath.row])
        cell.nameLabel.text = self.titleArray[indexPath.row]
        cell.decLabel.text = self.decArray[indexPath.row]
        cell.timeLabel.text = self.timeArray[indexPath.row]
        if cell.decLabel.text!.count > 15 {
            cell.tipLabel.isHidden = false
            cell.tipLabel.text = "\(cell.decLabel.text!.count % 10)"
        } else {
            cell.tipLabel.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("您当前点击了第 \(indexPath.row + 1) 行")
        self.navigationController?.pushViewController(SubViewController(), animated: true)
    }
}
