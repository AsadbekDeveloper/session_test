# 📆 Session Viewer App

A Flutter application for viewing customer sessions grouped by date, built with **BLoC state management** and **Clean Architecture**. Designed as a test project to demonstrate scalable code structure, maintainable logic, and smooth user experience.

---

## 🚀 Features

- 🔹 Display sessions grouped by `date`
- 🔹 Show `total amount` per date group
- 🔹 Real-time `search` by customer name with debounce
- 🔹 `Sticky headers` for grouped sections
- 🔹 `Pull-to-refresh` to reload data
- 🔹 Clean loading, success, and error state handling
- 🔹 Modular and testable codebase with **Clean Architecture**

---

## 🧱 Tech Stack

| Layer         | Tech                          |
|---------------|-------------------------------|
| Language      | Dart                          |
| Framework     | Flutter                       |
| State Mgmt    | flutter_bloc, equatable       |
| Architecture  | Clean Architecture            |
| Testing       | bloc_test, mocktail           |
| Tooling       | Dart DevTools, VS Code        |


---

## 🧪 Testing

Unit tests are written for both the repository and the BLoC to ensure logic correctness.

### Run Tests

```bash
flutter test
