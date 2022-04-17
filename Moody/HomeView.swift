//
//  HomeView.swift
//  Moody
//
//  Created by Tony Jiang on 4/16/22.
//

import SwiftUI
import AVFoundation
import Camera_SwiftUI
import Combine
struct HomeView: View {
    @State var message: String = ""
    @State var emoji: String = ""
    @StateObject var model = CameraModel()
    @State var friendsShow: Bool = false
    @State var loading: Bool = false
    @State var finished: Bool = false
    init() {
    }
    var captureButton: some View {
        Button(action: {
            model.capturePhoto()
        }, label: {
            Circle()
                .foregroundColor(.white)
                .frame(width: 80, height: 80, alignment: .center)
                .overlay(
                    Circle()
                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
                        .frame(width: 65, height: 65, alignment: .center)
                )
        })
    }
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.friendsShow = true
                }, label: {
                    Image(systemName: "person.2.fill")
                }).popover(isPresented: $friendsShow, content: {FriendsList()}).buttonStyle(.plain)
                
                Spacer()
                Image(systemName: "person.fill")
            }
            Spacer()
            CameraPreview(session: model.session)
                .onAppear {
                    model.configure()
                }
                .alert(isPresented: $model.showAlertError, content: {
                    Alert(title: Text(model.alertError.title), message: Text(model.alertError.message), dismissButton: .default(Text(model.alertError.primaryButtonTitle), action: {
                        model.alertError.primaryAction?()
                    }))
                })
                .overlay(
                    Group {
                        if model.willCapturePhoto {
                            Color.black
                        }
                    }
                )
                .animation(.easeInOut)
            captureButton
            TextField("Message", text: $message)
            TextField("Emoji", text: $emoji)
            Spacer()
            Button(action: {
                self.loading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.loading = false
                    self.finished = true
                    message = ""
                    emoji = ""
                }
            }, label: {
                Image(systemName: "arrow.up.message.fill").resizable().aspectRatio(contentMode: .fit).frame(height: 40)
            }).buttonStyle(.plain)
            Group {
                if loading {
                    ProgressView()
                } else {
                    EmptyView()
                }
            }
            Group {
                if finished {
                    Text("Uploaded!")
                } else {
                    EmptyView()
                }
            }
            
        }.padding()
    }
}
final class CameraModel: ObservableObject {
    private let service = CameraService()
    
    @Published var photo: Photo!
    
    @Published var showAlertError = false
    
    @Published var isFlashOn = false
    
    @Published var willCapturePhoto = false
    
    var alertError: AlertError!
    
    var session: AVCaptureSession
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.session = service.session
        
        service.$photo.sink { [weak self] (photo) in
            guard let pic = photo else { return }
            self?.photo = pic
        }
        .store(in: &self.subscriptions)
        
        service.$shouldShowAlertView.sink { [weak self] (val) in
            self?.alertError = self?.service.alertError
            self?.showAlertError = val
        }
        .store(in: &self.subscriptions)
        
        service.$flashMode.sink { [weak self] (mode) in
            self?.isFlashOn = mode == .on
        }
        .store(in: &self.subscriptions)
        
        service.$willCapturePhoto.sink { [weak self] (val) in
            self?.willCapturePhoto = val
        }
        .store(in: &self.subscriptions)
    }
    
    func configure() {
        service.checkForPermissions()
        service.configure()
    }
    
    func capturePhoto() {
        service.capturePhoto()
    }
    
    func flipCamera() {
        service.changeCamera()
    }
    
    func zoom(with factor: CGFloat) {
        service.set(zoom: factor)
    }
    
    func switchFlash() {
        service.flashMode = service.flashMode == .on ? .off : .on
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
