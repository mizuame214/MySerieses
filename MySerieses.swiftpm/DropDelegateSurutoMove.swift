import SwiftUI

struct DropDelegateSurutoMove: DropDelegate
{
    @Binding var allSerieses: [Binding<SeriesData>]
    let i: Int
    let dragSeriese: Binding<SeriesData>
    
    func performDrop(info: DropInfo) -> Bool
    {
        allSerieses.move(fromOffsets: [dragSeriese.num.wrappedValue-1], toOffset: i)
        adjustSeriesesNum(fibAllSerieses: allSerieses)
        return true
    }
    
    func dropEntered(info: DropInfo)
    {
        //受け入れるように線が入るといい。
    }
}
