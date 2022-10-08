import SwiftUI

struct DetailSettingView: View {
    @State var titleMS:String = ""
    @State var numMS:String = ""
    @State var messageMS:String = ""
    @Binding var thisBooks: SeriesData
    @Binding var isPresentShown: Bool
    @State var seriesOrNot: Bool = true
    
    @State var notNum: Bool = false
    
    var body: some View {
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
                .foregroundColor(Color(red:0.3, green:0.3, blue:0.3))
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
                .foregroundColor(Color(red:0.3, green:0.3, blue:0.3))
                Spacer()
            }
            //最下層がいいな。でもシリーズ番号見せてないから何巻が足りないのか適当なタイトルつけてたら分からんく無い？　一番上に載せとくか。どうやって？
            TextField($seriesOrNot.wrappedValue ? "番号" : "内容", text : $seriesOrNot.wrappedValue ? $numMS : $messageMS)
            .padding(10)
            .frame(height:40)
            .border(.gray, width:0.5)
            Text(notNum ? "整数で入力してください" : "")
                .foregroundColor(.red)
            
            //ボタン
            HStack
            {
                Button
                {
                    if $seriesOrNot.wrappedValue == true
                    {
                        //シリーズ
                        //-1はできるのに0できないどうしよ
                        if Int(numMS) ?? 0 == 0
                        {
                            notNum = true
                            return
                        }
                        let num = Int(numMS) ?? thisBooks.datas.serieses.count + 1
                        
                        thisBooks.datas.serieses.append(SeriesData(title: titleMS, num: num, datas: SeriesesAndDetailsData(serieses: [], details: [])))
                    }
                    else
                    {
                        //詳細
                        thisBooks.datas.details.append(DetailData(title: titleMS, message: messageMS))
                    }
                    isPresentShown = false
                }
                label:
                {
                    ZStack
                    {
                        RoundedRectangle(cornerRadius:8)
                        .frame(maxWidth:.infinity, maxHeight:60)
                        .foregroundColor(.teal)
                        .shadow(radius: 3)
                        .padding(.vertical, 25)
                        Text($seriesOrNot.wrappedValue ? "シリーズ作成" : "詳細作成")
                        .font(.title2)
                        .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(40)
    }
}
