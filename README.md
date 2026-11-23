# Mijusan Store — Jakarta Servlet & JSP Architecture

This project is a migration of the **Mijusan** e-commerce website from Laravel/PHP to a clean **Jakarta Servlet, JSP, JSTL (EL), DAO, Service, and JDBC** architecture running on Java 17+ and Apache Tomcat.

---

## 🏗️ Architecture Layers

```
Browser
   │  (HTTP Request)
   ▼
Controller / Servlet (com.mijusan.controller)
   │
   ▼
Service Layer (com.mijusan.service)
   │
   ▼
DAO Layer (com.mijusan.dao)
   │  (JDBC / SQL)
   ▼
SQLite Database (WEB-INF/database.sqlite)
```

1. **Model** (`com.mijusan.model`):
   - Pure POJOs representing application data: `Product`, `Category`, `User`, `CartItem`, `Order`, `Wishlist`.
2. **DAO** (`com.mijusan.dao`):
   - Data access objects managing JDBC `PreparedStatement` queries and CRUD operations:
     - `ProductDAO`, `UserDAO`, `CartDAO`, `OrderDAO`, `WishlistDAO`, `CategoryDAO`.
3. **Service** (`com.mijusan.service`):
   - Business logic, pricing, validation, and transaction coordination:
     - `ProductService`, `UserService`, `CartService`, `OrderService`, `WishlistService`, `CategoryService`.
4. **Controller / Servlet** (`com.mijusan.controller`):
   - Handling HTTP requests, authentication verification, routing, attribute forwarding:
     - `HomeServlet`, `ProductDetailServlet`, `SearchServlet`, `CartServlet`, `WishlistServlet`, `OrderServlet`, `AdminServlet`, `CategoryServlet`, `AuthServlet`.
5. **Views / JSP** (`src/main/webapp/WEB-INF/views/`):
   - Secure server-rendered views with JSTL & Expression Language (EL). Direct JSP file browsing is protected by `WEB-INF/`.

---

## 🛠️ CRUD Features Implemented

1. **Product CRUD (Admin)**: Create, Read (catalog & detail), Update (edit details & pricing), Delete products.
2. **Category / Catalog CRUD & Filter**: Browse, filter products by category (`top`, `outer`, `bottom`), update category names, and remove category associations.
3. **Shopping Cart CRUD (Customer)**: Add product to cart (Create), view cart list (Read), update item quantity (Update), remove items from cart (Delete).
4. **Wishlist CRUD (Customer)**: Save product to wishlist (Create), view wishlist (Read), toggle/remove from wishlist (Delete).
5. **Order Placement & Management CRUD (Customer & Admin)**: Place direct or cart checkout orders (Create), view customer order history (Read), update order status (Update), delete orders (Delete).
6. **User & Account CRUD (Admin)**: Add user (Create), list & paginate users (Read), modify user roles (Update), delete user accounts (Delete).
7. **User Profile & Authentication**: Register customer account (Create), authenticate sessions (Read), update password / details.
8. **Catalog Search & Discovery**: Dynamic search across product titles, categories, and descriptions.

---

## 🚀 How to Build & Run

### 1. Build the WAR Artifact
Using the included Maven wrapper:
```bash
./mvnw clean package
```
This produces `target/ROOT.war` ready to deploy on any Servlet 5.0+ / 6.0 container (e.g. Apache Tomcat 10+).

### 2. Deploy on Tomcat
Deploy `target/ROOT.war` into Tomcat's `webapps/` folder:
```bash
cp target/ROOT.war /path/to/tomcat/webapps/ROOT.war
/path/to/tomcat/bin/startup.sh
```
Access the application at `http://localhost:8080/`.

---

## 👥 Demo Credentials
- **Administrator**: `admin@mijusan.com` / `password`
- **Customer**: `sarah.smith@example.com` / `password`
