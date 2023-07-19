import SwiftUI

struct DropDelegateSurutoMove: DropDelegate
{
    @Binding var allSerieses: [Binding<SeriesData>]
    let i: Int
    let dragData: Any
    
    func performDrop(info: DropInfo) -> Bool
    {
        //series以外の侵入禁止
        if(dragData is Binding<SeriesData>)
        {
            let series = dragData as! Binding<SeriesData>
            allSerieses.move(fromOffsets: [series.num.wrappedValue-1], toOffset: i)
            adjustSeriesesNum(fibAllSerieses: allSerieses)
        }
        return true
    }
    
    func dropEntered(info: DropInfo)
    {
        //受け入れるように線が入るといい。
    }
}
