<%-- orderDetail.jsp (주문 상세 페이지) --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 상세 - Simple Shopping Mall</title>
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
        .order-detail {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 20px;
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #ddd;
            padding-bottom: 15px;
            margin-bottom: 15px;
        }
        .order-id {
            font-size: 18px;
            font-weight: bold;
        }
        .order-date {
            color: #666;
        }
        .order-status {
            background-color: #4CAF50;
            color: white;
            padding: 5px 10px;
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
        .order-section {
            margin-bottom: 20px;
        }
        .section-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
            padding-bottom: 5px;
            border-bottom: 1px solid #eee;
        }
        .info-row {
            display: flex;
            margin-bottom: 5px;
        }
        .info-label {
            width: 150px;
            font-weight: bold;
        }
        .info-value {
            flex: 1;
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
        .product-image {
            width: 80px;
            height: auto;
        }
        .order-total {
            font-size: 18px;
            font-weight: bold;
            text-align: right;
            margin-top: 20px;
            padding-top: 10px;
            border-top: 2px solid #ddd;
        }
        .btn {
            display: inline-block;
            padding: 8px 15px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 3px;
            margin-right: 10px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-cancel {
            background-color: #f44336;
        }
        .btn-cancel:hover {
            background-color: #d32f2f;
        }
        .action-buttons {
            margin-top: 20px;
            text-align: right;
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
            <h2>주문 상세 정보</h2>
            
            <c:if test="${not empty order}">
                <div class="order-detail">
                    <div class="order-header">
                        <div class="order-id">주문번호: ${order.id}</div>
                        <div class="order-date">
                            <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                        </div>
                        <div class="order-status ${order.status == '배송완료' ? 'status-completed' : (order.status == '주문취소' ? 'status-cancelled' : 'status-pending')}">
                            ${order.status}
                        </div>
                    </div>
                    
                    <div class="order-section">
                        <div class="section-title">주문 상품</div>
                        <table>
                            <thead>
                                <tr>
                                    <th>상품 이미지</th>
                                    <th>상품명</th>
                                    <th>가격</th>
                                    <th>수량</th>
                                    <th>소계</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${order.items}">
                                    <tr>
                                        <td>
                                            <img src="images/${item.product.image}" alt="${item.product.name}" class="product-image">
                                        </td>
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
                    </div>
                    
                    <div class="order-section">
                        <div class="section-title">배송 정보</div>
                        <div class="info-row">
                            <div class="info-label">수령인</div>
                            <div class="info-value">${order.recipientName}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">연락처</div>
                            <div class="info-value">${order.phone}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">배송지 주소</div>
                            <div class="info-value">${order.shippingAddress}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">우편번호</div>
                            <div class="info-value">${order.zipcode}</div>
                        </div>
                    </div>
                    
                    <div class="order-section">
                        <div class="section-title">결제 정보</div>
                        <div class="info-row">
                            <div class="info-label">결제 방법</div>
                            <div class="info-value">${order.paymentMethod}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">결제 상태</div>
                            <div class="info-value">${order.paymentStatus}</div>
                        </div>
                    </div>
                    
                    <div class="order-total">
                        총 결제금액: <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₩" />
                    </div>
                    
                    <div class="action-buttons">
                        <a href="OrderServlet" class="btn">주문 목록으로</a>
                        <c:if test="${order.status != '주문취소' && order.status != '배송완료'}">
                            <a href="CancelOrderServlet?orderId=${order.id}" class="btn btn-cancel" onclick="return confirm('정말로 주문을 취소하시겠습니까?')">주문 취소</a>
                        </c:if>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${empty order}">
                <p>주문 정보를 찾을 수 없습니다.</p>
                <a href="OrderServlet" class="btn">주문 목록으로</a>
            </c:if>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 Simple Shopping Mall</p>
    </footer>
</body>
</html>