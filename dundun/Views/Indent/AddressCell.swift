//
//  AddressCell.swift
//  dundun
//
//  Created by 陈汉玉 on 16/5/7.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {
    let name = UILabel()
    let phoneNumber = UILabel()
    let addressDetail = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    func createSunviews()  {
        let people = UILabel()
        people.text = "收货人:"
        people.font = labelFont
        contentView.addSubview(people)
        people.snp_makeConstraints { (make) in
           make.top.equalTo(contentView).offset(5)
            
            make.left.equalTo(contentView).offset(30)
        }
        name.font = labelFont
        name.textColor = gray
        contentView.addSubview(name)
        name.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(5)
            make.left.equalTo(people.snp_right).offset(2)
        }
        
        phoneNumber.font = labelFont
        phoneNumber.textColor = gray
        contentView.addSubview(phoneNumber)
        phoneNumber.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(5)
            make.right.equalTo(contentView).offset(-20)
        }
        
        let addressName = UILabel()
        addressName.text = "收货地址:"
        addressName.font = labelFont
        contentView.addSubview(addressName)
        addressName.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(30)
            make.top.equalTo(contentView).offset(30)
        }
        
        addressDetail.font = labelFont
        addressDetail.textColor = gray
        contentView.addSubview(addressDetail)
        addressDetail.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(30)
//            make.height.equalTo(40)
            make.left.equalTo(addressName.snp_right).offset(2)
        }
    }
    
    func setdata(model:PersoanlAddressModel) {
        name.text = model.name
        addressDetail.text = model.adr
        addressDetail.numberOfLines = 0
        addressDetail.lineBreakMode = .ByWordWrapping
        phoneNumber.text = model.pho
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
