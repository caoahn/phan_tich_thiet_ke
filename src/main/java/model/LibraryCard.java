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
public class LibraryCard {
    private int id;
    private Date startDate;
    private Date expiryDate;
    private String status;
    private int readerId;

    public LibraryCard() {
    }

    public LibraryCard(int id, Date startDate, Date expiryDate, String status, int readerId) {
        this.id = id;
        this.startDate = startDate;
        this.expiryDate = expiryDate;
        this.status = status;
        this.readerId = readerId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getReaderId() {
        return readerId;
    }

    public void setReaderId(int readerId) {
        this.readerId = readerId;
    }
    
    
    
}
