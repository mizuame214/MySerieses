import SwiftUI

struct DropDelegateDetail: DropDelegate
{
    @Binding var details: [DetailData]
    let i: Int
    let dragData: Any
    @Binding var dropNum: Int
    
    func performDrop(info: DropInfo) -> Bool
    {
        if(dragData is Binding<DetailData>)
        {
            let detail = dragData as! Binding<DetailData>
            details.move(fromOffsets: [details.firstIndex(of: detail.wrappedValue)!], toOffset: i)
            dropNum = -1
        }
        return true
    }
    
    func dropEntered(info: DropInfo)
    {
        if(dragData is Binding<DetailData>)
        {
            dropNum = i
        }
    }
    
    func dropExited(info: DropInfo)
    {
        dropNum = -1
    }
}
