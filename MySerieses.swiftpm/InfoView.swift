import SwiftUI

struct InfoView: View
{
    var title: String
    var mainText: String
    
    var body: some View
    {
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
                .multilineTextAlignment(.leading)
                .font(.system(size:16))
                .padding(.vertical, 5)
                Spacer()
            }
            .padding(.leading,22)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .background(
            RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 1)
        )
    }
}

struct InfoView_Previews: PreviewProvider
{
    static var previews: some View
    {
        InfoView(title:"あらすじ", mainText:"感情のない空々空の英雄譚")
    }
}
