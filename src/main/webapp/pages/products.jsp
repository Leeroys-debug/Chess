<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mycompany.controller.ProductServlet" %>
<%@ page import="com.mycompany.controller.ProductServlet.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products - ${initParam.companyName}</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/products-style.css">
</head>
<body>
    <header class="header">
        <nav class="navbar">
            <div class="nav-brand">
                <h1>${initParam.companyName}</h1>
            </div>
            <ul class="nav-menu">
                <li class="nav-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="nav-item active"><a href="${pageContext.request.contextPath}/products">Products</a></li>
                <li class="nav-item"><a href="#">About</a></li>
                <li class="nav-item"><a href="#">Contact</a></li>
            </ul>
        </nav>
    </header>

    <main class="main-content">
        <div class="products-header">
            <div class="container">
                <h2>Our Products</h2>
                <p>Discover our amazing range of ${totalProducts} products</p>
            </div>
        </div>

        <section class="products-section">
            <div class="container">
                <!-- Search and Filter Form -->
                <div class="filter-bar">
                    <form method="post" class="search-form">
                        <input type="text" name="search" placeholder="Search products..." 
                               value="${param.search != null ? param.search : ''}" 
                               class="search-input">
                        <button type="submit" class="search-button">Search</button>
                    </form>
                    
                    <form method="get" class="filter-form">
                        <div class="filter-group">
                            <label for="category">Category:</label>
                            <select id="category" name="category" onchange="this.form.submit()">
                                <option value="all" ${selectedCategory == 'all' ? 'selected' : ''}>All Categories</option>
                                <option value="electronics" ${selectedCategory == 'electronics' ? 'selected' : ''}>Electronics</option>
                                <option value="clothing" ${selectedCategory == 'clothing' ? 'selected' : ''}>Clothing</option>
                                <option value="books" ${selectedCategory == 'books' ? 'selected' : ''}>Books</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label for="sort">Sort by:</label>
                            <select id="sort" name="sort" onchange="this.form.submit()">
                                <option value="name" ${selectedSort == 'name' ? 'selected' : ''}>Name</option>
                                <option value="price" ${selectedSort == 'price' ? 'selected' : ''}>Price</option>
                                <option value="rating" ${selectedSort == 'rating' ? 'selected' : ''}>Rating</option>
                            </select>
                        </div>
                    </form>
                </div>

                <!-- Search Results Info -->
                <c:if test="${not empty searchTerm}">
                    <div class="search-results-info">
                        <p>Search results for: "<strong>${searchTerm}</strong>" (${totalProducts} products found)</p>
                        <a href="${pageContext.request.contextPath}/products" class="clear-search">Clear Search</a>
                    </div>
                </c:if>

                <!-- Products Grid -->
                <div class="products-grid">
                    <%
                        List<Product> productList = (List<Product>) request.getAttribute("products");
                        if (productList != null && !productList.isEmpty()) {
                            for (Product product : productList) {
                    %>
                    <div class="product-card" data-category="<%= product.getCategory() %>">
                        <% if (product.hasDiscount()) { %>
                            <div class="discount-badge">-<%= String.format("%.0f", product.getDiscountPercentage()) %>% OFF</div>
                        <% } %>
                        <div class="product-image">
                            <img src="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' width='200' height='150' viewBox='0 0 200 150'><rect width='200' height='150' fill='%23f0f0f0'/><text x='100' y='75' font-family='Arial' font-size='14' fill='%23666' text-anchor='middle'><%= product.getName() %> Image</text></svg>" 
                                 alt="<%= product.getName() %>">
                        </div>
                        <div class="product-info">
                            <h3 class="product-title"><%= product.getName() %></h3>
                            <p class="product-description"><%= product.getDescription() %></p>
                            <div class="product-rating">
                                <%= product.getRatingStars() %> 
                                <span class="rating-count">(<%= product.getRating() %>/5)</span>
                            </div>
                            <div class="product-price">
                                <span class="current-price">$<%= String.format("%.2f", product.getPrice()) %></span>
                                <% if (product.hasDiscount()) { %>
                                    <span class="original-price">$<%= String.format("%.2f", product.getOriginalPrice()) %></span>
                                <% } %>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/cart">
                                <input type="hidden" name="productId" value="<%= product.getId() %>">
                                <input type="hidden" name="action" value="add">
                                <button type="submit" class="add-to-cart">Add to Cart</button>
                            </form>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <div class="no-products">
                        <h3>No products found</h3>
                        <p>Try adjusting your search or filter criteria.</p>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </section>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 ${initParam.companyName}. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>