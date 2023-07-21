import SwiftUI

struct DragAndDrop2UpView: View
{
    var upBooksTitle: String
    
    var body: some View
    {
        VStack
        {
            Text("一つ上階層の " + upBooksTitle + " へ移動する")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
            .strokeBorder(Color.gray, style: StrokeStyle(dash: [10]))
        )
    }
}
