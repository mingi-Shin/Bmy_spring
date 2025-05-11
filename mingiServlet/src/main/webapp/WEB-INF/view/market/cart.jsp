<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니 - Simple Shopping Mall</title>
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
        tr:hover {
            background-color: #f5f5f5;
        }
        .product-image {
            width: 80px;
            height: auto;
        }
        .quantity-input {
            width: 50px;
            padding: 5px;
        }
        .btn {
            display: inline-block;
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 3px;
            margin-right: 5px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-update {
            background-color: #2196F3;
        }
        .btn-update:hover {
            background-color: #0b7dda;
        }
        .btn-remove {
            background-color: #f44336;
        }
        .btn-remove:hover {
            background-color: #da190b;
        }
        .cart-summary {
            margin-top: 20px;
            text-align: right;
        }
        .cart-total {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0;
        }
        .action-buttons {
            margin-top: 20px;
            text-align: right;
        }
        .btn-checkout {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #e53935;
        }
        .btn-checkout:hover {
            background-color: #c62828;
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
            <h2>장바구니</h2>
            
            <c:if test="${not empty cart && not empty cart.items}">
                <form action="UpdateCartServlet" method="post">
                    <table>
                        <thead>
                            <tr>
                                <th>상품 이미지</th>
                                <th>상품명</th>
                                <th>가격</th>
                                <th>수량</th>
                                <th>소계</th>
                                <th>액션</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cart.items}" varStatus="status">
                                <tr>
                                    <td>
                                        <img src="images/${item.product.image}" alt="${item.product.name}" class="product-image">
                                    </td>
                                    <td>${item.product.name}</td>
                                    <td>
                                        <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₩" />
                                    </td>
                                    <td>
                                        <input type="hidden" name="productId" value="${item.product.id}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.stock}" class="quantity-input">
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${item.product.price * item.quantity}" type="currency" currencySymbol="₩" />
                                    </td>
                                    <td>
                                        <button type="submit" name="action" value="update" class="btn btn-update">수정</button>
                                        <a href="RemoveFromCartServlet?id=${item.product.id}" class="btn btn-remove">삭제</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </form>
                
                <div class="cart-summary">
                    <div class="cart-total">
                        총액: <fmt:formatNumber value="${cart.totalPrice}" type="currency" currencySymbol="₩" />
                    </div>
                    <div class="action-buttons">
                        <a href="ProductListServlet" class="btn">계속 쇼핑하기</a>
                        <a href="CheckoutServlet" class="btn btn-checkout">결제하기</a>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${empty cart || empty cart.items}">
                <p>장바구니가 비어 있습니다.</p>
                <a href="ProductListServlet" class="btn">쇼핑 계속하기</a>
            </c:if>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 Simple Shopping Mall</p>
    </footer>
</body>
</html>