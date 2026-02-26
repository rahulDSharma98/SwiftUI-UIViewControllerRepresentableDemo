//
//  ContentView.swift
//  SwiftUI_CollectionViewRepresentableDemo
//
//  Created by MACM62 on 22/01/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            //Background Layer
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .ignoresSafeArea()
            
            //ContentLayer
            CollectionViewRepresentable()
        }
    }
}

struct CollectionViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView = UICollectionView()
        
        collectionView.delegate = context.coordinator.delegate
        collectionView.dataSource = context.coordinator.dataSource
        collectionView.alwaysBounceVertical = false
        collectionView.allowsMultipleSelection = false
        
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(dataSource: <#T##CollectionViewDataSource#>, delegate: <#T##CollectionViewDelegate#>)
    }
    
    class Coordinator: NSObject {
        let dataSource: CollectionViewDataSource
        let delegate: CollectionViewDelegate
        
        init(dataSource: CollectionViewDataSource, delegate: CollectionViewDelegate) {
            self.dataSource = dataSource
            self.delegate = delegate
        }
    }
    
    class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return UICollectionViewCell()
        }
    }
    
    class CollectionViewDelegate: NSObject, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        }
    }
}

#Preview {
    ContentView()
}
