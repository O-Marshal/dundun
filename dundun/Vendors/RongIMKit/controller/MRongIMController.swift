//
//  MRongIMController.swift
//  dundun
//
//  Created by 刘荣 on 16/5/10.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MRongIMController {
    
    class func chat(vc: UIViewController, target: String, title: String) {
        let chat = MConversationViewController()
        chat.conversationType = RCConversationType.ConversationType_PRIVATE
        chat.targetId = target
        chat.title = title
        vc.showViewController(chat, sender: nil)
        
    }

}
