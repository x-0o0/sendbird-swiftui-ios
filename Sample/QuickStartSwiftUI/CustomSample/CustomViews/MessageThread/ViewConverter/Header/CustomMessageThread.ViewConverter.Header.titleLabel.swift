import SwiftUI

extension CustomMessageThread.ViewConverter.Header {
    struct titleLabel: View {
        @EnvironmentObject var viewModel: CustomSampleSubViewModel
        @State var customFlag: Bool = false
        
        func CustomButton() -> Button<some View> {
            return Button {
                self.customFlag.toggle()
            } label: {
                Text("Toggle")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
        }
        
        var body: some View {
            if let channelURL = viewModel.groupChannel?.channelURL,
               let parentMessageId = viewModel.parentMessage?.messageId {
                MessageThreadView(
                    channelURL: channelURL,
                    parentMessageId: parentMessageId,
                    headerItem: {
                        .init()
                        .titleLabel { config in
                            Button {
                                print("titleLabel")
                            } label: {
                                Text("titleLabel \(customFlag ? "ON" : "OFF")")
                            }
                        }
                    }
                )
                
                CustomButton()
            }
        }
    }
}

#Preview {
    CustomMessageThread.ViewConverter.Header.titleLabel()
}