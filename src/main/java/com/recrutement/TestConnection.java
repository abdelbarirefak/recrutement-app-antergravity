package com.recrutement;

import com.recrutement.entity.Role;
import com.recrutement.entity.User;
import com.recrutement.service.UserService;

public class TestConnection {
    public static void main(String[] args) {
        
        UserService userService = new UserService();

        // 1. Test Valid User
        try {
            User validUser = new User("service_test@test.com", "strongpass", Role.CANDIDATE);
            userService.registerUser(validUser);
            System.out.println("✅ Valid user registered successfully via Service!");
        } catch (Exception e) {
            System.out.println("❌ Error: " + e.getMessage());
        }

        // 2. Test Invalid User (Short Password) - This simulates Business Logic!
        try {
            User invalidUser = new User("bad_pass@test.com", "123", Role.CANDIDATE);
            userService.registerUser(invalidUser);
        } catch (IllegalArgumentException e) {
            System.out.println("✅ BLOCKED Invalid User as expected: " + e.getMessage());
        }
    }
}