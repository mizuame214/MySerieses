import SwiftUI
//今使ってない
struct NotEnoughBar: View
{
    var col: Color
    
    var body: some View
    {
        HStack
        {
            Rectangle()
            .frame(minHeight:15)
            .foregroundColor(col)
            .padding(-4)
        }
    }
}

struct NotEnoughBar_Previews: PreviewProvider
{
    static var previews: some View
    {
        NotEnoughBar(col: .yellow)
            .previewInterfaceOrientation(.portrait)
    }
}
