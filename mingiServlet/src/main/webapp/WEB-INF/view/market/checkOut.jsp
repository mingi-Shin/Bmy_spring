<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제하기 - Simple Shopping Mall</title>
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
        .order-form {
            margin-top: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-columns {
            display: flex;
            gap: 20px;
        }
        .form-column {
            flex: 1;
        }
        .order-summary {
            margin-top: 20px;
            background-color: #fff;
            padding: 15px;
            border-radius: 3px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .order-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        .order-total {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0;
            text-align: right;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-order {
            background-color: #e53935;
            width: 100%;
            margin-top: 10px;
        }
        .btn-order:hover {
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
            <h2>결제하기</h2>
            
            <c:if test="${not empty cart && not empty cart.items}">
                <div class="order-summary">
                    <div class="order-title">주문 상품 내역</div>
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
                            <c:forEach var="item" items="${cart.items}">
                                <tr>
                                    <td>${item.product.name}</td>
                                    <td>
                                        <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₩" />
                                    </td>
                                    <td>${item.quantity}</td>
                                    <td>
                                        <fmt:formatNumber value="${item.product.price * item.quantity}" type="currency" currencySymbol="₩" />
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="order-total">
                        총 주문금액: <fmt:formatNumber value="${cart.totalPrice}" type="currency" currencySymbol="₩" />
                    </div>
                </div>
                
                <form action="PlaceOrderServlet" method="post" class="order-form">
                    <div class="form-columns">
                        <div class="form-column">
                            <h3>배송 정보</h3>
                            
                            <div class="form-group">
                                <label for="name">이름</label>
                                <input type="text" id="name" name="name" class="form-control" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="phone">연락처</label>
                                <input type="text" id="phone" name="phone" class="form-control" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="address">주소</label>
                                <input type="text" id="address" name="address" class="form-control" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="address2">상세주소</label>
                                <input type="text" id="address2" name="address2" class="form-control">
                            </div>
                            
                            <div class="form-group">
                                <label for="zipcode">우편번호</label>
                                <input type="text" id="zipcode" name="zipcode" class="form-control" required>
                            </div>
                        </div>
                        
                        <div class="form-column">
                            <h3>결제 정보</h3>
                            
                            <div class="form-group">
                                <label for="paymentMethod">결제 방법</label>
                                <select id="paymentMethod" name="paymentMethod" class="form-control" required>
                                    <option value="">선택하세요</option>
                                    <option value="card">신용카드</option>
                                    <option value="bank">계좌이체</option>
                                    <option value="vbank">가상계좌</option>
                                    <option value="phone">휴대폰 결제</option>
                                </select>
                            </div>
                            
                            <div id="card-info" class="payment-details">
                                <div class="form-group">
                                    <label for="cardNumber">카드번호</label>
                                    <input type="text" id="cardNumber" name="cardNumber" class="form-control" placeholder="0000-0000-0000-0000">
                                </div>
                                
                                <div class="form-group">
                                    <label for="cardExpiry">유효기간</label>
                                    <input type="text" id="cardExpiry" name="cardExpiry" class="form-control" placeholder="MM/YY">
                                </div>
                                
                                <div class="form-group">
                                    <label for="cardCvc">CVC</label>
                                    <input type="text" id="cardCvc" name="cardCvc" class="form-control" placeholder="000">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label>
                                    <input type="checkbox" name="agreement" required>
                                    주문 내용을 확인하였으며, 결제에 동의합니다.
                                </label>
                            </div>
                            
                            <button type="submit" class="btn btn-order">결제하기</button>
                        </div>
                    </div>
                </form>
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
    
    <script>
        // 결제 방법에 따라 카드 정보 입력 폼 표시/숨김 처리
        document.getElementById('paymentMethod').addEventListener('change', function() {
            var cardInfo = document.getElementById('card-info');
            if (this.value === 'card') {
                cardInfo.style.display = 'block';
            } else {
                cardInfo.style.display = 'none';
            }
        });
    </script>
</body>
</html>