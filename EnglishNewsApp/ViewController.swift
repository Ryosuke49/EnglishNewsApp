//
//  ViewController.swift
//  EnglishNewsApp
//
//  Created by 三上 綾介 on 2018/09/12.
//  Copyright © 2018年 Ryosuke Mikami. All rights reserved.
//

import UIKit
import PagingMenuController

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // PagingMenuController追加
        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        
        // 高さ調整
        pagingMenuController.view.frame.origin.y += 20
        pagingMenuController.view.frame.size.height -= 20
        
        self.addChildViewController(pagingMenuController)
        self.view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    let pv1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PagingMenuVC1") as! PagingMenuViewController1
    let pv2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PagingMenuVC2") as! PagingMenuViewController2
    let pv3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PagingMenuVC3") as! PagingMenuViewController3
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [UIViewController] {
        return [pv1, pv2, pv3]
    }
    
    fileprivate struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .infinite(widthMode: .flexible, scrollingMode: .scrollEnabled)
        }
        var height: CGFloat {
            return 40
        }
        var backgroundColor: UIColor {
            return UIColor.lightGray
        }
        var selectedBackgroundColor: UIColor {
            return UIColor.gray
        }
        var focusMode: MenuFocusMode {
            return .roundRect(radius: 4, horizontalPadding: 4, verticalPadding: 4, selectedColor: UIColor.black)
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2(), MenuItem3()]
        }
    }
    
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "YahooNews", color: UIColor.white, selectedColor: UIColor.white))
        }
    }
    
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "BBC Asia", color: UIColor.white, selectedColor: UIColor.white))
        }
    }
    
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "BBC Businnes", color: UIColor.white, selectedColor: UIColor.white))
        }
}

}
