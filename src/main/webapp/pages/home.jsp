<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home Page - ${initParam.companyName}</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home-style.css">
</head>
<body>
    <header class="header">
        <nav class="navbar">
            <div class="nav-brand">
                <h1>${initParam.companyName}</h1>
            </div>
            <ul class="nav-menu">
                <li class="nav-item active"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/products">Products</a></li>
                <li class="nav-item"><a href="#">About</a></li>
                <li class="nav-item"><a href="#">Contact</a></li>
            </ul>
        </nav>
    </header>

    <main class="main-content">
        <section class="hero">
            <div class="hero-content">
                <h2>${welcomeMessage}</h2>
                <p>Join ${visitorCount}+ satisfied customers worldwide</p>
                <a href="${pageContext.request.contextPath}/products" class="cta-button">View Products</a>
            </div>
        </section>

        <section class="features">
            <div class="container">
                <h3>Our Features</h3>
                <div class="feature-grid">
                    <div class="feature-card">
                        <div class="feature-icon">🚀</div>
                        <h4>Fast Service</h4>
                        <p>Quick and efficient service delivery</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">🛡</div>
                        <h4>Secure</h4>
                        <p>Your data is safe with us</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">💡</div>
                        <h4>Innovative</h4>
                        <p>Cutting-edge solutions</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="stats">
            <div class="container">
                <h3>Real-time Statistics</h3>
                <div class="stats-grid">
                    <div class="stat-item">
                        <h4>Current Time</h4>
                        <p>${currentTime}</p>
                    </div>
                    <div class="stat-item">
                        <h4>Server Info</h4>
                        <p><%= application.getServerInfo() %></p>
                    </div>
                    <div class="stat-item">
                        <h4>Servlet Version</h4>
                        <p><%= application.getMajorVersion() %>.<%= application.getMinorVersion() %></p>
                    </div>
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