# 🛍️ Mijusan Store — Jakarta Servlet & JSP Architecture

> 🌐 **Live Website**: [https://mijusan-76f5f.containers.snapdeploy.app/](https://mijusan-76f5f.containers.snapdeploy.app/)

Mijusan is a full-featured minimalist fashion e-commerce web platform. This project represents a complete architectural migration from Laravel/PHP to a decoupled, robust **Java / Jakarta Servlet 6.0, JSP, JSTL & EL, DAO, Service, and JDBC** stack running on Apache Tomcat 10+ with SQLite.

The platform retains the original custom design, responsive mobile layouts, SVG visualizers, interactive carousels, and multi-tier role hierarchy while adhering strictly to enterprise MVC layer responsibilities.

---

## 📋 Table of Contents
- [Live Demo](#-live-demo)
- [System Requirements](#-system-requirements)
- [Quick Start Guide](#-quick-start-guide)
- [Docker & Cloud Deployment](#-docker--cloud-deployment)
- [Step-by-Step Manual Setup](#-step-by-step-manual-setup)
- [Architecture & Layer Responsibilities](#-architecture--layer-responsibilities)
- [Project Directory Structure](#-project-directory-structure)
- [Database Schema & SQLite Management](#-database-schema--sqlite-management)
- [Role Hierarchy & Demo Accounts](#-role-hierarchy--demo-accounts)
- [CRUD Features Overview](#-crud-features-overview)
- [Mobile & Responsive Optimization](#-mobile--responsive-optimization)
- [Troubleshooting & Common Issues](#-troubleshooting--common-issues)

---

## 🌐 Live Demo

The application is deployed and publicly accessible at:
👉 **[https://mijusan-76f5f.containers.snapdeploy.app/](https://mijusan-76f5f.containers.snapdeploy.app/)**

### Demo Accounts for Testing
- **Creator Account** (Full system access, modify all roles):
  - Email: `creator@mijusan.com`
  - Password: `Mijusan2910@)`
- **Administrator Account** (Store & order management):
  - Email: `admin@mijusan.com`
  - Password: `password`
- **Customer Account** (Shopping, orders, wishlist):
  - Email: `sarah.smith@example.com`
  - Password: `password`

---

## 💻 System Requirements

Before running the application locally, ensure you have:
- **Operating System**: Linux (tested on Ubuntu/Debian/Arch), macOS, or Windows (WSL recommended)
- **Java Development Kit (JDK)**: Java 17 or higher (tested with OpenJDK 17 and OpenJDK 27)
  ```bash
  java -version
  ```
- **Port Availability**: Port `8080` should be free (used by Tomcat default HTTP connector)
- **Included in repository (zero external downloads needed)**:
  - Bundled Apache Maven 3.9+ via `./mvnw`
  - Pre-cached local dependencies in `.m2/repository`
  - Pre-configured standalone Apache Tomcat 10.1 in `.tomcat/`
  - Seeded SQLite database in `src/main/webapp/WEB-INF/database.sqlite`

---

## ⚡ Quick Start Guide

The easiest way to build, package, and launch the application locally is using the bundled `run.sh` script:

```bash
# 1. Navigate to the project root directory
cd webpro-d-quiz-2-2026

# 2. Grant executable permissions to wrapper and runner scripts
chmod +x run.sh mvnw .tomcat/bin/*.sh

# 3. Build and launch Tomcat
./run.sh
```

Once the console displays:
```text
[INFO] BUILD SUCCESS
...
Tomcat started.
```
Open your web browser and navigate to:
👉 **[http://localhost:8080](http://localhost:8080)**

To stop the server, press `Ctrl + C` in your terminal.

---

## 🐳 Docker & Cloud Deployment

The repository includes a multi-stage `Dockerfile` and `.dockerignore` ready for containerized hosting on platforms such as SnapDeploy, Render, Railway, Fly.io, or AWS ECS.

### 1. Build the Docker Image Locally
```bash
docker build -t mijusan-store .
```

### 2. Run the Docker Container
```bash
docker run -d -p 8080:8080 --name mijusan mijusan-store
```
Then visit `http://localhost:8080`.

### 3. Deploying to Cloud Platforms (SnapDeploy / Render)
1. Push your repository to GitHub.
2. In your cloud dashboard, create a new **Web Service** connected to your repo.
3. Select **Docker** as the runtime.
4. The service will automatically build the multi-stage image, bundle `ROOT.war` into Tomcat 10.1, and expose port `8080`.
5. *(Optional)* If you wish to attach persistent disk storage for the database, set the environment variable:
   ```text
   DB_PATH=/var/data/database.sqlite
   ```
   If omitted, `Database.java` defaults automatically to `/WEB-INF/database.sqlite`.

---

## 🛠️ Step-by-Step Manual Setup

If you prefer building and managing the Tomcat lifecycle manually:

### 1. Build and Package the WAR File
The project uses the bundled Maven wrapper pointing to the local offline repository:
```bash
./mvnw -DskipTests package
```
This compiles all Java source files under `src/main/java/` and bundles web assets into `target/ROOT.war`.

### 2. Deploy to Apache Tomcat
Clear any previous deployment and copy the fresh WAR into Tomcat's `webapps/`:
```bash
# Remove existing ROOT deployment
rm -rf .tomcat/webapps/ROOT .tomcat/webapps/ROOT.war

# Copy fresh WAR as ROOT (served at root context path '/')
cp target/ROOT.war .tomcat/webapps/ROOT.war
```

### 3. Start Tomcat
Set the environment variables and run Tomcat:
```bash
export CATALINA_BASE="$(pwd)/.tomcat"
export CATALINA_HOME="$(pwd)/.tomcat"

# Start Tomcat in foreground (logs directly in terminal)
./.tomcat/bin/catalina.sh run

# OR start Tomcat as a background daemon
./.tomcat/bin/startup.sh
```

### 4. Stop Tomcat
When running in daemon mode:
```bash
./.tomcat/bin/shutdown.sh

# If port 8080 remains bound:
fuser -k 8080/tcp
```

---

## 🏗️ Architecture & Layer Responsibilities

The codebase follows the strict standard **Model - View - Controller (MVC)** enterprise pattern:

```
Browser (HTTP Request)
    │
    ▼
Controller / Servlet (com.mijusan.controller)
    │
    ▼
Service Layer (com.mijusan.service)
    │
    ▼
DAO Layer (com.mijusan.dao)
    │  (JDBC PreparedStatements)
    ▼
SQLite Database (database.sqlite)
    │
    ▼ (Data Flow Back)
Servlet forwards request attributes
    │
    ▼
JSP View (WEB-INF/views/) renders HTML response
```

1. **Model Layer (`com.mijusan.model`)**:
   - Plain Old Java Objects (POJOs) with encapsulation, constructors, getters, and setters.
   - Represents domain entities: `Product`, `Category`, `User`, `CartItem`, `Order`, `Wishlist`, `ChartData`, `ChartPoint`.
   - Free of SQL, HTTP logic, or HTML tags.

2. **DAO Layer (`com.mijusan.dao`)**:
   - Handles all JDBC interactions (`PreparedStatement`, `ResultSet`, connection lifecycle).
   - Only layer that executes SQL queries. Parameterized queries eliminate SQL injection vulnerabilities.

3. **Service Layer (`com.mijusan.service`)**:
   - Encapsulates business validation, price totals, chart bucket calculations (`7d`, `1m`, `3m`, `6m`, `1y`), password hashing (`BCrypt`), and multi-DAO operations.
   - Controllers call Services; Controllers never touch DAOs directly.

4. **Controller / Servlet Layer (`com.mijusan.controller`)**:
   - Receives HTTP `GET`/`POST`, inspects query parameters and form payloads, verifies session auth, calls services, and redirects (POST/Redirect/GET) or forwards to views.
   - Contains no SQL and no HTML formatting.

5. **View / JSP Layer (`src/main/webapp/WEB-INF/views/`)**:
   - Located inside `WEB-INF/` to prevent direct public file access.
   - Powered by standard JSTL (`c:forEach`, `c:if`, `c:choose`) and EL (`${...}`).
   - Completely free of scriptlet tags (`<% ... %>`).

---

## 📁 Project Directory Structure

```text
webpro-d-quiz-2-2026/
├── pom.xml                               # Maven project descriptor (WAR packaging)
├── Dockerfile                            # Multi-stage Docker build for container deployment
├── .dockerignore                         # Docker ignore list
├── mvnw                                  # Offline Maven wrapper script
├── run.sh                                # Automated one-command build & launch script
├── .tomcat/                              # Standalone Apache Tomcat 10.1 server
├── .maven/                               # Apache Maven binary distribution
├── .m2/repository/                       # Pre-cached Maven dependencies
└── src/
    └── main/
        ├── java/com/mijusan/
        │   ├── controller/               # Jakarta Servlets (Controllers & Routing)
        │   │   ├── AdminServlet.java
        │   │   ├── AuthServlet.java
        │   │   ├── CartServlet.java
        │   │   ├── CategoryServlet.java
        │   │   ├── HomeServlet.java
        │   │   ├── OrderServlet.java
        │   │   ├── ProductDetailServlet.java
        │   │   ├── SearchServlet.java
        │   │   └── WishlistServlet.java
        │   ├── dao/                      # Data Access Objects (JDBC & SQL queries)
        │   │   ├── CartDAO.java
        │   │   ├── CategoryDAO.java
        │   │   ├── OrderDAO.java
        │   │   ├── ProductDAO.java
        │   │   ├── UserDAO.java
        │   │   └── WishlistDAO.java
        │   ├── filter/                   # Jakarta Servlet Filters
        │   │   ├── AuthFilter.java       # Secures /admin/*, /cart, /wishlist, /myorder
        │   │   └── CartCountFilter.java  # Injects dynamic cart badge count into navbar
        │   ├── listener/
        │   │   └── AppContextListener.java# Auto-initializes SQLite database path on boot
        │   ├── model/                    # Domain Entity Models & DTOs
        │   │   ├── CartItem.java
        │   │   ├── Category.java
        │   │   ├── ChartData.java
        │   │   ├── ChartPoint.java
        │   │   ├── Order.java
        │   │   ├── Product.java
        │   │   ├── ProductDTO.java
        │   │   ├── SlideItem.java
        │   │   ├── User.java
        │   │   └── Wishlist.java
        │   ├── service/                  # Business Logic & Validation Services
        │   │   ├── CartService.java
        │   │   ├── CategoryService.java
        │   │   ├── OrderService.java
        │   │   ├── ProductService.java
        │   │   ├── UserService.java
        │   │   └── WishlistService.java
        │   └── util/
        │       ├── Database.java         # JDBC Connection pooling & DB_PATH env override
        │       ├── PasswordUtil.java     # BCrypt password hashing & verification
        │       └── SlugUtil.java         # URL slug generator
        └── webapp/
            ├── assets/                   # Public CSS, JavaScript, and Media
            │   ├── css/
            │   │   ├── app-DvVTEU7i.css  # Compiled Tailwind styling
            │   │   ├── fonts-DAq_IamE.css# Fraunces and Inter webfonts
            │   │   └── mobile-responsive.css # Mobile layout, sizing & viewport adaptations
            │   ├── js/
            │   │   └── components.js     # User menu, dynamic chart tooltip & carousels
            │   └── images/               # Product lookbook and catalog photography
            └── WEB-INF/
                ├── database.sqlite       # Pre-seeded SQLite database
                ├── web.xml               # Servlet, filter, and error page mappings
                └── views/                # Protected JSP View Templates
                    ├── admin/            # Dashboard, Orders, Products, Accounts
                    ├── auth/             # Login & Register views
                    ├── fragments/        # Modular components (navbar, footer, chart, pagination)
                    ├── cart.jsp
                    ├── checkout.jsp
                    ├── home.jsp
                    ├── myorder.jsp
                    ├── product-detail.jsp
                    ├── search.jsp
                    └── wishlist.jsp
```

---

## 🗄️ Database Schema & SQLite Management

The application stores all relational data in SQLite (`WEB-INF/database.sqlite`). When deployed on Tomcat, `Database.java` automatically detects the context path and connects via `org.sqlite.JDBC`.

### Main Tables
- `users`: ID, name, username, email, password (BCrypt), role (`Creator`, `Administrator`, `Customer`), timestamps.
- `categories`: ID, name, slug, timestamps.
- `products`: ID, name, slug, price, category, image, second_image, description, timestamps.
- `carts`: ID, user_id, product_id, quantity, timestamps.
- `wishlists`: ID, user_id, product_id, timestamps.
- `orders`: ID, order_number, user_id, product_id, product_name, price, customer_email, status, timestamps.

You can inspect or query the database directly using `sqlite3`:
```bash
sqlite3 src/main/webapp/WEB-INF/database.sqlite "SELECT name, email, role FROM users;"
```

---

## 👥 Role Hierarchy & Demo Accounts

The application implements a strict 3-tier role hierarchy:
1. **Creator (`Creator`)**:
   - Master account. Has full access to Admin Panel, orders, inventory, and accounts.
   - Can manage and change roles of Administrators and Customers.
   - Can view and manage other Creator accounts.
2. **Administrator (`Administrator`)**:
   - Manages products, categories, orders, and customer accounts.
   - **Pyramid Hierarchy Protection**: Administrators *cannot* edit, demote, or delete Creator accounts (Creator rows display a `Locked` badge).
   - Cannot delete their own account (`You` badge).
3. **Customer (`Customer`)**:
   - Access to storefront, product filtering, shopping cart, checkout, order history, and wishlist.

### Pre-configured Accounts
| Role | Email | Password | Access Level |
| :--- | :--- | :--- | :--- |
| **Creator** | `creator@mijusan.com` | `Mijusan2910@)` | Full access, manage all users |
| **Administrator** | `admin@mijusan.com` | `password` | Store administration & operations |
| **Customer** | `sarah.smith@example.com` | `password` | Storefront shopper |
| **Customer** | `david.miller@example.com` | `password` | Storefront shopper |

---

## 🔄 CRUD Features Overview

The application features 8 complete CRUD modules:

1. **Product CRUD (`/admin/product`)**:
   - **Create**: Add new product with pricing, category, and images (`/admin/add-product`).
   - **Read**: Admin inventory listing with pagination and search.
   - **Update**: Edit product name, category, price, images, and descriptions (`/admin/edit-product?id=X`).
   - **Delete**: Soft/hard removal of inventory items with automatic cascade clean-up.

2. **Category & Catalog Filtering (`/category/*`, `/search`)**:
   - **Create / Read**: Dynamic category routing (`top`, `outer`, `bottom`).
   - **Update / Filter**: Dynamic category navigation and keyword matching.

3. **Shopping Cart CRUD (`/cart`)**:
   - **Create**: Instant AJAX or standard addition to cart with responsive badge counter.
   - **Read**: Itemized shopping cart view with subtotals.
   - **Update**: Dynamic quantity updates.
   - **Delete**: Item removal and cart clearing.

4. **Wishlist CRUD (`/wishlist`)**:
   - **Create / Delete**: Toggle product favoriting directly from product cards or detail pages.
   - **Read**: Customer wishlist overview.

5. **Order Management CRUD (`/admin/order`, `/myorder`)**:
   - **Create**: Instant checkout and cart batch checkout.
   - **Read**: Order history for customers; paginated master order book for admins.
   - **Update**: Admin status modification (`completed`, `processing`, `cancelled`).
   - **Delete**: Removal of archived orders.

6. **Account Management CRUD (`/admin/account`)**:
   - **Create**: Register new administrators or users (`/admin/add-user`).
   - **Read**: User table with roles and creation timestamps.
   - **Update**: Role change modal (`Customer` ↔ `Administrator` ↔ `Creator`).
   - **Delete**: Remove user accounts with self-deletion and creator protection.

7. **Authentication & Session (`/login`, `/register`, `/logout`)**:
   - Customer registration, session initialization, BCrypt verification, and secure session invalidation.

8. **Dynamic Order Analytics Visualizer (`/admin/dashboard`, `/admin/order`)**:
   - Real-time SVG chart visualizer calculating trend polylines, fill gradients, and hover tooltips across 5 dynamic time ranges (`7d`, `1m`, `3m`, `6m`, `1y`).

---

## 📱 Mobile & Responsive Optimization

The user interface has been optimized for mobile displays (including small 320px–390px viewports):
- **Responsive Header & Search**: Compact search bar and glass pill layout on smaller screens.
- **Adaptive Hero Banners & Carousels**: Proportional scaling on touch devices to avoid vertical distortion.
- **Two-Column Product Grid**: Product thumbnails, typography, and prices scale to fit mobile widths cleanly.
- **Mobile-Friendly Pagination**: Collapses multi-page numeric lists on mobile into clean, thumb-friendly **Previous / Next** controls with page indicators, preventing layout breaks.
- **Collapsible Admin Navigation**: Sidebar collapses into a mobile hamburger menu on phones and tablets.

---

## 🔧 Troubleshooting & Common Issues

### 1. `Address already in use: bind` (Port 8080)
If Tomcat fails to start because port 8080 is occupied:
```bash
# Find and terminate the process holding port 8080
fuser -k 8080/tcp

# Retry running Tomcat
./run.sh
```

### 2. Maven Fails with `Cannot resolve dependencies`
The environment runs fully offline using local artifacts. Ensure you execute Maven with `./mvnw` instead of a system `mvn`, or pass the offline flag:
```bash
./mvnw -o -DskipTests package
```

### 3. Changes in JSP or Java Not Updating
Tomcat caches deployed WAR files in `.tomcat/webapps/ROOT/`. Run `./run.sh` to trigger a clean repackage and deployment, or manually delete the exploded directory:
```bash
rm -rf .tomcat/webapps/ROOT .tomcat/webapps/ROOT.war
./run.sh
```

### 4. Database Reset
To restore the database to its pristine demo state, simply copy the pre-seeded SQLite file:
```bash
cp src/main/webapp/WEB-INF/database.sqlite .tomcat/webapps/ROOT/WEB-INF/database.sqlite
```

---

## 📄 License & Credits
Built for academic and demonstration purposes. All rights reserved.
- **Live URL**: [https://mijusan-76f5f.containers.snapdeploy.app/](https://mijusan-76f5f.containers.snapdeploy.app/)
- **Original Concept**: Mijusan Store
- **Architecture**: Jakarta EE 10 (Servlet 6.0, JSP 3.1, JSTL 3.0), Java 17+, Apache Tomcat 10.1, SQLite, Docker.
