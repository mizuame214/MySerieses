import SwiftUI

struct EditDetailSettingView: View
{
    @Binding var detail: DetailData  //変更するデータ
    @Binding var isPresentShown: Bool
    
    @State var fibTitle: String = ""
    @State var fibMessage: String = ""
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                Text("タイトル")
                Spacer()
            }
            .onAppear
            {
                fibTitle = detail.title
                fibMessage = detail.message
            }
            TextField("タイトル", text: $fibTitle)
            .padding(10)
            .frame(height:40)
            .border(.gray, width:0.5)
            .padding(.bottom, 15)
            
            HStack
            {
                Text("内容")
                Spacer()
            }
            TextEditor(text: $fibMessage)
            .padding(10)
            .frame(height:80)
            .border(.gray, width:0.5)
            .padding(.bottom, 20)
            
            //更新ボタン
            HStack
            {
                Button
                {
                    detail = DetailData(title: fibTitle, message: fibMessage)
                    isPresentShown = false
                }
                label:
                {
                    ZStack
                    {
                        DicisionButtonView(text: "更新")
                        .foregroundColor(.teal)
                    }
                }
            }
        }
        .padding(40)
    }
}
