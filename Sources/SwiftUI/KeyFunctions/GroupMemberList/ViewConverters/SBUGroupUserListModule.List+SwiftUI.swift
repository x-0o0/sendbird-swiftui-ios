//
//  GroupMemberListView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

extension SBUUserListModule.List {
    typealias ViewConverter = GroupMemberListViewConverter.List
    
    var viewConverter: ViewConverter {
        SBViewConverterSet.GroupMemberList.list
    }
}

extension SBUUserListModule.List {
    func applyViewConverter(_ viewType: ViewConverter.ViewType) -> Bool {
        let tag = viewType.tag
        
        switch viewType {
        case .entireContent:
            let users = self.userList
            if let tableViewConverter = self.viewConverter.tableView.entireContent,
               let hostingView = tableViewConverter(
                .init(
                    parentView: self,
                    users: users
                )
               ) {
            
                // remove UITableView
                self.tableView.removeFromSuperview()
                
                // add hostingView as subview of List
                hostingView.tag = tag
                self.addSubview(hostingView)
                
                hostingView
                    .sbu_constraint_fill(equalTo: self)
                    .sbu_constraint(height: self.frame.height)
                
                return true
            }
            return false
        }
    }
}
