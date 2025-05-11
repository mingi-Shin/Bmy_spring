<%-- productDetail.jsp (상품 상세 페이지) --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.name} - Simple Shopping Mall</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }
        header {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px 0;
        }
        nav {
            background-color: #444;
            padding: 10px 0;
        }
        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        nav ul li {
            display: inline;
            margin: 0 10px;
        }
        nav ul li a {
            color: #fff;
            text-decoration: none;
        }
        nav ul li a:hover {
            text-decoration: underline;
        }
        .main-content {
            margin-top: 20px;
            min-height: 400px;
        }
        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px 0;
            margin-top: 20px;
        }
        .product-detail {
            display: flex;
            margin-top: 20px;
        }
        .product-image {
            flex: 1;
            padding-right: 20px;
        }
        .product-image img {
            max-width: 100%;
            height: auto;
        }
        .product-info {
            flex: 2;
        }
        .product-price {
            font-size: 24px;
            color: #e53935;
            margin: 10px 0;
        }
        .product-description {
            margin: 20px 0;
            line-height: 1.6;
        }
        .action-buttons {
            margin-top: 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 3px;
            margin-right: 10px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .quantity {
            width: 50px;
            padding: 8px;
            margin-right: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>
    <header>
        <h1>Simple Shopping Mall</h1>
    </header>
    
    <nav>
        <ul>
            <li><a href="index.jsp">홈</a></li>
            <li><a href="ProductListServlet">상품 목록</a></li>
            <li><a href="CartServlet">장바구니</a></li>
            <li><a href="OrderServlet">주문 내역</a></li>
        </ul>
    </nav>
    
    <div class="container">
        <div class="main-content">
            <h2>상품 상세 정보</h2>
            
            <c:if test="${not empty product}">
                <div class="product-detail">
                    <div class="product-image">
                        <img src="images/${product.image}" alt="${product.name}">
                    </div>
                    <div class="product-info">
                        <h3>${product.name}</h3>
                        <div class="product-price">
                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₩" />
                        </div>
                        <div class="product-description">
                            ${product.description}
                        </div>
                        <table>
                            <tr>
                                <th>제조사</th>
                                <td>${product.manufacturer}</td>
                            </tr>
                            <tr>
                                <th>카테고리</th>
                                <td>${product.category}</td>
                            </tr>
                            <tr>
                                <th>재고</th>
                                <td>${product.stock} 개</td>
                            </tr>
                        </table>
                        
                        <div class="action-buttons">
                            <form action="AddToCartServlet" method="post">
                                <input type="hidden" name="productId" value="${product.id}">
                                <label for="quantity">수량:</label>
                                <input type="number" name="quantity" id="quantity" value="1" min="1" max="${product.stock}" class="quantity">
                                <input type="submit" value="장바구니 담기" class="btn">
                                <a href="ProductListServlet" class="btn">상품 목록으로</a>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${empty product}">
                <p>상품 정보를 찾을 수 없습니다.</p>
                <a href="ProductListServlet" class="btn">상품 목록으로</a>
            </c:if>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 Simple Shopping Mall</p>
    </footer>
</body>
</html>