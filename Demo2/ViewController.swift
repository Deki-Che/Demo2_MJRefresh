//
//  ViewController.swift
//  Demo2
//
//  Created by Deki on 15/10/15.
//  Copyright © 2015年 Deki. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var objectArray = [String]()
    var tableView:UITableView!
    var i  = 0
    override func viewDidLoad() {

        super.viewDidLoad()
        //self.edgesForExtendedLayout = UIRectEdgeNone
        self.edgesForExtendedLayout = UIRectEdge()
        self.extendedLayoutIncludesOpaqueBars = false
        self.modalPresentationCapturesStatusBarAppearance = false
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView = UITableView(frame: self.view.frame)
        self.view.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        
        for  i  = 0; i < 10 ; ++i {
            self.objectArray.append("\(i)")
        }
        self.tableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "headerRefresh")
        self.tableView.footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: "footerRefresh")
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = "这是第 \(self.objectArray[indexPath.row]) 行 "
        return cell        
    }
    
    
    
    func headerRefresh() {
        self.Delay(2) { () -> () in
            self.objectArray.removeAll(keepCapacity: false)
            self.i = 0
            for self.i ; self.i < 10; ++self.i {
                self.objectArray.append("\(self.i)")
            }
            self.tableView.reloadData()
            self.tableView.header.endRefreshing()

        }
        
                
    }
    
    func footerRefresh() {
        self.Delay(2) { () -> () in
            let j = self.i + 10
            for self.i; self.i < j; ++self.i {
                self.objectArray.append("\(self.i)")
            }
            self.tableView.reloadData()
            self.tableView.footer.endRefreshing()
            


        }
            }
    
    func Delay(time: Double, closure: () ->() ) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

