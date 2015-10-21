//
//  LineView.swift
//  Demo2
//
//  Created by Deki on 15/10/16.
//  Copyright © 2015年 Deki. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    var labelList = ["动态", "关注", "粉丝", "文章", "文集"]

    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1)
        CGContextSetLineWidth(context, 0.5)
        
        for var i = 1; i <= 4; ++i {
            CGContextMoveToPoint(context, (CGFloat)(i) * rect.width/5, 10)
            CGContextAddLineToPoint(context, (CGFloat)(i) * rect.width/5, 50)
        }
        
        CGContextMoveToPoint(context, 0, 5)
        CGContextAddLineToPoint(context, rect.width, 5)
        
        CGContextMoveToPoint(context, 0, rect.height - 5)
        CGContextAddLineToPoint(context, rect.width, rect.height - 5)
        
        CGContextStrokePath(context)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        for var i = 0; i < 5; i++ {
            let label = UILabel(frame: CGRectMake((CGFloat)(i) * frame.width/5, frame.height/3, frame.width/5, frame.height * 2 / 3))
            label.text = labelList[i]
            label.textColor = UIColor.grayColor()
            label.font = UIFont.systemFontOfSize(13)
            label.textAlignment = NSTextAlignment.Center
            self.addSubview(label)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
