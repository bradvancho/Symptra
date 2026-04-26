//
//  ReportWebView.swift
//  Symptra
//

import SwiftUI
import UIKit
@preconcurrency import WebKit

struct ReportWebView: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> WKWebView {
        let v = WKWebView()
        v.isOpaque = false
        return v
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(html, baseURL: nil)
    }
}
