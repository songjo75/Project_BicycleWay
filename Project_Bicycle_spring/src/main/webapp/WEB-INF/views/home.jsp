<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="./include/u_header.jsp" %>
<%@ include file="./include/u_top.jsp" %>

<c:if test="${requestScope.msg != null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<div class="container ms-10 w-100">

  <!-- Carousel -->
  <div id="demo" class="carousel slide w-100" data-bs-ride="carousel">
	
	  <!-- Indicators/dots -->
	  <div class="carousel-indicators">
	    <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
	    <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
	    <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
	    <button type="button" data-bs-target="#demo" data-bs-slide-to="3"></button>
	    <button type="button" data-bs-target="#demo" data-bs-slide-to="4"></button>
	  </div>

      <!-- The slideshow/carousel -->
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img src="imgs/home_main.jpg" alt="" class="d-block w-80">
	    </div>
	    <div class="carousel-item">
	      <img src="imgs/home2.jpg" alt="" class="d-block w-80">
	    </div>
	    <div class="carousel-item">
	      <img src="imgs/home3.png" alt="" class="d-block w-80">
	    </div>
	    <div class="carousel-item">
	      <img src="imgs/home4.jpg" alt="" class="d-block w-80">
	    </div>
	    <div class="carousel-item">
	      <img src="imgs/home5.jpg" alt="" class="d-block w-80">
	    </div>
	  </div>
	
	  <!-- Left and right controls/icons -->
	  <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
	    <span class="carousel-control-prev-icon"></span>
	  </button>
	  <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
	    <span class="carousel-control-next-icon"></span>
	  </button>
 
  </div><br>	  

</div>	

<%@ include file="./include/u_footer.jsp" %>
