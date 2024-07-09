//
//  Model.swift
//  MusicPlayer
//
//  Created by Адам Табиев on 28.06.2024.
//

import Foundation
import RealmSwift

//struct SongModel: Identifiable {
//    var id = UUID()
//    var name: String
//    var data: Data
//    var artist: String?
//    var coverImage: Data?
//    var duration: TimeInterval?
//}

class SongModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var data: Data
    @Persisted var artist: String?
    @Persisted var coverImage: Data?
    @Persisted var duration: TimeInterval?
    
    convenience init(name: String, data: Data, artist: String? = nil, coverImage: Data? = nil, duration: TimeInterval? = nil) {
        self.init()
        self.name = name
        self.data = data
        self.artist = artist
        self.coverImage = coverImage
        self.duration = duration
    }
}


/*
 

    - Мы создаем класс `SongModel`, который наследуется от класса `Object`. Это необходимо для использования с базой данных Realm.
    - `ObjectKeyIdentifiable` помогает Realm идентифицировать объекты в базе данных.

 2. **`@Persisted`**:
    - Это аннотация, которая указывает, что это свойство должно быть сохранено в базе данных Realm.

 3. **Свойства класса**:
    - `@Persisted(primaryKey: true) var _id: ObjectId`: Это уникальный идентификатор для каждой песни. Он используется как основной ключ.
    - `@Persisted var name: String`: Имя песни.
    - `@Persisted var data: Data`: Данные песни (например, аудиофайл).
    - `@Persisted var artist: String?`: Имя артиста (опционально, может быть пустым).
    - `@Persisted var coverImage: Data?`: Данные обложки песни (опционально, может быть пустым).
    - `@Persisted var duration: TimeInterval?`: Продолжительность песни (опционально, может быть пустым).

 ### Конструктор

 1. **`convenience init`**:
    - Это удобный (convenience) инициализатор, который позволяет легко создавать объекты `SongModel` с указанными параметрами.

 2. **Инициализация свойств**:
    - `self.init()`: Вызов основного инициализатора класса.
    - `self.name = name`: Установка имени песни.
    - `self.data = data`: Установка данных песни.
    - `self.artist = artist`: Установка имени артиста.
    - `self.coverImage = coverImage`: Установка обложки песни.
    - `self.duration = duration`: Установка продолжительности песни.

 Этот код позволяет вам создавать и сохранять информацию о песнях в базе данных Realm. Вы можете создать новый объект `SongModel` и заполнить его данными для хранения и последующего использования.
 
 */
