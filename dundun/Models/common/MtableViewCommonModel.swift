//
//  MtableViewCommonModel.swift
//  dundun
//
//  Created by 刘荣 on 16/4/30.
//  Copyright © 2016年 Microali. All rights reserved.
//

import Foundation

class MtableViewCommonModel: BaseModel {
    
    var type: String?
    var title: String?
    var desc: String?
    var money: CGFloat = 0
    var time: String?
    
    var hasDesc: Bool {
        return desc?.characters.count > 2
    }
    
    var icon: String {
        switch type ?? "" {
        case "recharge"://账户充值
            return "account_charge"
        case "cash"://提现
            return "account_cash"
        case "invitate"://邀请
            return "user_invite"
        case "sign"://签到
            return "user_sign"
        case "m1"://卡卷
            return "wallet_f"
        case "m2"://零钱
            return "wallet_q"
        default:
            return "account_other"
        }
    }
    
    var numStr: String {
        let str = "\(money)"
        let mark = money > 0 ? "+" : ""
        return mark + str
    }
    
    init(type: String, title: String, desc: String, money: CGFloat, time: String) {
        super.init()
        self.type = type
        self.title = title
        self.desc = desc
        self.money = money
        self.time = time
    }
    
    override init(jsonString: String) {
        super.init(jsonString: jsonString)
    }

}
