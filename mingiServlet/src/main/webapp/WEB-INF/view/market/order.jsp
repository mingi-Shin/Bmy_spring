<%-- order.jsp (주문 내역 페이지) --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 내역 - Simple Shopping Mall</title>
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
        .order-list {
            margin-top: 20px;
        }
        .order-item {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            padding: 15px;
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        .order-id {
            font-weight: bold;
        }
        .order-date {
            color: #666;
        }
        .order-status {
            background-color: #4CAF50;
            color: white;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 14px;
        }
        .status-pending {
            background-color: #FFC107;
        }
        .status-completed {
            background-color: #4CAF50;
        }
        .status-cancelled {
            background-color: #F44336;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f9f9f9;
        }
        .order-total {
            font-size: 16px;
            font-weight: bold;
            text-align: right;
            margin-top: 10px;
        }
        .order-address {
            margin-top: 10px;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 3px;
        }
        .order-details-link {
            display: inline-block;
            padding: 5px 10px;
            background-color: #2196F3;
            color: white;
            text-decoration: none;
            border-radius: 3px;
            margin-top: 10px;
        }
        .order-details-link:hover {
            background-color: #0b7dda;
        }
        .no-orders {
            text-align: center;
            padding: 30px;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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
            <h2>주문 내역</h2>
            
            <c:if test="${not empty orderList}">
                <div class="order-list">
                    <c:forEach var="order" items="${orderList}">
                        <div class="order-item">
                            <div class="order-header">
                                <div class="order-id">주문번호: ${order.id}</div>
                                <div class="order-date">
                                    <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                                </div>
                                <div class="order-status ${order.status == '배송완료' ? 'status-completed' : (order.status == '주문취소' ? 'status-cancelled' : 'status-pending')}">
                                    ${order.status}
                                </div>
                            </div>
                            
                            <table>
                                <thead>
                                    <tr>
                                        <th>상품명</th>
                                        <th>가격</th>
                                        <th>수량</th>
                                        <th>소계</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${order.items}">
                                        <tr>
                                            <td>${item.product.name}</td>
                                            <td>
                                                <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₩" />
                                            </td>
                                            <td>${item.quantity}</td>
                                            <td>
                                                <fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="₩" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            
                            <div class="order-total">
                                총 결제금액: <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₩" />
                            </div>
                            
                            <div class="order-address">
                                <strong>배송지 정보:</strong> ${order.shippingAddress}
                            </div>
                            
                            <a href="OrderDetailServlet?orderId=${order.id}" class="order-details-link">주문 상세 보기</a>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            
            <c:if test="${empty orderList}">
                <div class="no-orders">
                    <p>주문 내역이 없습니다.</p>
                    <a href="ProductListServlet" class="order-details-link">쇼핑하러 가기</a>
                </div>
            </c:if>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 Simple Shopping Mall</p>
    </footer>
</body>
</html>