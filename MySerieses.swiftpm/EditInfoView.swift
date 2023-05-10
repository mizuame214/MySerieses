import SwiftUI

struct EditInfoView: View
{
    @Binding var title: String
    @Binding var mainText: String
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                TextEditor(text: $title)
                .font(.title2)
                .frame(maxHeight: 50)
                .border(.gray, width:0.5)
                Spacer()
            }
            HStack
            {
                TextEditor(text: $mainText)
                .border(.gray, width:0.5)
                .frame(maxHeight: 150)
                Spacer()
            }
            .padding(.leading,25)
            Spacer()
        }
        .padding(.top)
    }
}
