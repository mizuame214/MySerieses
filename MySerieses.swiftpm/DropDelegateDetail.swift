import SwiftUI

struct DropDelegateDetail: DropDelegate
{
    @Binding var details: [DetailData]
    let i: Int
    let dragData: Any
    
    func performDrop(info: DropInfo) -> Bool
    {
        if(dragData is Binding<DetailData>)
        {
            let detail = dragData as! Binding<DetailData>
            details.move(fromOffsets: [details.firstIndex(of: detail.wrappedValue)!], toOffset: i)
        }
        return true
    }
    
    func dropEntered(info: DropInfo)
    {
        
    }
}
