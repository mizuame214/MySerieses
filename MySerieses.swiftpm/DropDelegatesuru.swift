import SwiftUI

struct DropDelegatesuru: DropDelegate
{
    //@Binding var color: Color
    func performDrop(info: DropInfo) -> Bool
    {
        //color = .red
        //データをどうやって持ってくるか問題
        print("手を離しました")
        print(info)
        return true
    }
}
