<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%
    String reviewId = request.getParameter("reviewId");
    String rating = request.getParameter("rating");
    String comment = request.getParameter("comment");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Your Review</title>
</head>
<body>
    <h1>Edit Review</h1>

    <form action="editReview" method="post">


        <label for="rating">New Rating (1-5):</label><br>
        <input type="number" id="rating" name="rating" min="1" max="5" value="<%= rating %>" required><br><br>

        <label for="comment">Updated Comment:</label><br>
        <textarea id="comment" name="comment" rows="4" cols="40" required><%= comment %></textarea><br><br>

        <input type="submit" value="Update Review">
    </form>

    <br><a href="submitReview">Back to Reviews</a>
</body>
</html>
