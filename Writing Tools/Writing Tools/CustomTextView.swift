//
//  CustomTextView.swift
//  Writing Tools
//
//  Created by NEMSOTHEA on 2/12/25.
//

import SwiftUI

#if os(iOS)
import UIKit
struct CustomTextView: UIViewRepresentable {
    
    @Binding var text: String
    
    var onStartTimer: () -> Void
    var onStopTimer: () -> Void
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 17)
        textView.delegate = context.coordinator
        textView.backgroundColor = UIColor.clear // Transparent background
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        if textView.text != text {
            textView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextView
        
        init(parent: CustomTextView) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            parent.onStartTimer()
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            parent.onStopTimer()
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}
#endif

#if os(macOS)
import Cocoa

struct CustomTextView: NSViewRepresentable {
    
    @Binding var text: String
    
    var onStartTimer: () -> Void
    var onStopTimer: () -> Void
    
    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.borderType = .bezelBorder
        
        let textView = NSTextView()
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 30)
        textView.delegate = context.coordinator
        textView.backgroundColor = .clear // Transparent background
        textView.isAutomaticTextCompletionEnabled = true
        
        scrollView.documentView = textView
        return scrollView
    }
    
    func updateNSView(_ nsView: NSScrollView, context: Context) {
        if let textView = nsView.documentView as? NSTextView, textView.string != text {
            textView.string = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: CustomTextView
        
        init(parent: CustomTextView) {
            self.parent = parent
        }
        
        func textDidBeginEditing(_ notification: Notification) {
            parent.onStartTimer()
        }
        
        func textDidEndEditing(_ notification: Notification) {
            parent.onStopTimer()
        }
        
        func textDidChange(_ notification: Notification) {
            if let textView = notification.object as? NSTextView {
                parent.text = textView.string
            }
        }
    }
}
#endif




