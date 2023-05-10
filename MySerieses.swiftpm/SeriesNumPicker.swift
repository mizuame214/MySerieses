import SwiftUI

struct SeriesNumPicker: View
{
    var noNumList: [Int]
    var nums: [Int]
    @Binding var num: Int
    
    //ピッカーの文字色を決める（あるシリーズ番号は灰色）
    func blackOrGray(fibI: Int) -> Color
    {
        if nums != []
        {
            //ある最終巻より後は黒
            if nums[nums.count - 1] < fibI
            {
                return .black
            }
            //noNumListにあるやつは黒
            for nnl in noNumList
            {
                if fibI == nnl
                {
                    return .black
                }
            }
            //それ以外のnumsに書いてあるやつは灰
            return Color(red: 0.8, green: 0.8, blue: 0.8)
        }
        //numsが空っぽなら全部黒
        return .black
    }
    
    var body: some View
    {
        Picker("番号", selection: $num)
        {
            let numMinusTwo: Int = num-3 > 0 ? num-3 : 1
            ForEach(numMinusTwo ... num+3, id:\.self)
            { i in
                Text(String(i))
                .foregroundColor(blackOrGray(fibI: i))
            }
        }
        .pickerStyle(.wheel)
        .frame(height: 100)
        //抜けリストの一番最初 or あるシリーズ番号の次 or 1
        .onAppear()
        {
            if nums != []
            {
                if noNumList != []
                {
                    num = noNumList[0]
                }
                else
                {
                    num = nums[nums.count - 1] + 1
                }
            }
            else
            {
                num = 1
            }
        }
    }
}
