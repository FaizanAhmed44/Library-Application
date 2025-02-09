# 📚 **Litereasy - Online Library Management App**  

**Litereasy** is a Flutter-based online library management application that allows users to explore, read, and manage books digitally. The app integrates Firebase for authentication, database storage, and book management, providing a seamless reading experience. Users can search for books, filter them by category, add favorites to a wishlist, and manage their profiles, while admins can add, update, and delete books.




---





![15+ Screens](https://github.com/user-attachments/assets/8862a18d-5136-47d7-86b7-62b7db1c1efd)





---




## 📖 **Table of Contents**
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Screenshots](#screenshots)
- [How It Works](#how-it-works)
- [Firebase Configuration](#firebase-configuration)
- [Admin Panel](#admin-panel)
- [License](#license)
- [Author](#author)  




---





## 🎯 **Features**  
✔️ **15+** beautifully designed screens for an intuitive reading experience.  
✔️ **User Authentication:** Sign in, sign up, and Google authentication.  
✔️ **Book Listings:** Users can browse and search for books.  
✔️ **Book Categories:** Books are categorized (Mystery, Comics, Thriller, etc.).  
✔️ **Book Details:** Detailed view with book covers, descriptions, and authors.  
✔️ **Read Online:** Users can read books directly within the app.  
✔️ **Search & Filter:** Advanced search and filtering options.  
✔️ **Wishlist:** Save favorite books for later.  
✔️ **Book Ratings & Reviews:** Users can **rate books** and leave reviews.  
✔️ **Admin Panel:** Add, update, and delete books.  
✔️ **Profile Management:** Users can edit and update their profiles.  




---





## 💻 **Tech Stack**
- **Frontend:** Flutter (Dart)  
- **Backend:** Firebase (Firestore, Authentication, Storage)  
- **State Management:** Provider  
- **Database:** Firestore (NoSQL)  
- **Authentication:** Firebase Auth  
- **Storage:** Firebase Storage (for book covers)  





---





## 🛠 **Installation**  

1️⃣ **Clone the Repository**  
```bash
git clone https://github.com/your-github-username/litereasy.git
```

2️⃣ **Navigate to the Project Directory**  
```bash
cd litereasy
```

3️⃣ **Install Dependencies**  
```bash
flutter pub get
```

4️⃣ **Run the App**  
```bash
flutter run
```





---





## 📂 **Project Structure**
```
litereasy/
│── 📦 your-flutter-app-repo
├── 📂 lib
│   ├── 📂 const
│   ├── 📂 features
│   │   ├── 📂 admin
│   │   │   ├── 📂 admin_methods
│   │   │   ├── 📂 book_management
│   │   │   ├── 📂 chat
│   │   │   ├── 📂 dashboard
│   │   │   ├── 📂 profile
│   │   │   ├── 📜 upload_books.dart
│   │   ├── 📂 login
│   │   │   ├── 📂 logic
│   │   │   ├── 📂 model
│   │   │   ├── 📂 view
│   │   ├── 📂 Shared
│   │   │   │   ├── 📜 helperclass.dart
│   │   │   │   ├── 📜 sharedclass.dart
│   │   ├── 📂 user
│   │   │   ├── 📂 book_categories
│   │   │   ├── 📂 book_detail
│   │   │   ├── 📂 book_reader
│   │   │   ├── 📂 bottomnavigation
│   │   │   ├── 📂 favorite
│   │   │   ├── 📂 help_center
│   │   │   ├── 📂 home
│   │   │   ├── 📂 profile
│   │   │   ├── 📂 search
│   │   │   ├── 📂 settings
│   │   │   ├── 📜 upload_books.dart
├── 📂 theme
├── 📂 utils
├── 📜 firebase_options.dart
├── 📜 main.dart
└── 📜 README.md
│── assets/
│── pubspec.yaml
│── README.md
```





### 📂 **Main Folder Breakdown**
- lib/ → Main application codebase, including features, UI, and logic.
- theme/ → Defines app-wide styling, colors, and fonts.
- utils/ → Contains utility functions and helper classes.
- assets/ → Stores static resources like images, icons, and fonts.
- firebase_options.dart → Firebase configuration settings.
- main.dart → Entry point of the Flutter application.
- pubspec.yaml → Defines dependencies, assets, and app configurations.
- README.md → Project documentation file.






---





## 📸 **Screenshots**
> Add screenshots of your application for better visibility.  
> ![Screenshot](https://github.com/user-attachments/assets/example1.png)  
> ![Screenshot](https://github.com/user-attachments/assets/example2.png)





---





## ⚙️ **How It Works**
### 1️⃣ User Authentication  
- Users can **sign up** using email and password.  
- **Google sign-in** is available for quick access.  
- Firebase Authentication handles login and logout securely.  

### 2️⃣ Browsing & Searching Books  
- Users can browse through a **list of books**.  
- Books are categorized into **Mystery, Comics, Thriller, etc.**  
- Advanced search allows finding specific books.  

### 3️⃣ Reading & Wishlist  
- Users can **read books online** directly in the app.  
- Favorite books can be saved to the **wishlist** for later reading.  

### 4️⃣ Profile Management  
- Users can **edit and update** their profiles.  

### 5️⃣ Admin Functionalities  
- Admins can **add, update, and delete books**.  





---





## 🔥 **Firebase Configuration**
1️⃣ Create a **Firebase Project**  
2️⃣ Add an **Android & iOS App**  
3️⃣ Download the **google-services.json** file and place it inside:  
```
android/app/
```
4️⃣ Enable **Authentication** (Email/Google)  
5️⃣ Set up **Firestore Database** with a collection for **books, users, and categories**  
6️⃣ Enable **Firebase Storage** for book covers  





---





## 🛠 **Admin Panel**
- Admins can **add, edit, and delete books**.  
- Manage book categories and track **user activities**.  
- **Secure access** to admin features.  





---





## 📜 **License**
This project is licensed under the **MIT License**.





---





## 🧑 **Author**
**Faizan Ahmed**  
🔗 **LinkedIn:** [Your LinkedIn Profile](https://www.linkedin.com/in/faizan-ahmed-303793255/)  





---





### ⭐ **Support & Follow**
If you liked this repo, please **support it by giving a star ⭐!**  
Also, follow my **GitHub profile** to stay updated about my latest projects:  
🔗 **GitHub:** [Your GitHub Profile](https://github.com/FaizanAhmed44)



---


