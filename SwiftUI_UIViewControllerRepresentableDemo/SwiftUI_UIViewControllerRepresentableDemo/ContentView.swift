//
//  ContentView.swift
//  SwiftUI_UIViewControllerRepresentableDemo
//
//  Created by MACM62 on 22/01/26.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var showImagePicker: Bool = false
    @State private var pickedImage: UIImage? = nil
    
    var body: some View {
        VStack {
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Pick An Image")
            }.sheet(isPresented: $showImagePicker) {
                UIImagePickerControllerRepresentable(pickedImage: $pickedImage, showImagePicker: $showImagePicker)
            }
            
            if let image = pickedImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .aspectRatio(contentMode: .fill)
                    .background(Color.blue)
            }
        }
    }
}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    @Binding var pickedImage: UIImage?
    @Binding var showImagePicker: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = createNewImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $pickedImage, showImagePicker: $showImagePicker)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var pickedImage: UIImage?
        @Binding var showImagePicker: Bool
        
        init(image: Binding<UIImage?>, showImagePicker: Binding<Bool>) {
            self._pickedImage = image
            self._showImagePicker = showImagePicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.showImagePicker = false
            self.pickedImage = image
        }
    }
}

extension UIImagePickerControllerRepresentable {
    func createNewImagePickerController() -> UIImagePickerController {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = (UIImagePickerController.isSourceTypeAvailable(.photoLibrary) ? .photoLibrary : .savedPhotosAlbum)
        imagePicker.mediaTypes = [UTType.jpeg.identifier, UTType.png.identifier, UTType.image.identifier]
        
        return imagePicker
    }
}

#Preview {
    ContentView()
}
