import SwiftUI

struct DropDelegateSurutoMove: DropDelegate
{
    @Binding var allSerieses: [Binding<SeriesData>]
    let i: Int
    let dragData: Any
    @Binding var dropNum: Int
    
    func performDrop(info: DropInfo) -> Bool
    {
        //series以外の侵入禁止
        if(dragData is Binding<SeriesData>)
        {
            let series = dragData as! Binding<SeriesData>
            allSerieses.move(fromOffsets: [series.num.wrappedValue-1], toOffset: i)
            adjustSeriesesNum(fibAllSerieses: allSerieses)
            dropNum = -1
        }
        return true
    }
    
    func dropEntered(info: DropInfo)
    {
        if(dragData is Binding<SeriesData>)
        {
            dropNum = i
        }
    }
    
    func dropExited(info: DropInfo)
    {
        dropNum = -1
    }
}
