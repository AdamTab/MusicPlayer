//
//  ImportFileManager.swift
//  MusicPlayer
//
//  Created by Адам Табиев on 01.07.2024.
//

import Foundation
import SwiftUI
import AVFoundation
import RealmSwift

/// ImportFileManager позволяет выбирать аудио файлы и импортировать их в приложение
struct ImportFileManager: UIViewControllerRepresentable {
    
//    @Binding var songs: [SongModel] избавляемся из за  @ObservedResults(SongModel.self) var songs
    
    /// координатор управлять задачами между SwiftUI и UIKit
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    /// Метод который создает и настраивает UIDocumentPickerViewController, который используется для выбора аудиофайлов.
    func makeUIViewController(context: Context) -> some UIDocumentPickerViewController {
        /// Разрешение открытия файлов с типом "public.audio" (MP3, WAV). Другие форматы: "public.image" (jPEG, PNG,TIF)...
        let picker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .open)
        /// Разрешение выбрать только один файл
        picker.allowsMultipleSelection = false
        /// Показ разрешения файлов
        picker.shouldShowFileExtensions = true
        /// Установка координатора в качестве делегата
        picker.delegate = context.coordinator
        return picker
    }
    
    /// Метод предназначен для обновления контроллера новыми данными. В данном случае он пуст. Так как все необходимые настройки выполнены при создании.
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    
    /// Координатор служит связующим звеном между UIDocumenPicker и ImportFileManager
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        
        
        /// ССылка на родительский компонент ImportFileManager, чтобы можно было с ним взаимодействовать
        var parent: ImportFileManager
        @ObservedResults(SongModel.self) var songs
 
        init(parent: ImportFileManager) {
            self.parent = parent
        }
        
        // Метод вызывается когда пользователь выбирает файл и после выбора добавляет песню в массив songs
        // Метод обрабатывает выбранный URL и создает песню типом SongModel с помощью обработчика documentPicker
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            // guard let, безопасно извлекает первый элемент из массива urls. Если массив пуст, то urls.first вернет nil и условие не пропустит что приведет к выходу из метода documentPicker
            guard let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
            
            // Гарантирует что метод stopAccessingSecurityScopedResource вызывается для начала доступа к защищенному ресурсу
            // или нет и ресурс безопасности будет закрыт и корректно освобожден из памяти
            defer { url.stopAccessingSecurityScopedResource() }
            
            do {
                // Получение данных файла
                let document = try Data(contentsOf: url)
                
                // Создание AVAsset для извлечения метаданных
                let asset = AVAsset(url: url)
                
                // Инициализируем объект SongModel
                var song = SongModel(name: url.lastPathComponent, data: document)
                
                // Цикл для итерации по метаданным аудиофайла чтобы извлечь (исполнитель, обложка, название)
                let metadata = asset.metadata
                for item in metadata {
                    
                    /// Проверяет есть ли метаданные у файла через ключ / значение
                    guard let key = item.commonKey?.rawValue, let value = item.value else { continue }
                    switch key {
                    case AVMetadataKey.commonKeyArtist.rawValue:
                        song.artist = value as? String
                    case AVMetadataKey.commonKeyArtwork.rawValue:
                        song.coverImage = value as? Data
                    case AVMetadataKey.commonKeyTitle.rawValue:
                        song.name = value as? String ?? song.name
                    default:
                        break
                    }
                }
                
                /// Получения продолжительности песни
                song.duration = CMTimeGetSeconds(asset.duration)

                let isDuplicate = songs.contains { $0.name == song.name && $0.artist == song.artist }
                
                /// Добавление песни в массив songs если там такой ешще нет
                if !isDuplicate {
                    $songs.append(song)
                } else {
                    print("Song with the same name already exists")
                }
            } catch {
                print("Error processing the file: \(error)")
            }
        }
    }
}
