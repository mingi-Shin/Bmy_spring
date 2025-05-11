<%-- productList.jsp (상품 목록 페이지) --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 목록 - Simple Shopping Mall</title>
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
            width: 100px;
            height: auto;
        }
        .btn {
            display: inline-block;
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 3px;
        }
        .btn:hover {
            background-color: #45a049;
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
            <h2>상품 목록</h2>
            
            <table>
                <thead>
                    <tr>
                        <th>상품 이미지</th>
                        <th>상품명</th>
                        <th>가격</th>
                        <th>재고</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- JSTL을 사용하여 상품 목록 출력 --%>
                    <c:forEach var="product" items="${productList}">
                        <tr>
                            <td>
                                <img src="images/${product.image}" alt="${product.name}" class="product-image">
                            </td>
                            <td>${product.name}</td>
                            <td>
                                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₩" />
                            </td>
                            <td>${product.stock}</td>
                            <td>
                                <a href="ProductDetailServlet?id=${product.id}" class="btn">상세 보기</a>
                                <a href="AddToCartServlet?id=${product.id}" class="btn">장바구니 담기</a>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <%-- 상품 목록이 없을 경우 --%>
                    <c:if test="${empty productList}">
                        <tr>
                            <td colspan="5" style="text-align: center;">등록된 상품이 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 Simple Shopping Mall</p>
    </footer>
</body>
</html>