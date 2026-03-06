TestNatife  
**Опис:**

Екрани(“додаток”) для перегляду стрічки постів з можливістю розгортання тексту та перегляду детальної інформації про кожен пост.

**Архітектура:**

Проєкт побудований на основі патерну MVVM:

**Model** \- Post, PostDetail \- структури даних, що відповідають JSON з API.  
**ViewModel** \- HomeViewModel, DetailViewModel  \- завантаження даних через NetworkManager, передача результатів у ViewController через коллбек.  
**View** \- HomeVC, DetailVC відображення даних.

**Структура проєкту:**

Model.swift \- моделі для списку постів (Post, PostList).  
PostDetail.swift \- моделі для детального поста (PostDetail, PostDetailList).  
NetworkManager.swift \- сервіс для роботи з API.  
HomeVC.swift \- головний екран зі стрічкою постів.  
HomeViewModel.swift \- логіка завантаження постів для головного екрана.  
PostCell.swift \- кастомна ячейка для UICollection.  
DetailVC.swift \- екран детального перегляду поста.  
DetailViewModel.swift \- логіка завантаження поста за id.  
UIImageView+URL.swift \- розширення для завантаження URL зображень.  
UIView+Extensions.swift \- розширення.

**Прийняті рішення:**

UICollectionView \+ UICompositionalLayout \- для побудови списку.  
DiffableDataSource \- для оновлення даних у колекції.  
Callback замість Combine \- для простоти та зрозумілості коду.  
