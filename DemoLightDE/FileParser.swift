
//
//  FileParser.swift
//  DemoLightDE
//
//  Created by Jonas Hoang on 23/7/25.
//

import Foundation
import PDFKit
import AppKit

enum FileParser {
    static func extractText(from url: URL) -> String? {
        switch url.pathExtension.lowercased() {
        case "pdf":
            return extractFromPDF(url)
        case "txt":
            return try? String(contentsOf: url, encoding: .utf8)
        case "docx":
            return extractFromDocx(url)
        default:
            return nil
        }
    }

    private static func extractFromPDF(_ url: URL) -> String? {
        guard let pdf = PDFDocument(url: url) else { return nil }
        var text = ""
        for i in 0..<pdf.pageCount {
            text += pdf.page(at: i)?.string ?? ""
        }
        return text
    }

    private static func extractFromDocx(_ url: URL) -> String? {
        guard let fileWrapper = try? FileWrapper(url: url, options: .immediate) else { return nil }
        let docPath = "word/document.xml"
        if let docData = fileWrapper.fileWrappers?[docPath]?.regularFileContents,
           let xml = String(data: docData, encoding: .utf8) {
            return xml.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        }
        return nil
    }
}
