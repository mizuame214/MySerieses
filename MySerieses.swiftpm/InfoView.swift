import SwiftUI

struct InfoView: View {
    var title:String
    var mainText:String
    
    var body: some View {
        VStack
        {
            HStack
            {
                Text(title)
                .font(.title2)
                Spacer()
            }
            HStack
            {
                Text(mainText)
                .padding(.top, 5)
                .padding(.leading, -5)
                .padding(.bottom, 5)
                Spacer()
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding(.top)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(title:"あらすじ", mainText:"感情のない空々空の英雄譚")
    }
}
