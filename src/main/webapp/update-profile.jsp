<%@ page import="com.onlinepharmacy.model.RegularUser" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
<%
    RegularUser user = (RegularUser) session.getAttribute("currentUser");
    if (user != null && "Regular".equals(user.getRole())) {
%>
<div class="flex w-full max-w-3xl bg-transparent">

    <!-- Profile Update Card -->
    <div class="flex-1 bg-white rounded-2xl shadow-xl px-12 py-12 relative flex flex-col justify-between">
        <div>
            <h1 class="text-6xl font-extrabold mb-10 tracking-tight">Profile</h1>
            <form action="userDashboard.jsp" method="post" class="flex gap-8 items-start">
                <div class="flex-1 space-y-6">
                    <div>
                        <div class="text-xs text-gray-400 tracking-widest mb-1">USER NAME</div>
                        <input type="text" id="username" name="username" value="<%= user.getUsername() %>" disabled
                               class="bg-transparent font-semibold text-lg text-gray-700 border-b border-gray-200 pb-1 w-full outline-none cursor-not-allowed" />
                    </div>
                    <div>
                        <div class="text-xs text-gray-400 tracking-widest mb-1">E-MAIL</div>
                        <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required
                               class="bg-transparent font-medium text-gray-700 border-b border-gray-200 pb-1 w-full outline-none" />
                    </div>
                    <div>
                        <div class="text-xs text-gray-400 tracking-widest mb-1">PASSWORD</div>
                        <input type="password" id="password" name="password" value="<%= user.getPassword() %>" required
                               class="bg-transparent font-medium text-gray-700 border-b border-gray-200 pb-1 w-full outline-none" />
                    </div>
                    <div>
                        <div class="text-xs text-gray-400 tracking-widest mb-1">ADDRESS</div>
                        <input type="text" id="address" name="address" value="<%= user.getAddress() %>" required
                               class="bg-transparent font-medium text-gray-700 border-b border-gray-200 pb-1 w-full outline-none" />
                    </div>
                    <div>
                        <div class="text-xs text-gray-400 tracking-widest mb-1">CONTACT</div>
                        <input type="text" id="contact" name="contact" value="<%= user.getContact() %>" required
                               class="bg-transparent font-medium text-gray-700 border-b border-gray-200 pb-1 w-full outline-none" />
                    </div>
                </div>
                <div class="flex flex-col items-center">
                    <div class="relative">
                        <!-- Default profile image -->
                        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile"
                             class="w-36 h-36 rounded-full object-cover border-4 border-white shadow-lg bg-blue-100">
                        <label for="profileImage" class="absolute bottom-2 right-2 bg-white rounded-full p-2 shadow cursor-pointer border border-gray-200">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2" fill="none"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 10l4.553 4.553a1.5 1.5 0 01-2.121 2.121L10 12.707" />
                            </svg>
                        </label>
                        <input type="file" id="profileImage" name="profileImage" class="hidden" accept="image/*" />
                    </div>
                </div>
                <!-- Save button for desktop -->
                <button type="submit" class="absolute right-12 bottom-12 px-12 py-3 rounded-lg text-white font-bold text-lg bg-gradient-to-r from-blue-500 to-blue-400 shadow hover:from-blue-600 hover:to-blue-500 transition">SAVE</button>
            </form>
        </div>
    </div>
</div>
<%
    } else {
%>
<div class="bg-white rounded-xl shadow-lg p-10 text-center text-red-500 font-semibold text-lg">
    You are not logged in as a regular user.
</div>
<%
    }
%>
</body>
</html>