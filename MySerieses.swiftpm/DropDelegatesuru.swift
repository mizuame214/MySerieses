import SwiftUI

struct DropDelegatesuru: DropDelegate
{
    @Binding var thisBooks: SeriesData
    
    //手を離した時の挙動。データを更新する
    func performDrop(info: DropInfo) -> Bool
    {
        //color = .red
        //データをどうやって持ってくるか問題。
        thisBooks.datas.serieses[0].title = "henka";    //できた
        return true
    }
    
    func dropEntered(info: DropInfo)
    {
        
    }
}
