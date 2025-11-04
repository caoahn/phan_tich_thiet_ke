/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.Date;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class BorrowSlip {
    private int id;
    private Date borrowDate;
    private Date returnDate;
    private String status;
    private int readerId;
    private List<BorrowSlipDetail> details;
    private Reader reader;

    public BorrowSlip() {
    }

    public BorrowSlip(int id, Date borrowDate, Date returnDate, String status, int readerId) {
        this.id = id;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.status = status;
        this.readerId = readerId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
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

    public List<BorrowSlipDetail> getDetails() {
        return details;
    }

    public void setDetails(List<BorrowSlipDetail> details) {
        this.details = details;
    }

    public Reader getReader() {
        return reader;
    }

    public void setReader(Reader reader) {
        this.reader = reader;
    }

}
