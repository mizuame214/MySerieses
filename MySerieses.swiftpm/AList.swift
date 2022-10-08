import SwiftUI

struct AList: View {
    var data:SeriesData
    
    func whetherUnComplete(fibData: SeriesData) -> Bool
    {
        let fibSeriesNum: Int = fibData.datas.serieses.count
        for ser in fibData.datas.serieses
        {
            //在る数よりシリーズ番号がでかいことがあったら
            if fibSeriesNum < ser.num
            {
                return true
            }
        }
        return false
    }
    
    var body: some View {
        ZStack
        {
            VStack
            {
                HStack
                {
                    Text(data.title)
                    .font(.system(size:15))
                    .foregroundColor(Color(.sRGB, red:0.2, green:0.2, blue:0.2, opacity:1.0))
                    .lineLimit(1)
                    
                    //仮シリーズ番号
                    Text(String(data.num))
                    .font(.system(size:15))
                    .foregroundColor(Color(.sRGB, red:1.0, green:0.2, blue:0.2, opacity:1.0))
                    
                    Circle()
                    .foregroundColor(whetherUnComplete(fibData: data) ? .pink : .clear)
                    .frame(width: 15, height: 15, alignment: .leading)
                    .padding(.horizontal, 2)
                    
                    Spacer()
                    
                    //お気に入りじゃなければ表示されないようにしたい。文字数も星の部分を侵食できるように？
                    //if
                    Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
        }
    }
}
