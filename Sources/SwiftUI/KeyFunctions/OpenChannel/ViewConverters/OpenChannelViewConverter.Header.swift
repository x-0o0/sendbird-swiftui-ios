//
//  OpenChannelView+ViewConverter.swift
//  SendbirdSwiftUI
//
//  Copyright © 2024 Sendbird, Inc. All rights reserved.
//

import SendbirdChatSDK
import UIKit

// MARK: - Header
extension OpenChannelViewConverter {
    public struct Header: ViewConverterProtocol {
        // MARK: TypeAlias
        public typealias ContentBaseArg = SBUOpenChannelModule.Header
        typealias UpdatableVC = SBUOpenChannelViewController
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case leftView
            case rightView
            case titleView
        }

        // MARK: Converter
        // NOTE: no interface for replacing the entire Header.
        var entireContent: ViewConverter<ViewConfig>?
        var leftView = LeftView()
        var rightView = RightView()
        var titleView = TitleView()
        
        // MARK: ViewConfigurations
        /// The configuration for the Header.
        public struct ViewConfig: ViewConfigurations {
            var parentView: ContentBaseArg
            var channel: OpenChannel
        }

        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.leftView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.rightView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.titleView.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension OpenChannelViewConverter.Header {
    /// A converter that updates the left bar button of a `SBUOpenChannelViewController`.
    public struct LeftView: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: ContentBaseArg
        }
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    /// A converter that updates the right bar button of a `SBUOpenChannelViewController`.
    public struct RightView: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: ContentBaseArg
        }
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    /// A converter that updates the title view of a `SBUOpenChannelViewController`.
    public struct TitleView: ViewConverterProtocol {
        // MARK: Typealias
        typealias UpdatableVC = OpenChannelViewConverter.Header.UpdatableVC
        
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
            case coverImage
            case titleLabel
            case subtitleLabel
        }
        
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>?
        var coverImage = CoverImage()
        var titleLabel = TitleLabel()
        var subtitleLabel = SubtitleLabel()
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var parentView: ContentBaseArg
        }
        
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
        func applyViewUpdates(to viewController: UpdatableVC, includeSubDepth: Bool) {
            self.viewUpdateHandlers.values.forEach { $0(viewController) }
            
            guard includeSubDepth else { return }
            self.coverImage.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.titleLabel.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
            self.subtitleLabel.applyViewUpdates(to: viewController, includeSubDepth: includeSubDepth)
        }
    }
}

extension OpenChannelViewConverter.Header.TitleView {
    /// A converter that updates the cover image of a `SBUOpenChannelViewController`.
    public struct CoverImage: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channel: OpenChannel = DefaultViewConfigSet.openChannel
            public var imageSize: CGSize = DefaultViewConfigSet.channelCoverImageSize
            public var coverImage: String?
        }
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    /// A converter that updates the title view of a `SBUOpenChannelViewController`.
    public struct TitleLabel: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum { 
            case entireContent
        }
        
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channel: OpenChannel = DefaultViewConfigSet.openChannel
        }
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
    
    /// A converter that updates the subtitle view of a `SBUOpenChannelViewController`.
    public struct SubtitleLabel: ViewConverterProtocol {
        // MARK: ViewType
        enum ViewType: ViewTypeEnum {
            case entireContent
        }
        
        // MARK: Converter
        var entireContent: ViewConverter<ViewConfig>? {
            didSet { self.entireContent?(.init()) }
        }
        
        // MARK: ViewConfigurations
        public struct ViewConfig: ViewConfigurations {
            public var channel: OpenChannel = DefaultViewConfigSet.openChannel
            public var participantCount: Int = 0
        }
        // MARK: View updater
        var viewUpdateHandlers = [ViewType: (UpdatableVC) -> Void]()
    }
}
