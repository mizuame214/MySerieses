import SwiftUI

struct DragAndDrop2UpView: View
{
    var upBooksTitle: String
    let color: Color
    
    var body: some View
    {
        ZStack
        {
            RoundedRectangle(cornerRadius: 10)
            .frame(height: 60)
            .foregroundColor(color)
            HStack
            {
                Text("一つ上階層の ")
                Text(upBooksTitle)
                    .lineLimit(1)
                Text(" へ移動する")
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.gray, style: StrokeStyle(dash: [10]))
            )
        }
    }
}
