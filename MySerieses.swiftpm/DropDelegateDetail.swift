import SwiftUI

struct DropDelegateDetail: DropDelegate
{
    @Binding var details: [DetailData]
    let i: Int
    let dragData: Any
    @Binding var canDrop: Bool
    
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
        if(dragData is Binding<DetailData>)
        {
            canDrop = true
        }
    }
    
    func dropExited(info: DropInfo)
    {
        if(dragData is Binding<DetailData>)
        {
            canDrop = false
        }
    }
}
