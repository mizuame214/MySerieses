import SwiftUI

struct EditView: View
{
    @Binding var thisBooks: SeriesData
    
    @State var editMode: EditMode = .active
    @State var isPre: Bool
    
    //戻るボタンのカスタム
    @Environment(\.dismiss) var dismiss
    
    var body: some View
    {
        ZStack
        {
            List
            {
                //詳細部分の表示
                Section
                {
                    ForEach($thisBooks.datas.details)
                    { detail in
                        //ちょっと表示方法ダサいかも
                        EditInfoView(title: detail.title, mainText: detail.message)
                    }
                    .onMove
                    { from, to in
                        thisBooks.datas.details.move(fromOffsets: from, toOffset: to)
                    }
                    .onDelete
                    { indexSet in
                        thisBooks.datas.details.remove(atOffsets: indexSet)
                    }
                }
                //シリーズ部分の表示
                Section
                {
                    ForEach($thisBooks.datas.serieses)
                    { series in
                        Button
                        {
                            isPre = true
                        }
                        label:
                        {
                            AList(data: series.wrappedValue)
                        }
                        .sheet(isPresented: $isPre)
                        {
                            //一つ一つリストの編集画面
                        }
                    }
                    .onMove
                    { from, to in
                        //まだ無理
                        thisBooks.datas.serieses.move(fromOffsets: from, toOffset: to)
                        //移動前のシリーズを取得できないぴえ
                        thisBooks.datas.serieses[1].num = to
                    }
                    .onDelete
                    { indexSet in
                        thisBooks.datas.serieses.remove(atOffsets: indexSet)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(thisBooks.title)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
                Button( action:
                {
                    dismiss()
                },
                label:
                {
                    Image(systemName: "checkmark")
                })
            )
            .environment(\.editMode, self.$editMode)
        }
    }
}
