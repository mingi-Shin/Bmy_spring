<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Simple Shopping Mall</title>
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
            <h2>쇼핑몰에 오신 것을 환영합니다!</h2>
            <p>이 사이트는 서블릿과 JSP를 이용한 간단한 쇼핑몰 실습 사이트입니다.</p>
            <p>상단 메뉴를 통해 상품 목록을 확인하고, 장바구니에 담아 구매해보세요.</p>
            
            <div>
                <h3>바로가기</h3>
                <ul>
                    <li><a href="ProductListServlet">상품 목록 보기</a></li>
                </ul>
            </div>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 Simple Shopping Mall</p>
    </footer>
</body>
</html>