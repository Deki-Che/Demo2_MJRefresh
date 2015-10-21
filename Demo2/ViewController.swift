//
//  ViewController.swift
//  Demo2
//
//  Created by Deki on 15/10/15.
//  Copyright © 2015年 Deki. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var imageArray = Array<UIImage>()
    
    var objectArray = [String]()
    var tableView:UITableView!
    var i  = 0
    
    var head: XHPathCover!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //self.edgesForExtendedLayout = UIRectEdgeNone
        self.edgesForExtendedLayout = UIRectEdge()
        self.extendedLayoutIncludesOpaqueBars = false
        self.modalPresentationCapturesStatusBarAppearance = false
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "猜猜我是谁"
        
        self.tableView = UITableView(frame: self.view.frame)
        self.view.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        
        for  i  = 0; i < 10 ; ++i {
            self.objectArray.append("\(i)")
        }
        
        self.tableView.footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: "footerRefresh")
        
        
        head = XHPathCover(frame: CGRectMake(0, 0, 320, 200))
        head.setBackgroundImage(UIImage(named: "MenuBackground"))
        head.setAvatarImage(UIImage(named: "hud1"))
        head.isZoomingEffect = true
        
        head.setInfo(NSDictionary(dictionary: ["xiaoche" : XHUserNameKey, "1990-02-07": XHBirthdayKey]) as [NSObject : AnyObject])
        head.avatarButton.layer.cornerRadius = 33
        head.avatarButton.layer.masksToBounds = true
        

        head.handleRefreshEvent = {
            self.headerRefresh()
        }
        
        
        let Line = LineView(frame: CGRectMake(0, 200, 320, 60))
        
        let HeadView = UIView(frame:CGRectMake(0, 0, 320, 60 + 200) )
        
        let labelName = UILabel(frame: CGRectMake(100, 110, 150, 50))
        labelName.backgroundColor = UIColor.whiteColor()
        labelName.text = "车大牛"
        labelName.textColor = UIColor.blackColor()
        labelName.textAlignment = .Center
        labelName.font = UIFont.systemFontOfSize(13)
        labelName.alpha = 0.4
        head.addSubview(labelName)
        
        HeadView.addSubview(Line)
        HeadView.addSubview(head)
        
        self.tableView.tableHeaderView = HeadView
        
        SDImageCache.sharedImageCache().clearDisk()
        SDImageCache.sharedImageCache().clearMemory()
        
        
        
    }

    //  把tableView传进去
    func scrollViewDidScroll(scrollView: UIScrollView) {
        head.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        head.scrollViewDidEndDecelerating(scrollView)
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        head.scrollViewDidEndDragging(scrollView, willDecelerate:  decelerate)
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        head.scrollViewWillBeginDragging(scrollView)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let imageView = UIImageView(frame: CGRectMake(10, 10, 60, 60))
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        
        
        
        let  imageURL = NSURL(string: "http://v1.qzone.cc/avatar/201308/22/10/36/521579394f4bb419.jpg!200x200.jpg")
        let completionBlock: SDWebImageCompletionBlock! = {
            (image:UIImage!, error: NSError!, cacheType:SDImageCacheType, imageURL:NSURL!) -> Void in
            cell.contentView.addSubview(imageView)
        }
        
       imageView.sd_setImageWithURL(imageURL!, placeholderImage:UIImage(named:"hud2"), completed: completionBlock)
        
        let label = UILabel(frame: CGRectMake(80, 30, 100, 20))
        label.text = "这个是第 \(indexPath.row) 行 "
        cell.contentView.addSubview(label)
        return cell        
    }
    
    
    
    func headerRefresh() {
        self.pleaseWait()
        
        self.Delay(2) { () -> () in
            self.clearAllNotice()
            self.objectArray.removeAll(keepCapacity: false)
            self.i = 0
            for self.i ; self.i < 10; ++self.i {
                self.objectArray.append("\(self.i)")
            }
            
            //self.tableView.header.endRefreshing()
            self.tableView.reloadData()
            self.head.stopRefresh()

            self.successNotice("刷新成功")
        }
        
                
    }
    
    func footerRefresh() {
        
        self.pleaseWait()
        self.Delay(2) { () -> () in
            self.clearAllNotice()
            let j = self.i + 10
            for self.i; self.i < j; ++self.i {
                self.objectArray.append("\(self.i)")
            }
            self.tableView.reloadData()
            self.tableView.footer.endRefreshing()
            self.successNotice("加载成功", autoClear: true)
            

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

