import SwiftUI

extension CustomOpenMutedParticipantList.ViewConverter.List {
    struct rowView: View {
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
            if let channelURL = viewModel.openChannel?.channelURL {
                OpenMutedParticipantListView(
                    channelURL: channelURL,
                    listItem: {
                        .init()
                        .rowView { config in
                            HStack {
                                Circle()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(config.isOperator ? .green : .red)
                                Text("\(config.user.refinedNickname()) - \(self.customFlag ? "ON" : "OFF")")
                                    .foregroundStyle(.black)
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
    CustomOpenMutedParticipantList.ViewConverter.List.rowView()
}
