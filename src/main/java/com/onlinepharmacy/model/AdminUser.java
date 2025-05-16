package com.onlinepharmacy.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class AdminUser extends User {
    private List<String> permissions;
    private List<String> activityLog;

    public AdminUser(String employeeId, String username, String password, String email) {
        super(employeeId, username, password, email);
        this.permissions = new ArrayList<>();
        this.activityLog = new ArrayList<>();
    }

    // Corrected getters/setters
    public List<String> getPermissions() { return permissions; }
    public void setPermissions(List<String> permissions) { this.permissions = permissions; }

    public List<String> getActivityLog() { return activityLog; }
    public void setActivityLog(List<String> activityLog) { this.activityLog = activityLog; }

    public void addPermission(String permission) { permissions.add(permission); }
    public void logActivity(String activity) { activityLog.add(activity); }

    // CSV serialization for file storage
    public String toCSV() {
        return String.join(",",
                getEmployeeId(),
                getUsername(),
                getPassword(),
                getEmail(),
                String.join(";", permissions),
                String.join(";", activityLog)
        );
    }

    // Parse from CSV
    public static AdminUser fromCSV(String csv) {
        String[] parts = csv.split(",", 6);
        AdminUser admin = new AdminUser(parts[0], parts[1], parts[2], parts[3]);
        if (parts.length > 4) {
            if (!parts[4].isEmpty())
                admin.setPermissions(new ArrayList<>(Arrays.asList(parts[4].split(";"))));
            if (parts.length > 5 && !parts[5].isEmpty())
                admin.setActivityLog(new ArrayList<>(Arrays.asList(parts[5].split(";"))));
        }
        return admin;
    }
}
