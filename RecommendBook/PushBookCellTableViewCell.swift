//
//  PushBookCellTableViewCell.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/2/17.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class PushBookCellTableViewCell: SWTableViewCell {
    var bookName: UILabel!
    var editor: UILabel!
    var more: UILabel!
    var cover: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in contentView.subviews{
            view.removeFromSuperview()
        }
        bookName = UILabel(frame: CGRectMake(78,8,242,25))
        bookName.font = UIFont(name: MAIN_FONT, size: 15)
        editor = UILabel(frame: CGRectMake(78,33,242,25))
        editor.font = UIFont(name: MAIN_FONT, size: 15)
        more = UILabel(frame: CGRectMake(78,66,242,25))
        more.font = UIFont(name: MAIN_FONT, size: 13)
        more.textColor = UIColor.grayColor()
        
        cover = UIImageView(frame: CGRectMake(8, 9, 56, 70))
        
        contentView.addSubview(bookName)
        contentView.addSubview(editor)
        contentView.addSubview(more)
        contentView.addSubview(cover)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
