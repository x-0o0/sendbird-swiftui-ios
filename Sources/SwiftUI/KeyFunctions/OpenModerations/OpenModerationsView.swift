//
//  OpenModerationsView.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SwiftUI
import SendbirdChatSDK

/// A view that displays a OpenModerations
public struct OpenModerationsView: View {
    // MARK: - Properties
    @Environment(\.dismiss)
    private var dismiss
    
    var configurations: [(SBUModerationsViewController) -> Void] = []

    private var channelURL: String
    
    // MARK: - Methods
    public var body: some View {
        SBUViewControllerSet.OpenModerationsViewController
            .swiftUI {
                createViewController()
            }
            .configure { viewController in
                viewController.dismissAction = {
                    dismiss()
                }
                
                // Used in SubViewBuilder
                configurations.forEach { config in
                    config(viewController)
                }
                
                // Apply viewUpdateHandlers recursively
                viewConverter.applyViewUpdates(to: viewController)
            }
            .switchUIKitNavigationBar()
    }
    
    private func createViewController() -> SBUModerationsViewController {
        let viewController = SBUViewControllerSet.OpenModerationsViewController.init(
            channelURL: self.channelURL,
            channelType: .open
        )
        return viewController
    }
}

// MARK: - Initializers
/// OpenModerationsView initializers
public extension OpenModerationsView {
    // MARK: - typealias
    // TODO: Initializer 에서 필요하면 구현
    // typealias ListContent = OpenModerationsViewConverter.List
    
    init(channelURL: String) {
        self.channelURL = channelURL
    }
// (↓↓ example ↓↓)
    init(
        channelURL: String,
        headerItem: (() -> OpenModerationsType.HeaderItem)? = nil
    ) {
        self.channelURL = channelURL

        if let headerItem { _ = headerItem() }
//        if let listItem { _ = listItem() }

        // Apply view converter in viewConverterSet.
        self.applyViewConverterSet()
    }
//
//    init<Content: View>(
//        channelListQuery: GroupChannelListQuery? = nil,
//        headerItem: (() -> Sendbird.View.GroupChannel.ChannelList.HeaderItem)? = nil,
//        list: @escaping (ListContent.ViewConfig) -> Content
//    ) {
//        self.init(channelListQuery: channelListQuery, headerItem: headerItem, listItem: nil)
//
//        typealias ViewConverterType = ViewConverter<ListContent.ViewConfig>
//        let listViewConverter: ViewConverterType = ViewConverter { listConfig in
//            UIHostingController(rootView: list(listConfig)).view
//        }
//
//        self.viewConverter.list.entireContent = listViewConverter
//        self.viewConverter.list.viewUpdateHandlers[.entireContent] = { vc in
//            vc.listComponent?.reloadTableView()
//        }
//
//        // Apply view converter in viewConverterSet.
//        self.applyViewConverterSet()
//    }
}

#Preview {
    NavigationView {
        OpenModerationsView(channelURL: "")
    }
}
