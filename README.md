# AI Chat Application

A robust and interactive Flutter chat application developed as part of a university project. This app features a clean architecture and integrates both premium and free AI APIs to ensure seamless user interaction.

## 🚀 Features

* **Dual API Integration:** * Primary: **OpenAI API** for dynamic, intelligent conversations.
    * Fallback/Free: **DummyJSON Quotes API** ensures the app remains functional and responsive even when OpenAI quotas are exceeded.
* **Robust Error Handling:** Gracefully handles API limits, timeouts, and connection errors without crashing, displaying user-friendly error bubbles.
* **Clean Folder Structure:** Organized codebase following best practices (Models, Views/Screens, Providers, Services, Widgets).
* **State Management:** Utilizes the `provider` package for efficient state updates (Theme, Auth, and Chat states).
* **Dynamic UI/UX:**
    * Light and Dark mode toggle.
    * Auto-scrolling to the latest message.
    * Lottie animations for empty states.
* **Secure API Keys:** Uses `flutter_dotenv` to keep API keys secure and out of version control.

## 📁 Folder Structure

```text
lib/
 ┣ providers/       # State management classes (AuthProvider, ChatProvider, ThemeProvider)
 ┣ screens/         # UI Screens (LoginScreen, ChatScreen, Root)
 ┣ services/        # API call logic (OpenAIService, FreeApiService)
 ┣ widgets/         # Reusable UI components (MessageBubble)
 ┗ main.dart        # Entry point of the application