import SwiftUI

struct SeriesNumPicker: View {
    var noNumList: [Int]
    var lastNum: Int
    @Binding var num: Int
    
    func blackOrGray(fibI: Int) -> Bool
    {
        for nnl in noNumList
        {
            if fibI == nnl || lastNum < fibI
            {
                return true
            }
        }
        return false
    }
    
    var body: some View {
        Picker("番号", selection: $num)
        {
            let numMinusTwo: Int = num-2 > 0 ? num-2 : 1
            ForEach(numMinusTwo ... num+2, id:\.self)
            { i in
                Text(String(i))
                .foregroundColor(blackOrGray(fibI: i) ? .black : Color(red: 0.8, green: 0.8, blue: 0.8))
            }
        }
        .pickerStyle(.wheel)
        //上の方押すと勝手に回っちゃう
        .frame(height: 60)
        //機能しないらしい.compositingGroup()
        .clipped()
        .onAppear()
        {
            num = lastNum + 1
        }
    }
}
