<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.onlinepharmacy.model.User" %>
<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Profile - User Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="mb-4 text-center">User Profile</h2>
                <form action="profile/update" method="post">
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" class="form-control" value="<%= user.getUsername() %>" disabled>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Role</label>
                        <input type="text" class="form-control" value="<%= user.getRole() %>" disabled>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Membership Type</label>
                        <input type="text" class="form-control" value="<%= user.getMembershipType() %>" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email"
                               value="<%= user.getEmail() %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">New Password</label>
                        <input type="password" class="form-control" id="password" name="password"
                               placeholder="Leave blank to keep current password">
                    </div>
                    <button type="submit" class="btn btn-warning w-100">Update Profile</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
