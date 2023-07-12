import SwiftUI

struct DragAndDrop2UpView: View
{
    var upBooksTitle: String
    
    var body: some View
    {
        VStack
        {
            Text(upBooksTitle)
            Text("上の階層へ移動する的な")
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
            .strokeBorder(Color.gray, style: StrokeStyle(dash: [10]))
            .background(Color.white)
        )
    }
}
