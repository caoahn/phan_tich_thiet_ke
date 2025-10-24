/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.Date;

public class Librarian extends Member{
    private int id;
    private String librarianCode;
    private String username;

    public Librarian() {
        super();
    }

    public Librarian(String username, String password, String address, Date birthday, String email, String phone, String role, int id, String librarianCode, String username1) {
        super(username, password, address, birthday, email, phone, role);
        this.id = id;
        this.librarianCode = librarianCode;
        this.username = username1;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLibrarianCode() {
        return librarianCode;
    }

    public void setLibrarianCode(String librarianCode) {
        this.librarianCode = librarianCode;
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
