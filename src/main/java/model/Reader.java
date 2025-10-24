/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.Date;

public class Reader extends Member {
    private int id;
    private String readerCode;
    private int readerStatisticsId;
    private String username;

    public Reader() {
        super(); 
    }

    public Reader(String username, String password, String address, Date birthday, String email, String phone, String role, int id, String readerCode, int readerStatisticsId, String username1) {
        super(username, password, address, birthday, email, phone, role);
        this.id = id;
        this.readerCode = readerCode;
        this.readerStatisticsId = readerStatisticsId;
        this.username = username1;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getReaderCode() {
        return readerCode;
    }

    public void setReaderCode(String readerCode) {
        this.readerCode = readerCode;
    }

    public int getReaderStatisticsId() {
        return readerStatisticsId;
    }

    public void setReaderStatisticsId(int readerStatisticsId) {
        this.readerStatisticsId = readerStatisticsId;
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