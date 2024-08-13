//
//  OpenChannelRegisterOperatorView+Item.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

// CHECK: applyViewConverterForOpen 을 사용해주세요

extension Sendbird.View.OpenChannel.RegisterOperator {
    /// A struct that defines the header item of the OpenChannelRegisterOperator view.
    public struct HeaderItem: ViewItemProtocol {
        public typealias ViewContent = OpenChannelRegisterOperatorViewConverter.Header
        public typealias HeaderContent = ViewContent

        var viewConverter: OpenChannelRegisterOperatorViewConverter.Header {
            get { SBViewConverterSet.OpenChannelRegisterOperator.header }
            set { SBViewConverterSet.OpenChannelRegisterOperator.header = newValue }
        }
        
        public init() {}
        
        // MARK: Entire Content
        // INFO: HeaderItem does not have entireContent
        
        // MARK: Item Components
        // MARK: - Public Methods
        public func leftView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.LeftView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.leftView.entireContent = createViewConverter(content: content)
            copy.viewConverter.viewUpdateHandlers[.leftView] = { viewController in
                viewController.headerComponent?.applyViewConverterForOpen(.leftView)
            }
            return copy
        }
        
        public func rightView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.RightView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.rightView.entireContent = createViewConverter(content: content)
            copy.viewConverter.viewUpdateHandlers[.rightView] = { viewController in
                viewController.headerComponent?.applyViewConverterForOpen(.rightView)
            }
            return copy
        }
        
        public func titleView<Content: View>(
            @ViewBuilder content: @escaping (HeaderContent.TitleView.ViewConfig) -> Content
        ) -> Self {
            var copy = self
            copy.viewConverter.titleView.entireContent = createViewConverter(content: content)
            copy.viewConverter.viewUpdateHandlers[.titleView] = { viewController in
                viewController.headerComponent?.applyViewConverterForOpen(.titleView)
            }
            return copy
        }
    }
    
    /// A struct that defines the list item of the OpenChannelRegisterOperator view.
    public struct ListItem: ViewItemProtocol {
        public typealias ViewContent = OpenChannelRegisterOperatorViewConverter.List
        // TODO: 필요하면 구현 (↓↓ example ↓↓)
        // public typealias ListItemContent = ViewContent.TableView.ChannelCell
        
        var viewConverter: OpenChannelRegisterOperatorViewConverter.List {
            get { SBViewConverterSet.OpenChannelRegisterOperator.list }
            set { SBViewConverterSet.OpenChannelRegisterOperator.list = newValue }
        }
        
        public init() {}
        
        // !!! applyViewConverterForOpen !!! forOpen!!!
        // MARK: Entire Content
// (↓↓ example ↓↓)
//        public func channelListRow<Content: View>(
//            @ViewBuilder content: @escaping (ListItemContent.ViewConfig) -> Content
//        ) -> Self {
//            var copy = self
//            copy.viewConverter.tableView.channelCell.entireContent = createViewConverter(content: content)
//            copy.viewConverter.tableView.channelCell.viewUpdateHandlers[.entireContent] = { viewController in
//                viewController.listComponent?.reloadTableView()
//            }
//            return copy
//        }
        
        // MARK: Item Components
// (↓↓ example ↓↓)
//        public func coverImage<Content: View>(
//            @ViewBuilder content: @escaping (ListItemContent.CoverImage.ViewConfig) -> Content
//        ) -> Self {
//            var copy = self
//            copy.viewConverter.tableView.channelCell.coverImage.entireContent = createViewConverter(content: content)
//            copy.viewConverter.tableView.channelCell.coverImage.viewUpdateHandlers[.entireContent] = { viewController in
//                viewController.listComponent?.reloadTableView()
//            }
//            return copy
//        }
    }
    
    // TODO: Header, List 외에 필요한 ViewItem 이 있다면 계속 구현
}