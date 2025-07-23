//
//  OCRImportView.swift
//  DemoLightDE
//
//  Created by Jonas Hoang on 23/7/25.
//

import SwiftUI
import Vision
import PDFKit
import UniformTypeIdentifiers

struct OCRImportView: View {
    @ObservedObject var storage: EntryStorage
    @State private var extractedText: String = ""
    @State private var isImporting = false
    @State private var selectedFileURL: URL?


    var body: some View {
        VStack(spacing: 20) {
            Text("📥 Nhận diện văn bản (OCR/File)").font(.title2).bold()

            TextEditor(text: $extractedText)
                .border(Color.gray)
                .frame(height: 200)
                .onDrop(of: [.fileURL], isTargeted: nil) { providers in
                    handleDrop(providers: providers)
                    return true
                }

            Button("📄 Phân tích văn bản") {
                parseExtractedText()
            }
            
            Button("📂 Chọn file từ máy...") {
                isImporting = true
            }
            .fileImporter(
                isPresented: $isImporting,
                allowedContentTypes: [
                    .pdf,
                    .plainText,
                    UTType(filenameExtension: "docx")!,
                    UTType.image, // ✅ Cho phép ảnh
                    UTType(filenameExtension: "webp")! // ✅ WebP
                ],
                allowsMultipleSelection: false
            ) { result in
                do {
                    guard let selectedURL = try result.get().first else { return }
                    selectedFileURL = selectedURL
                    parseFile(at: selectedURL)
                } catch {
                    extractedText = "❌ Không thể mở file."
                }
            }


            Button("➕ Lưu vào danh sách") {
                let parsed = ParsedFields.from(text: extractedText)
                let newEntry = EntryModel(
                    fullName: parsed.fullName,
                    identityNumber: parsed.cccd,
                    employeeID: parsed.employeeID,
                    signingDate: Date(),
                    note: "Tự động OCR",
                    department: "Chưa rõ",
                    date: Date()
                )
                storage.add(newEntry)
                extractedText = ""
            }
            .disabled(extractedText.isEmpty)
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }

    private func handleDrop(providers: [NSItemProvider]) {
        for provider in providers {
            provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, _ in
                guard let data = item as? Data,
                      let url = URL(dataRepresentation: data, relativeTo: nil) else { return }

                DispatchQueue.main.async {
                    parseFile(at: url)
                }
            }
        }
    }
    
    private func recognizeTextFromImage(_ cgImage: CGImage) {
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                DispatchQueue.main.async {
                    extractedText = "❌ Không nhận diện được chữ trong ảnh."
                }
                return
            }

            let text = observations
                .compactMap { $0.topCandidates(1).first?.string }
                .joined(separator: "\n")

            DispatchQueue.main.async {
                extractedText = text
            }
        }

        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["vi-VN", "en-US"] // ✅ Tùy chỉnh ngôn ngữ

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch {
                DispatchQueue.main.async {
                    extractedText = "❌ Lỗi khi xử lý ảnh."
                }
            }
        }
    }

    private func parseFile(at url: URL) {
        let imageTypes = ["jpg", "jpeg", "png", "webp"]
        let ext = url.pathExtension.lowercased()

        if imageTypes.contains(ext),
           let nsImage = NSImage(contentsOf: url),
           let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil) {
            recognizeTextFromImage(cgImage)
        } else {
            extractedText = FileParser.extractText(from: url) ?? "❌ Không thể đọc nội dung file."
        }
    }

    private func parseExtractedText() {
        let fields = ParsedFields.from(text: extractedText)
        extractedText = """
        🔍 Đã tìm thấy:
        Họ tên: \(fields.fullName)
        CCCD: \(fields.cccd)
        ID Nhân viên: \(fields.employeeID)
        """
    }
}
