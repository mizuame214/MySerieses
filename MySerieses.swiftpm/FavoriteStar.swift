import SwiftUI

struct FavoriteStar: View {
    var body: some View {
        Button
        {
            
        }
        label:
        {
            Image(systemName: "star")
            .foregroundColor(.gray)
        }
    }
}

struct FavoriteStar_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteStar()
    }
}
