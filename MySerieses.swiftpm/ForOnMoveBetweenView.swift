import SwiftUI

struct ForOnMoveBetweenView: View
{
    let i: Int
    @Binding var dropNum: Int
    
    @State var dropEnt: Bool = false
    @Binding var dragData: Any
    let detailOrSeries: Bool
    
    func dropEntered() -> Bool
    {
        if(dragData is Binding<DetailData> && detailOrSeries)
        {
            if(i == dropNum)
            {
                return true
            }
        }
        else if(dragData is Binding<SeriesData> && detailOrSeries == false)
        {
            if(i == dropNum)
            {
                return true
            }
        }
        return false
    }
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            Rectangle()
            .frame(height: 5)
            .foregroundColor(.white)
            Rectangle()
            .frame(height: 2)
            .foregroundColor(dropEnt ? .teal : .white)
            Rectangle()
            .frame(height: 5)
            .foregroundColor(.white)
        }
        .onChange(of: dropNum)
        { dropNum in
            dropEnt = dropEntered()
        }
    }
}
