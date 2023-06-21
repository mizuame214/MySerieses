import SwiftUI

struct DicisionButtonView: View
{
    let text: String
    
    var body: some View
    {
        RoundedRectangle(cornerRadius:8)
        .frame(maxWidth:200, maxHeight:60)
        .shadow(radius: 3)
        .padding(.vertical, 25)
        Text(text)
        .font(.title2)
        .foregroundColor(.white)
    }
}

struct DicisionButtonView_Previews: PreviewProvider {
    static var previews: some View
    {
        DicisionButtonView(text: "詳細")
        .foregroundColor(.teal)
    }
}
