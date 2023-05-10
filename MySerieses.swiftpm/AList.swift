import SwiftUI

//画面のうちのシリーズ部分１個の表示
struct AList: View
{
    var data: SeriesData
    
    //持ってるシリーズに欠けがあればtrue、揃っていればfalse
    func whetherUncomplete(fibData: SeriesData) -> Bool
    {
        let haveSerNum: Int = fibData.datas.serieses.count
        for ser in fibData.datas.serieses
        {
            if haveSerNum < ser.num
            {
                return true
            }
        }
        return false
    }
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                Text(data.title)
                .font(.system(size:15))
                .lineLimit(1)
                
                if(whetherUncomplete(fibData: data))
                {
                    Circle()
                    .foregroundColor(.pink)
                    .frame(width: 15, height: 15, alignment: .leading)
                    .padding(.horizontal, 2)
                }
                
                Spacer()
                
                //デバッグ用シリーズ番号の表示
                Text(String(data.num))
                .font(.system(size:15))
                .foregroundColor(Color(.sRGB, red:1.0, green:0.2, blue:0.2, opacity:1.0))
                
                //星要らなくね?
                //Image(systemName: "star.fill")
                //.foregroundColor(.yellow)
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 10)
    }
}
