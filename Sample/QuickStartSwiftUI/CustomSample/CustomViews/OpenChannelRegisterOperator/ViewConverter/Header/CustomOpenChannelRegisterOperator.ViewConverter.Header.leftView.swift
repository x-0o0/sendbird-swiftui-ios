import SwiftUI

extension CustomOpenChannelRegisterOperator.ViewConverter.Header {
    struct leftView: View {
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
            OpenChannelRegisterOperatorView(
                channelURL: TestURL.openChannelOperator,
                headerItem: {
                    .init()
                    .leftView { config in
                        Text("Left \(customFlag ? "ON" : "OFF")")
                            .foregroundStyle(.blue)
                    }
                }
            )
            CustomButton()
        }
    }
}

#Preview {
    CustomOpenChannelRegisterOperator.ViewConverter.Header.leftView()
}
