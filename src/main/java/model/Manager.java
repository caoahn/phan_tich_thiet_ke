/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;
import java.util.Date;
/**
 *
 * @author ADMIN
 */
public class Manager extends Member {
    private int id;
    private String managerCode;
    private String username;

    public Manager() {
        super();
    }

    public Manager(String username, String password, String address, Date birthday, String email, String phone, String role, int id, String managerCode, String username1) {
        super(username, password, address, birthday, email, phone, role);
        this.id = id;
        this.managerCode = managerCode;
        this.username = username1;
    }

    public String getManagerCode() {
        return managerCode;
    }

    public void setManagerCode(String managerCode) {
        this.managerCode = managerCode;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public void setUsername(String username) {
        this.username = username;
    }
}