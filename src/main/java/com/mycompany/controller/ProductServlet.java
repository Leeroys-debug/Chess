/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author lonpo
 */@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Sample product data - in real app, this would come from database
    private List<Product> products;

    @Override
    public void init() throws ServletException {
        // Initialize sample products
        products = new ArrayList<>();
        products.add(new Product(1, "Premium Laptop", "High-performance laptop for professionals", 
                                "electronics", 999.99, 1299.99, 4));
        products.add(new Product(2, "Cotton T-Shirt", "Comfortable and stylish cotton t-shirt", 
                                "clothing", 24.99, 0, 5));
        products.add(new Product(3, "Programming Guide", "Comprehensive guide to modern programming", 
                                "books", 39.99, 49.99, 4));
        products.add(new Product(4, "Smartphone Pro", "Latest smartphone with advanced features", 
                                "electronics", 799.99, 0, 4));
        products.add(new Product(5, "Wireless Headphones", "Noise-cancelling wireless headphones", 
                                "electronics", 199.99, 249.99, 5));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String category = request.getParameter("category");
        String sortBy = request.getParameter("sort");
        
        List<Product> filteredProducts = filterProducts(category);
        sortProducts(filteredProducts, sortBy);
        
        // Set attributes for JSP
        request.setAttribute("products", filteredProducts);
        request.setAttribute("selectedCategory", category != null ? category : "all");
        request.setAttribute("selectedSort", sortBy != null ? sortBy : "name");
        request.setAttribute("totalProducts", filteredProducts.size());
        
        // Forward to products JSP
        request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle product search or other POST operations
        String searchTerm = request.getParameter("search");
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            List<Product> searchResults = searchProducts(searchTerm);
            request.setAttribute("products", searchResults);
            request.setAttribute("searchTerm", searchTerm);
        }
        request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
    }

    private List<Product> filterProducts(String category) {
        if (category == null || "all".equals(category)) {
            return new ArrayList<>(products);
        }
        
        List<Product> filtered = new ArrayList<>();
        for (Product product : products) {
            if (category.equals(product.getCategory())) {
                filtered.add(product);
            }
        }
        return filtered;
    }

    private List<Product> searchProducts(String searchTerm) {
        List<Product> results = new ArrayList<>();
        String lowerSearch = searchTerm.toLowerCase();
        
        for (Product product : products) {
            if (product.getName().toLowerCase().contains(lowerSearch) ||
                product.getDescription().toLowerCase().contains(lowerSearch)) {
                results.add(product);
            }
        }
        return results;
    }

    private void sortProducts(List<Product> productList, String sortBy) {
        if (sortBy == null) return;
        
        switch (sortBy) {
            case "price":
                productList.sort((p1, p2) -> Double.compare(p1.getPrice(), p2.getPrice()));
                break;
            case "rating":
                productList.sort((p1, p2) -> Integer.compare(p2.getRating(), p1.getRating()));
                break;
            case "name":
            default:
                productList.sort((p1, p2) -> p1.getName().compareToIgnoreCase(p2.getName()));
                break;
        }
    }

    // Inner Product class
    public static class Product {
        private int id;
        private String name;
        private String description;
        private String category;
        private double price;
        private double originalPrice;
        private int rating;

        public Product(int id, String name, String description, String category, 
                      double price, double originalPrice, int rating) {
            this.id = id;
            this.name = name;
            this.description = description;
            this.category = category;
            this.price = price;
            this.originalPrice = originalPrice;
            this.rating = rating;
        }

        // Getters and setters
        public int getId() { return id; }
        public String getName() { return name; }
        public String getDescription() { return description; }
        public String getCategory() { return category; }
        public double getPrice() { return price; }
        public double getOriginalPrice() { return originalPrice; }
        public int getRating() { return rating; }
        
        public boolean hasDiscount() {
            return originalPrice > 0;
        }
        
        public double getDiscountPercentage() {
            if (!hasDiscount()) return 0;
            return ((originalPrice - price) / originalPrice) * 100;
        }
        
        public String getRatingStars() {
            StringBuilder stars = new StringBuilder();
            for (int i = 0; i < 5; i++) {
                stars.append(i < rating ? "★" : "☆");
            }
            return stars.toString();
        }
    }
}
