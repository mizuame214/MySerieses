import SwiftUI

//シリーズと詳細の追加するための表示部分
struct DetailSettingView: View
{
    @State var titleMS:String = ""
    @State var messageMS:String = ""
    
    @Binding var thisBooks: SeriesData  //裏で表示されてる、追加しようとしてるシリーズデータ
    
    @Binding var isPresentShown: Bool
    
    @State var seriesOrNot: Bool = true
    
    //にもらったものを他の人に渡すだけ
    var noNumList: [Int]
    var nums: [Int]
    
    @State var num: Int = 0
    
    @State var exit: Bool = false
    
    var body: some View
    {
        VStack
        {
            Picker("シリーズか詳細か", selection: $seriesOrNot)
            {
                Text("シリーズ").tag(true)
                Text("詳細").tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.vertical, 25)
            
            HStack
            {
                Text("タイトル")
                Spacer()
            }
            TextField("タイトル", text: $titleMS)
            .padding(10)
            .frame(height:40)
            .border(.gray, width:0.5)
            .padding(.bottom, 15)
            
            //変わる表示内容
            HStack
            {
                Text($seriesOrNot.wrappedValue ? "番号" : "内容")
                Spacer()
            }
            if $seriesOrNot.wrappedValue == true
            {
                SeriesNumPicker(noNumList: noNumList, nums: nums, num: $num)
            }
            else
            {
                TextEditor(text: $messageMS)
                .padding(10)
                .frame(height:80)
                .border(.gray, width:0.5)
                .padding(.bottom, 20)
            }
            
            //作成ボタン
            HStack
            {
                Button
                {
                    if $seriesOrNot.wrappedValue == true
                    {
                        if(exit == false)
                        {
                            thisBooks.datas.serieses.append(SeriesData(title: titleMS, num: num, datas: SeriesesAndDetailsData(serieses: [], details: [])))
                            isPresentShown = false
                        }
                    }
                    else
                    {
                        thisBooks.datas.details.append(DetailData(title: titleMS, message: messageMS))
                        isPresentShown = false
                    }
                }
                label:
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius:8)
                        .frame(maxWidth:200, maxHeight:60)
                        .foregroundColor(exit ? $seriesOrNot.wrappedValue ? Color(red: 0.8, green: 0.8, blue: 0.8) : .teal : .teal)
                        .shadow(radius: 3)
                        .padding(.vertical, 25)
                        Text($seriesOrNot.wrappedValue ? "シリーズ作成" : "詳細作成")
                        .font(.title2)
                        .foregroundColor(.white)
                    }
                }
            }
            .onChange(of: num)
            { num in
                exit = false
                for n in nums
                {
                    if(num == n)
                    {
                        exit = true
                        break
                    }
                }
            }
        }
        .padding(40)
    }
}
