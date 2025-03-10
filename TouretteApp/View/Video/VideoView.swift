import AVKit
import SwiftUI

struct VideoView: View {
    var body: some View {
        if let url = Bundle.main.url(forResource: "video", withExtension: "mp4") {
            VideoPlayerController(player: AVPlayer(url: url))
                .frame(height: 300)
        } else {
            Text("Error")
        }
    }
}
