//
//  DiscussCell.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/2/21.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class DiscussCell: UITableViewCell {

    
    var avatarImage:UIImageView?
    
    var nameLabel:UILabel?
    
    var detailLabel:UILabel?
    
    var dateLabel:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initFrame()
    }
    
    func initFrame(){
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        self.avatarImage = UIImageView(frame: CGRectMake(8,8,40,40))
        //设置圆角并且打开遮罩层，一般下面两句逗同时使用，否则可能会没有效果
        self.avatarImage?.layer.cornerRadius = 20
        self.avatarImage?.layer.masksToBounds = true
        
        self.contentView.addSubview(self.avatarImage!)
        
        self.nameLabel = UILabel(frame: CGRectMake(56,8,SCREEN_WIDTH-56-8,15))
        self.nameLabel?.font = UIFont(name: MAIN_FONT, size: 13)
        self.contentView.addSubview(self.nameLabel!)
        
        
        self.dateLabel = UILabel(frame: CGRectMake(56,self.frame.size.height-8-10,SCREEN_WIDTH-56-8,10))
        self.dateLabel?.font = UIFont(name: MAIN_FONT, size: 13)
        self.dateLabel?.textColor = UIColor.grayColor()
        self.contentView.addSubview(self.dateLabel!)
        
        self.detailLabel = UILabel(frame: CGRectMake(56,30,SCREEN_WIDTH-56-8,self.frame.size.height - 30 - 25))
        self.detailLabel?.font = UIFont(name: MAIN_FONT, size: 15)
        //设置根据内容自动调整高度
        self.detailLabel?.numberOfLines = 0
        self.contentView.addSubview(self.detailLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




