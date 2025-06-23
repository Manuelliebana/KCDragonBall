# Dragon Ball Heroes App 🐉

Aplicación iOS desarrollada como parte de la entrega del curso de KeepCoding. La app consume la API REST de Dragon Ball para mostrar un listado de héroes y sus transformaciones, siguiendo una arquitectura MVC y utilizando exclusivamente ficheros `.xib` para el diseño de interfaces.

---

## 🌟 Características Principales

-   **Login de Usuario**: Autenticación segura contra la API (`/api/auth/login`) para obtener un token de acceso.
-   **Listado de Héroes**: Visualización de todos los héroes disponibles (`/api/heros/all`) en una `UITableView` con celdas personalizadas.
-   **Detalle de Héroe**: Pantalla con información detallada de cada héroe, incluyendo su nombre, descripción completa e imagen.
-   **Listado de Transformaciones**: Muestra todas las transformaciones disponibles para un héroe específico (`/api/heros/tranformations`).
-   **Visibilidad Dinámica**: El botón para ver las transformaciones solo aparece si el héroe seleccionado realmente tiene transformaciones, mejorando la experiencia de usuario.
-   **Layouts Adaptables**: Las vistas de Login y Detalle de Héroe utilizan `UIScrollView` para garantizar una correcta visualización tanto en modo vertical como horizontal, evitando que el contenido se corte al girar el dispositivo.
-   **Celdas con Altura Dinámica**: La lista de transformaciones ajusta la altura de cada celda automáticamente para mostrar la descripción completa, sin importar su longitud.

---

## 🏗️ Arquitectura

El proyecto sigue estrictamente la arquitectura **Modelo-Vista-Controlador (MVC)** para asegurar una separación clara de responsabilidades:

-   **Modelo**: Gestiona los objetos de datos (`Hero`, `Transformation`) y la lógica de comunicación con la API (`APIClient`, `NetworkModel`). Es agnóstico a la interfaz de usuario.
-   **Vista**: Compuesta por ficheros `.xib` y las clases de vista asociadas (`HeroTableViewCell.swift`, `TransformationTableViewCell.swift`). Son los elementos visuales que el usuario ve.
-   **Controlador**: Actúa como intermediario, conectando el Modelo con la Vista. Se encarga de la lógica de la aplicación y la navegación (`LoginViewController`, `HeroListTableViewController`, etc.).

---

## 🛠️ Tecnologías Utilizadas

-   **Lenguaje**: Swift
-   **Framework**: UIKit
-   **Diseño de UI**: `.xib` con Auto Layout y `UIStackView`.
-   **Networking**: `URLSession` para realizar las llamadas a la API REST.
-   **Concurrencia**: Completion Handlers (`@escaping`) para manejar las respuestas asíncronas de la red.
-   **Testing**: `XCTest` para la implementación de pruebas unitarias.

---

## 🧪 Pruebas Unitarias

Se ha implementado una suite de tests unitarios robusta para la capa de Modelo, cubriendo los requisitos de la práctica:

1.  **Test de Login**: Verifica tanto el flujo de éxito (asegurando que se recibe un token) como el de fallo.
2.  **Test de Transformaciones**: Asegura que la obtención de las transformaciones de un héroe funciona correctamente.
3.  **Aislamiento con Mocks**: Se utiliza un `APIClientMock` para simular las respuestas de la red, permitiendo tests rápidos y fiables que no dependen de una conexión a internet.
4.  **Manejo de Asincronía**: Los tests de red utilizan `XCTestExpectation` para gestionar correctamente las respuestas asíncronas, evitando condiciones de carrera.

---

## 🚀 Cómo ejecutar el proyecto

1.  Clona este repositorio en tu máquina local.
2.  Abre el archivo `KCDragonBall.xcodeproj` con Xcode.
3.  Selecciona un simulador de iPhone y pulsa **Run** (o `⌘+R`).

---

## ✍️ Autor

Desarrollado por **Manuel Liebana Montoro**. 